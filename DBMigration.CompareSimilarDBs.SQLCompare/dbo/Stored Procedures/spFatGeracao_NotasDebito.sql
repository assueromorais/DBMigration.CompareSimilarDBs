/* 113295 */ 

CREATE procedure [dbo].[spFatGeracao_NotasDebito](
@IdUnidade int, @NumeroNotaDebito VARCHAR(20)
)
as 
  Declare @CodErro tinyint, @MsgErro varchar(60), @DataEmissao DATETIME, 
          @DataVencimento DATETIME, @IdNotaDebito_Incluido INT, @intPrazoVencNotasDebito INT,
          @IdItemAFaturar INT, @HistoricoMovimentacao varchar(2000), @HistoricoFinal varchar(6000)          
          		     
  Set @CodErro = 0
  Set @MsgErro = 'Atualização com Sucesso.'
   
  ---------------------  Inicio Validação  -----------------------
        
  IF Not Exists (Select 1 from dbo.Unidades where IdUnidade=@IdUnidade) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conselho informado inválido.'
  End
 
  IF (@NumeroNotaDebito IS NULL) 
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Número da Nota de Débito inválido.'
  END
  
  ------------------ Início - Inclusão da Nota de Débito --------------
  IF @CodErro = 0
  BEGIN 	
  	SET @DataEmissao = cast(round(cast(GETDATE() AS float), 0, 1) AS DATETIME)
  	
    	Create table #tabtemp_itens_a_faturar (
		IdItemNotaDebito smallint identity (1,1),
		IdItemProduto int,
		IdTipoInclusao int,
		Qtde real,
		ValorUnitario money)
		
	/*Verificando se existe nota de débito em aberto (Situação Gerada), para a unidade*/	
	Set @IdNotaDebito_Incluido = ISNULL(
			(SELECT FND.IdNotaDebito
			 FROM FatNotasDebito  FND 
			 Where IdUnidade = @IdUnidade and
 		           IdSituacaoNotaDebito = 1), 0)   
 		           
	/*Se não existir nota em aberto, será gerada nova nota de débito*/
    IF @IdNotaDebito_Incluido = 0
	BEGIN
	  	/* Inicializando variáveis*/
		SET @intPrazoVencNotasDebito = (SELECT ISNULL(FATPrazoVencNotasDebito, 0) FROM ConfiguracoesSG)	
		SET @DataVencimento =  DATEADD (day, @intPrazoVencNotasDebito, @DataEmissao) 
    
		/* Incluindo a Nota de Débito*/ 
		Insert into dbo.FatNotasDebito (IdUnidade, IdSituacaoNotaDebito, NumeroNotaDebito, DataEmissao, DataVencimento)
		Values (@IdUnidade, 1, @NumeroNotaDebito, @DataEmissao, @DataVencimento)

		Set @IdNotaDebito_Incluido=@@IDENTITY
	END	

	/****** Incluindo os Itens da Nota de Débito *****/
	
	--Caso a nota já exista, serão inseridos primeiramente os itens já existentes.
	Insert into #tabtemp_itens_a_faturar (IdItemProduto, IdTipoInclusao, Qtde, ValorUnitario)
	SELECT IdItemProduto,IdTipoInclusao,Qtde,ValorUnitario
	FROM dbo.FatItensNotasDebito
	WHERE IdNotaDebito=@IdNotaDebito_Incluido
	ORDER BY IdItemNotaDebito
	
	--Inserindo os novos itens selecionados
	Insert into #tabtemp_itens_a_faturar (IdItemProduto, IdTipoInclusao, Qtde, ValorUnitario)
    Select IdItemProduto,IdTipoInclusao, SUM(Qtde) AS QtdTotalItem,
	ValorVenda = Case 
	      when FIF.IdTipoInclusao in (1,2) then (Select ValorVenda from Itens where Itens.IdItem = FIF.IdItemProduto)
          else (Select ValorVenda from FatProdutosEspeciais FPE where FPE.IdProduto = FIF.IdItemProduto) end
	from FatItensAFaturar FIF
	where IdUnidade = @IdUnidade and IdSituacaoItemAFaturar = 2
	group by IdItemProduto,IdTipoInclusao

	/*Preparando a tabela com os itens a faturar atualizados, para que possa limpar os ids dos itens da nota de débito
	que estão na tabela de itens a faturar, antes de serem apagados.
	Desta forma, os ids dos itens a faturar que deverão ser atualizados posteriormente, já estarão nesta tabela temporária */ 
	CREATE TABLE #Tabtemp_itens_a_faturar_atualizados (IdItemAFaturar INT, IdItemProduto INT, IdTipoInclusao INT)
	
	INSERT INTO #Tabtemp_itens_a_faturar_atualizados (IdItemAFaturar,IdItemProduto,IdTipoInclusao)
	SELECT IdItemAFaturar,IdItemProduto,IdTipoInclusao
	FROM dbo.FatItensAFaturar
	WHERE IdNotaDebito = @IdNotaDebito_Incluido

	INSERT INTO #Tabtemp_itens_a_faturar_atualizados (IdItemAFaturar,IdItemProduto,IdTipoInclusao)
	SELECT IdItemAFaturar,IdItemProduto,IdTipoInclusao
	FROM FatItensAFaturar FIF
	WHERE IdUnidade = @IdUnidade and IdSituacaoItemAFaturar = 2
	
	UPDATE 	dbo.FatItensAFaturar SET
	IdNotaDebito=NULL,
	IdItemNotaDebito=NULL
	FROM dbo.FatItensAFaturar t1,
		 #Tabtemp_itens_a_faturar_atualizados t2
	WHERE t1.IdItemAFaturar=t2.IdItemAFaturar
	
	--apagando os itens já existentes
	DELETE dbo.FatItensNotasDebito
	FROM dbo.FatItensNotasDebito
	WHERE IdNotaDebito=@IdNotaDebito_Incluido
	
	--Inserindo finalmente na tabela de itensNotasDebito, os antigos e novos itens, já agrupados.
	Insert into dbo.FatItensNotasDebito (IdNotaDebito,IdItemNotaDebito,IdItemProduto,IdTipoInclusao, Qtde, ValorUnitario)
	SELECT @IdNotaDebito_Incluido, Min(IdItemNotaDebito), IdItemProduto, IdTipoInclusao, SUM(Qtde), MIN(ValorUnitario)
	FROM #tabtemp_itens_a_faturar
	GROUP BY IdItemProduto, IdTipoInclusao	
  
    /****** Atualizando as demais tabelas *****/
    
    /* Concatenando os Históricos dos itens a faturar para o Histórico da Solicitação da Nota de Débito */   
    DECLARE ItensAFaturarAtualizados_Cursor
		CURSOR FAST_FORWARD FOR
		SELECT HistoricoMovimentacao = CASE WHEN T2.NumeroPedido IS NULL THEN T2.HistoricoMovimentacao ELSE 'Nota Fiscal Nº: ' + ISNULL(PCI.NotaFiscal,'') END
		FROM #Tabtemp_itens_a_faturar_atualizados T1,
			  FatItensAFaturar T2 LEFT JOIN
              PedidosCedulaIdentidadeProfissional PCI ON T2.NumeroPedido = PCI.NumeroPedido
		WHERE T1.IdItemAFaturar=T2.IdItemAFaturar AND
		      HistoricoMovimentacao IS NOT NULL
		ORDER BY T2.DataPedido
			
		OPEN ItensAFaturarAtualizados_Cursor
		FETCH NEXT FROM ItensAFaturarAtualizados_Cursor
		INTO @HistoricoMovimentacao

	SET @HistoricoFinal = ''

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @HistoricoFinal = ''
		  SET @HistoricoFinal = @HistoricoMovimentacao
		ELSE
		BEGIN
		  IF CHARINDEX(@HistoricoMovimentacao,@HistoricoFinal) = 0 /*Evitando duplicidade*/
			SET @HistoricoFinal = @HistoricoFinal + CHAR(13) + CHAR(10) + @HistoricoMovimentacao
		END
	
		FETCH NEXT FROM ItensAFaturarAtualizados_Cursor
		INTO @HistoricoMovimentacao
	END
	CLOSE ItensAFaturarAtualizados_Cursor
	DEALLOCATE ItensAFaturarAtualizados_Cursor

        
    /*Atualizando o Valor Total da Nota e o Histórico*/
    Update dbo.FatNotasDebito Set
	ValorTotalNota = (SELECT SUM(Qtde * ValorUnitario) FROM dbo.FatItensNotasDebito find WHERE find.IdNotaDebito = @IdNotaDebito_Incluido),
    HistoricoSolicitacao = @HistoricoFinal	 
    WHERE IdNotaDebito = @IdNotaDebito_Incluido
    
  	/*Atualizando os Itens A Faturar*/	
	UPDATE dbo.FatItensAFaturar SET
	IdNotaDebito=T1.IdNotaDebito,
	IdItemNotaDebito=T1.IdItemNotaDebito,
	DataFaturamento = @DataEmissao,
    IdSituacaoItemAFaturar = 3 -- Situação = Faturado
	FROM dbo.FatItensNotasDebito T1,
	     #Tabtemp_itens_a_faturar_atualizados T2,
	      dbo.FatItensAFaturar T3
	WHERE T1.IdNotaDebito = @IdNotaDebito_Incluido AND
	      T1.IdItemProduto=T2.IdItemProduto AND
	      T1.IdTipoInclusao=T2.IdTipoInclusao AND
	      T2.IdItemAFaturar=T3.IdItemAFaturar


	Set @MsgErro = 'Nota de Débito gerada com sucesso.'		 
  END
   
--------------------- Retornando o Resultado ---------------------

Select CodErro=@CodErro, MsgErro=@MsgErro, IdNotaIncluido=@IdNotaDebito_Incluido 
