CREATE PROCEDURE [dbo].[uspImportaDadosPessoa]
    @IdOrigem INT,
	@IdDestino INT,
	@Tipo VARCHAR(2),
	@DadosCadastrais BIT
AS
DECLARE @NumeroPendenciasExclusao   INT,
        @Nome                       VARCHAR(120),
        @E_Fiscal                   BIT,
        @CNPJCPF                    VARCHAR(14),
        @RG                         VARCHAR(28),
        @DataRegistro               DATETIME,
        @Endereco                   VARCHAR(60),
        @NomeBairro                 VARCHAR(40),
        @NomeCidade                 VARCHAR(40),
        @SiglaUF                    VARCHAR(2),
        @CEP                        VARCHAR(8),
        @Codigo                     VARCHAR(5),
        @NumeroProcesso             VARCHAR(10),
        @Site                       VARCHAR(250),
        @Atualizado                 BIT,
        @DataUltimaAtualizacao      DATETIME,
        @UsuarioUltimaAtualizacao   VARCHAR(35),
        @DeptoUltimaAtualizacao     VARCHAR(60),
        @Observacoes                VARCHAR(8000),
        @Telefone                   VARCHAR(50),
        @Email                      VARCHAR(60),
        @CapitalSocial              MONEY,
        -- campos do novo precadastro
        @Email2                     VARCHAR(60),
        @TelefoneTrabalho           VARCHAR(60),
        @Celular                    VARCHAR(60),
        @RecadoFax                  VARCHAR(60),
        @Complemento                VARCHAR(50),
        @ECEndereco                 VARCHAR(60),
        @ECComplemento              VARCHAR(60),
        @ECBairro                   VARCHAR(40),
        @ECCidade                   VARCHAR(40),
        @ECUF                       VARCHAR(2),
        @ECCEP                      VARCHAR(8),
        @RGDataEmissao              DATETIME,
        @RGOrgaoExpediror           VARCHAR(20),
        @RGUF                       VARCHAR(2),
        @RNE                        VARCHAR(20),
        @Naturalidade               VARCHAR(50),
        @NaturalidadeUF             VARCHAR(2),
        @Nacionalidade              VARCHAR(50),
        @NomePai                    VARCHAR(50),
        @NomeMae                    VARCHAR(50),
        @EstadoCivil                VARCHAR(30),
        @TENumero                   VARCHAR(20),
        @TEZona                     VARCHAR(20),
        @TESessao                   VARCHAR(20),
        @TEDataEmissao              DATETIME,
        @CarteiraReservista         VARCHAR(20),
        @CarteiraReservistaEmissao  DATETIME,
        @CSM                        VARCHAR(20),
        @Universidade               VARCHAR(60),
        @CursoHabilitacao           VARCHAR(60),
        @DataColacao                DATETIME,
        @DocumentoApresentado       VARCHAR(50),
        @TipoInscricao              VARCHAR(50),
        @MotivoInscricao            VARCHAR(50),
        @SenhaPreCadastro           VARCHAR(50),
        @CategoriaDataInicio        DATETIME,
        @IdCategoria                INT,
        @IdTipoInscricao            INT,
        @IdMotivoInscricao          INT,
        @Sigla                      VARCHAR(15),
        @NomeFantasia               VARCHAR(50),
        @InscricaoEstadual          VARCHAR(20),
        @IdCursoEvento              INT,
        @IdPessoa                   INT,
        @SQL                        VARCHAR(8000),
        @CampoEndereco              VARCHAR(20),
        @DataNascimento				DATETIME,
        @ImportarEndereco           BIT,
        @ImportarEnderecoEC         BIT
        
IF EXISTS(
	   SELECT TOP 1 1
	   FROM   Pessoas,
			  ParametrosSiscafW
	   WHERE  E_ConselhoProfissao = 1
			  AND IdPessoa = IdConselhoCorrente
			  AND (Sigla = 'CRA/SP' OR sigla LIKE 'CRP%')
   )
	SET @CampoEndereco = 'Endereco1'
ELSE
	SET @CampoEndereco = 'Endereco'    

/* pega os dados de origem da pessoa */
SELECT @Nome = p.Nome,
       @E_Fiscal = p.E_Fiscal,
       @CNPJCPF = p.CNPJCPF,
       @DataRegistro = p.DataRegistro,
       @Endereco = Replace(p.Endereco, CHAR(39),'`'),
       @NomeBairro = Replace(p.NomeBairro, CHAR(39),'`') ,
       @NomeCidade = Replace(p.NomeCidade, CHAR(39),'`'),
       @SiglaUF = p.SiglaUF,
       @CEP = p.CEP,
       @RG = p.RG,
       @Codigo = p.Codigo,
       @NumeroProcesso = p.NumeroProcessoPessoas,
       @Site = p.[Site],
       @Atualizado = p.Atualizado,
       @DataUltimaAtualizacao = p.DataUltimaAtualizacaoEnd,
       @UsuarioUltimaAtualizacao = p.UsuarioUltimaAtualizacaoEnd,
       @DeptoUltimaAtualizacao = p.DeptoUltimaAtualizacaoEnd,
       @Observacoes = p.Observacoes,
       @Telefone = p.Telefone,
       @Email = p.Email,
       @CapitalSocial = p.CapitalSocial,
       -- campos precadastro 
       @Email2 = p.Email2,
       @TelefoneTrabalho = p.TelefoneTrabalho,
       @Celular = p.Celular,
       @RecadoFax = p.RecadoFax,
       @Complemento = Replace(p.Complemento, CHAR(39),'`'),
       @ECEndereco = Replace(p.ECEndereco, CHAR(39),'`'),
       @ECComplemento = Replace(p.ECComplemento, CHAR(39),'`'),
       @ECBairro = Replace(p.ECBairro, CHAR(39),'`'),
       @ECCidade = Replace(p.ECCidade, CHAR(39),'`'),
       @ECUF = p.ECUF,
       @ECCEP = p.ECCEP,
       @RGDataEmissao = p.RGDataEmissao,
       @RGOrgaoExpediror = p.RGOrgaoExpediror,
       @RGUF = p.RGUF,
       @RNE = p.RNE,
       @Naturalidade = p.Naturalidade,
       @NaturalidadeUF = p.NaturalidadeUF,
       @Nacionalidade = p.Nacionalidade,
       @NomePai = p.NomePai,
       @NomeMae = p.NomeMae,
       @EstadoCivil = p.EstadoCivil,
       @TENumero = p.TENumero,
       @TEZona = p.TEZona,
       @TESessao = p.TESessao,
       @TEDataEmissao = p.TEDataEmissao,
       @CarteiraReservista = p.CarteiraReservista,
       @CarteiraReservistaEmissao = p.CarteiraReservistaEmissao,
       @CSM = p.CSM,
       @Universidade = p.Universidade,
       @CursoHabilitacao = p.CursoHabilitacao,
       @DataColacao = p.DataColacao,
       @DocumentoApresentado = p.DocumentoApresentado,
       @TipoInscricao = p.TipoInscricao,
       @MotivoInscricao = p.MotivoInscricao,
       @SenhaPreCadastro = p.SenhaPreCadastro,
       @CategoriaDataInicio = p.CategoriaDataInicio,
       @IdCategoria = p.IdCategoria,
       @IdTipoInscricao = p.IdTipoInscricao,
       @IdMotivoInscricao = p.IdMotivoInscricao,
       @DataNascimento = p.DataAniversario
FROM   Pessoas p
WHERE  p.IdPessoa = @IdOrigem

SET @ImportarEndereco   = CASE WHEN (@CEP   <> '') AND (@Endereco   <> '') AND (@SiglaUF <> '') AND (@NomeCidade <> '') THEN 1 ELSE 0 END
SET @ImportarEnderecoEC = CASE WHEN (@ECCEP <> '') AND (@ECEndereco <> '') AND (@ECUF    <> '') AND (@ECCidade   <> '') THEN 1 ELSE 0 END 

IF @ImportarEndereco = 0   
	SELECT @CEP        = NULL, 
	       @Endereco   = NULL, 
	       @SiglaUF    = NULL, 
	       @NomeCidade = NULL, 
	       @NomeBairro = NULL,
		   @DataUltimaAtualizacao    = NULL,
           @UsuarioUltimaAtualizacao = NULL,
           @DeptoUltimaAtualizacao   = NULL

IF @ImportarEnderecoEC = 0
	SELECT @ECCEP      = NULL, 
	       @ECEndereco = NULL, 
	       @ECUF       = NULL, 
	       @ECCidade   = NULL, 
	       @ECBairro   = NULL,
		   @DataUltimaAtualizacao    = NULL,
           @UsuarioUltimaAtualizacao = NULL,
           @DeptoUltimaAtualizacao   = NULL

IF (@Tipo = 'PF')	   
BEGIN
	IF (@DadosCadastrais = 1)
	BEGIN
		IF NOT EXISTS(SELECT TOP 1 1 FROM Nacionalidades n WHERE N.Nacionalidade = @Nacionalidade) AND (@Nacionalidade IS NOT NULL)
			INSERT INTO Nacionalidades(Nacionalidade)VALUES(@Nacionalidade)
	    
		IF NOT EXISTS(SELECT TOP 1 1 FROM Cidades c WHERE c.NomeCidade = @Naturalidade) AND (@Naturalidade IS NOT NULL)
			INSERT INTO Cidades(NomeCidade)VALUES(@Naturalidade)
	    
		UPDATE Profissionais
		SET    Nome = @Nome,
			   E_Fiscal = @E_Fiscal,
			   CPF = @CNPJCPF,
			   DataInscricaoConselho = @DataRegistro,
			   Endereco = @Endereco,
			   NomeBairro = @NomeBairro,
			   NomeCidade = @NomeCidade,
			   SiglaUF = @SiglaUF,
			   CEP = @CEP,
			   Codigo = @Codigo,
			   Processo = @NumeroProcesso,
			   [Site] = @Site,
			   Atualizado = @Atualizado,
			   DataUltimaAtualizacao = @DataUltimaAtualizacao,
			   Observacoes = @Observacoes,
			   EnderecoEMail = @Email,
			   EnderecoEMail2 = @Email2,
			   TelefoneResid = @Telefone,
			   TelefoneTrab = @TelefoneTrabalho,
			   TelefoneCelular = @Celular,
			   TelefoneOutros = @RecadoFax,
			   ComplementoEndereco = @Complemento,
			   RG = @RG,
			   RGDataEmissao = @RGDataEmissao,
			   RGOrgaoEmissao = @RGOrgaoExpediror,
			   SiglaUFRG = @RGUF,
			   RNE = @RNE,
			   IdCidadeNaturalidade = (SELECT TOP 1 c.IdCidade FROM Cidades c WHERE c.NomeCidade = @Naturalidade ORDER BY Desativado DESC),
			   SiglaUFNaturalidade = @NaturalidadeUF,
			   IdNacionalidade = (SELECT TOP 1 n.IdNacionalidade FROM Nacionalidades n WHERE n.Nacionalidade = @Nacionalidade  ORDER BY Desativado DESC),
			   NomePai = @NomePai,
			   NomeMae = @NomeMae,
			   EstadoCivil = @EstadoCivil,
			   TituloEleitorInscricao = @TENumero,
			   TituloEleitorZona = @TEZona,
			   TituloEleitorSecao = @TESessao,
			   TituloEleitorDataEmissao = @TEDataEmissao,
			   CertificadoReserv = @CarteiraReservista,
			   CertificadoReservCSM = @CSM,
			   CertificadoReservData = @CarteiraReservistaEmissao,
			   DataNascimento = @DataNascimento
		WHERE  IdProfissional = @IdDestino
		
		
		IF NOT EXISTS(SELECT TOP 1 1 FROM CursosEventos ce WHERE ce.E_Curso = 1 AND ce.NomeCursoEvento = @CursoHabilitacao) 
		   AND (@CursoHabilitacao IS NOT NULL)
			INSERT INTO CursosEventos(NomeCursoEvento,E_Curso)VALUES(@CursoHabilitacao,1)
	    
		IF NOT EXISTS(SELECT TOP 1 1 FROM Pessoas p WHERE p.E_PessoaJuridica = 1 AND p.E_InstituicaoEnsino = 1 AND P.Nome = @Universidade)
		   AND (@Universidade IS NOT NULL)
			INSERT INTO Pessoas(Nome,E_PessoaJuridica,E_InstituicaoEnsino)VALUES(@Universidade,1,1)
	    
		IF (@CursoHabilitacao IS NOT NULL)
		BEGIN
			SELECT TOP 1 @IdCursoEvento = ce.IdCursoEvento
			FROM   CursosEventos ce
			WHERE  ce.E_Curso = 1
				   AND ce.NomeCursoEvento = @CursoHabilitacao
	        
			SELECT TOP 1 @IdPessoa = p.IdPessoa
			FROM   Pessoas p
			WHERE  p.E_PessoaJuridica = 1
				   AND p.E_InstituicaoEnsino = 1
				   AND P.Nome = @Universidade
	        
			INSERT INTO CursosEventosRealizado(IdProfissional,IdCursoEvento,IdPessoa,DataColacaoGrau,TipoDocumento)
			VALUES(@IdDestino,@IdCursoEvento,@IdPessoa,@DataColacao,@DocumentoApresentado)
		END
	    
		IF @IdCategoria IS NOT NULL
			INSERT INTO Profissionais_CategoriasProf(IdCategoriaProf,IdTipoInscricao,IdProfissional,DataInicio,IdMotivoInscricao)
			VALUES(@IdCategoria,@IdTipoInscricao,@IdDestino,GETDATE(),@IdMotivoInscricao)

		UPDATE Profissionais
		SET    Endereco = replace(@Endereco, CHAR(39),'`') ,
			   NomeBairro = @NomeBairro,
			   NomeCidade = @NomeCidade,
			   SiglaUF = @SiglaUF,
			   CEP = @CEP
		WHERE  IdProfissional = @IdDestino
		
				
		IF @ImportarEndereco = 1	    
		BEGIN
			SET @SQL = 'INSERT INTO Enderecos(IdProfissional, 				'+
			                                  @CampoEndereco              +','+
					   '                      NomeBairro,     				'+
					   '                      NomeCidade,     				'+
					   '                      SiglaUF,        				'+
					   '                      CEP,            				'+
					   '                      DataUltimaAtualizacao,    	'+
					   '                      UsuarioUltimaAtualizacao, 	'+
					   '                      DepartamentoUltimaAtualizacao,'+
					   '                      Atualizado,                   '+
					   '                      Correspondencia,              '+
					   '                      E_Residencial)                '+
					   ' VALUES( ' + cast(@IdDestino AS varchar )  			+ ',' + 
			                 	 CHAR(39) +	ISNULL( @Endereco   , '' )		+ CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @NomeBairro , '' )		+ CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @NomeCidade , '' )		+ CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @SiglaUF    , '' )		+ CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @CEP        , '' )		+ CHAR(39) + ',' +
		                 		 CHAR(39) + isnull(CONVERT(varchar, CAST(@DataUltimaAtualizacao as datetime), 120),GETDATE())  + CHAR(39) + ',' + 
 							     CHAR(39) + isnull(@UsuarioUltimaAtualizacao ,HOST_NAME()) + CHAR(39) + ',' + 
			                 	 CHAR(39) + isnull(@DeptoUltimaAtualizacao  ,'PADRÃO') + CHAR(39) +  ',' + 
		                 		 
		                 		 cast(@Atualizado AS varchar)                + ',1,1)'
					
			EXEC (@SQL)
		END
		
		IF @ImportarEnderecoEC = 1
		BEGIN
			SET @SQL = 'INSERT INTO Enderecos(IdProfissional, 				'+
			                                  @CampoEndereco             +','+
					   '                      NomeBairro,     				'+
					   '                      NomeCidade,     				'+
					   '                      SiglaUF,        				'+
					   '                      CEP,            				'+
					   '                      DataUltimaAtualizacao,    	'+
					   '                      UsuarioUltimaAtualizacao, 	'+
					   '                      DepartamentoUltimaAtualizacao,'+
					   '                      Atualizado,                   '+
					   '                      Correspondencia,              '+
					   '                      E_Residencial)                '+
					   ' VALUES( ' + cast(@IdDestino AS varchar )  			+ ',' + 
			                 	 CHAR(39) +	ISNULL( @ECEndereco , '' )		+ CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @ECBairro 	, '' )		+ CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @ECCidade 	, '' )		+ CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @ECUF    	, '' )		+ CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @ECCEP      , '' ) 		+ CHAR(39) + ',' +
		                 		 CHAR(39) + isnull(CONVERT(varchar, CAST(@DataUltimaAtualizacao as datetime), 120),GETDATE())  + CHAR(39) + ',' + 
 							     CHAR(39) + isnull(@UsuarioUltimaAtualizacao ,HOST_NAME()) + CHAR(39) + ',' + 
			                 	 CHAR(39) + isnull(@DeptoUltimaAtualizacao  ,'PADRÃO') + CHAR(39) +  ',' + 
		                 		 cast(@Atualizado AS varchar)                + ',1,1)'
									 
			
			EXEC (@SQL)
		END	
	END
	
    IF EXISTS(SELECT TOP 1 1 FROM AutosInfracao t WHERE t.IdPessoa = @IdOrigem)
        UPDATE AutosInfracao
        SET    IdProfissional = @IdDestino
			  ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem 

    IF EXISTS(SELECT TOP 1 1 FROM Credenciados t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Credenciados
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem 

    IF EXISTS(SELECT TOP 1 1 FROM DocumentosSisdoc t WHERE t.IdPessoa = @IdOrigem)
        UPDATE DocumentosSisdoc
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem 

    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes t WHERE t.IdPessoa_Denunciante = @IdOrigem)
        UPDATE Fiscalizacoes
        SET    IdProfissional_Denunciante = @IdDestino
			  ,IdPessoa_Denunciante = NULL
        WHERE  IdPessoa_Denunciante = @IdOrigem 	

    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes t WHERE t.IdTabela1Pessoa = @IdOrigem)
        UPDATE Fiscalizacoes
        SET    IdTabela1Prof = @IdDestino
			   ,IdTabela1Pessoa = NULL
        WHERE  IdTabela1Pessoa = @IdOrigem 	

    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes t WHERE t.IdFiscalPessoa = @IdOrigem)
        UPDATE Fiscalizacoes
        SET    IdFiscal = @IdDestino
              ,IdFiscalPessoa = NULL
        WHERE  IdFiscalPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes_Prof_PJ t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Fiscalizacoes_Prof_PJ
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem	 

    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes_Prof_PJ2 t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Fiscalizacoes_Prof_PJ2
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM RespostasPFPJ t WHERE t.IdPessoa = @IdOrigem)
        UPDATE RespostasPFPJ
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem     

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela1Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela1Prof = @IdDestino
              ,IdTabela1Pessoa = NULL
        WHERE  IdTabela1Pessoa = @IdOrigem	

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela2Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela2Prof = @IdDestino
              ,IdTabela2Pessoa = NULL
        WHERE  IdTabela2Pessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela3Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela3Prof = @IdDestino
              ,IdTabela3Pessoa = NULL
        WHERE  IdTabela3Pessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela4Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela4Prof = @IdDestino
              ,IdTabela4Pessoa = NULL
        WHERE  IdTabela4Pessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela5Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela5Prof = @IdDestino
              ,IdTabela5Pessoa = NULL
        WHERE  IdTabela5Pessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela5Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela5Prof = @IdDestino
              ,IdTabela5Pessoa = NULL
        WHERE  IdTabela5Pessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Processos_Prof_PJ_Pessoas1 t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Processos_Prof_PJ_Pessoas1
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Processos_Prof_PJ t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Processos_Prof_PJ
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM ComplementosRemetente t WHERE t.IdPessoa = @IdOrigem)
        UPDATE ComplementosRemetente
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem	
        

    IF EXISTS(SELECT TOP 1 1 FROM CursosEventosRealizadoPessoas t WHERE t.IdPessoa = @IdOrigem)
    BEGIN
        INSERT INTO CursosEventosRealizado(IdProfissional,IdCursoEvento,IdPessoa,Duracao,UnidadeDuracao,
					                       PeriodoRealizacao,Observacao,IdPessoaCampus)
        SELECT @IdDestino,cp.IdCursoEvento,ce.IdPessoaEntidade,ce.Duracao,ce.UnidadeDuracao,
               CONVERT(VARCHAR(8),ce.DataInicioPeriodo,3)+' a '+ CONVERT(VARCHAR(8),ce.DataFimPeriodo,3),
               ce.Observacoes,ce.IdPessoaCampus 
        FROM   CursosEventosRealizadoPessoas cp INNER JOIN 
			   CursosEventos ce ON cp.IdCursoEvento = ce.IdCursoEvento 
        WHERE cp.IdPessoa = @IdOrigem
        
        DELETE  FROM CursosEventosRealizadoPessoas WHERE  IdPessoa = @IdOrigem
    END

    IF EXISTS(SELECT TOP 1 1 FROM CursosEventos t WHERE t.IdPessoaMinistrante = @IdOrigem)
        UPDATE CursosEventos
        SET    IdProfissionalMinistrante = @IdDestino
			  ,IdPessoaMinistrante = NULL
        WHERE  IdPessoaMinistrante = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Emissoes t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Emissoes
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Debitos t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Debitos
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM DividaAtiva t WHERE t.IdPessoa = @IdOrigem)
        UPDATE DividaAtiva
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem	 
        
    IF EXISTS(SELECT TOP 1 1 FROM DetalhesGrade t WHERE t.IdPessoa = @IdOrigem)
        UPDATE DetalhesGrade
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem	 

	insert into DigitalizacoesProfissionais (IdProfissional, IdControleDigitalizacoes)
	(select @IdDestino, IdControleDigitalizacoes
				          from DigitalizacoesPreCadastro 
				         where IdPessoa = @IdOrigem)

	update ControleDigitalizacoes set IdTipoDigitalizacao = 
	(select IdTipoDigitalizao
	   from TiposDigitalizacao 
	  where IdModuloDigitalizacao = 2 
		and Descricao = (select td.Descricao
						   from TiposDigitalizacao td 
						  where td.IdTipoDigitalizao = ControleDigitalizacoes.IdTipoDigitalizacao
						    and td.IdModuloDigitalizacao = 9))
	 where IdControleDigitalizacoes in (select IdControleDigitalizacoes
										  from DigitalizacoesPreCadastro 
										 where IdPessoa = @IdOrigem)

	delete from DigitalizacoesPreCadastro where IdPessoa = @IdOrigem
END

IF (@Tipo = 'PJ') /*Estava o sinal de >*/	   
BEGIN
	IF (@DadosCadastrais = 1)
	BEGIN
		UPDATE PessoasJuridicas
		SET    Nome = @Nome,
			   NomeFantasia = @NomeFantasia,
			   InscricaoEstadual = @InscricaoEstadual,
			   Sigla = @Sigla,
			   Codigo = @Codigo,
			   CNPJ = @CNPJCPF,
			   DataInscricao = @DataRegistro,
			   Endereco = @Endereco,
			   NomeBairro = @NomeBairro,
			   NomeCidade = @NomeCidade,
			   SiglaUF = @SiglaUF,
			   Atualizado = @Atualizado,
			   CEP = @CEP,
			   Processo = @NumeroProcesso,
			   [Site] = @Site,
			   DataUltimaAtualizacao = @DataUltimaAtualizacao,
			   UsuarioUltimaAtualizacao = @UsuarioUltimaAtualizacao,
			   Telefone = @Telefone,
			   Observacoes = @Observacoes,
			   EMail = @EMail
		WHERE  IdPessoaJuridica = @IdDestino
	    
		IF @CapitalSocial > 0
			INSERT INTO CapitaisSocial(IdPessoaJuridica,CapitalSocial)VALUES(@IdDestino,@CapitalSocial)

		IF @ImportarEndereco = 1    
		BEGIN
			SET @SQL = 'INSERT INTO Enderecos(IdPessoaJuridica, 			'+
			                                  @CampoEndereco             +','+
					   '                      NomeBairro,     				'+
					   '                      NomeCidade,     				'+
					   '                      SiglaUF,        				'+
					   '                      CEP,            				'+
					   '                      DataUltimaAtualizacao,    	'+
					   '                      UsuarioUltimaAtualizacao, 	'+
					   '                      DepartamentoUltimaAtualizacao,'+
					   '                      Atualizado,                   '+
					   '                      Correspondencia,              '+
					   '                      E_Residencial)                '+
					   ' VALUES( ' + cast(@IdDestino AS varchar )  	         + ',' + 
			                 	 CHAR(39) +	ISNULL( @Endereco   , '' )   	 + CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @NomeBairro , '' ) 		 + CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @NomeCidade , '' ) 		 + CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @SiglaUF    , '' )    	 + CHAR(39) + ',' +  
			                 	 CHAR(39) +	ISNULL( @CEP        , '' )    	 + CHAR(39) + ',' +  
		                 		 CHAR(39) + ISNULL(	CONVERT(varchar, CAST(@DataUltimaAtualizacao as datetime), 120),GETDATE())  + CHAR(39) + ',' + 
 							     CHAR(39) + ISNULL(	@UsuarioUltimaAtualizacao ,HOST_NAME()) + CHAR(39) + ',' + 
			                 	 CHAR(39) + ISNULL(	@DeptoUltimaAtualizacao  ,'PADRÃO') + CHAR(39) +  ',' + 
		                 		 cast(@Atualizado AS varchar)                + ',1,1)'
		    
			EXEC (@SQL)
		END
	END

    IF EXISTS(SELECT TOP 1 1 FROM AutosInfracao t WHERE t.IdPessoa = @IdOrigem)
        UPDATE AutosInfracao
        SET    IdPessoaJuridica = @IdDestino
			  ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem 

    IF EXISTS(SELECT TOP 1 1 FROM Credenciados t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Credenciados
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem 

    IF EXISTS(SELECT TOP 1 1 FROM DocumentosSisdoc t WHERE t.IdPessoa = @IdOrigem)
        UPDATE DocumentosSisdoc
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem
        

    IF EXISTS(SELECT TOP 1 1 FROM ExperienciasProfissionais t WHERE t.IdPessoa = @IdOrigem)
        UPDATE ExperienciasProfissionais
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem
    
    --- OC. 72013-- trata entidade classe em experiencia profissional do profissional
    IF EXISTS(SELECT TOP 1 1 FROM ExperienciasProfissionais t WHERE t.IdEntidadeClasse = @IdOrigem)
        UPDATE ExperienciasProfissionais 
        SET    IdEntidadeClassePJ = @IdDestino
			  ,IdEntidadeClasse = NULL
        WHERE  IdEntidadeClasse = @IdOrigem
    
    --- OC. 72013  -- trata Local de Trabalho em endereco do Profissional
    IF EXISTS(SELECT TOP 1 1 FROM Enderecos e WHERE e.IdPessoa = @IdOrigem)
        UPDATE Enderecos
        SET    IdPJTrabalho = @IdDestino
			  ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes t WHERE t.IdPessoa_Denunciante = @IdOrigem)
        UPDATE Fiscalizacoes
        SET    IdPessoaJuridica_Denunciante = @IdDestino
			  ,IdPessoa_Denunciante = NULL
        WHERE  IdPessoa_Denunciante = @IdOrigem	        

    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes t WHERE t.IdTabela1Pessoa = @IdOrigem)
        UPDATE Fiscalizacoes
        SET    IdTabela1PJ = @IdDestino
              ,IdTabela1Pessoa = NULL
        WHERE  IdTabela1Pessoa = @IdOrigem	
        
    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes_Prof_PJ t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Fiscalizacoes_Prof_PJ
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem	  
        
    IF EXISTS(SELECT TOP 1 1 FROM Fiscalizacoes_Prof_PJ2 t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Fiscalizacoes_Prof_PJ2
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem	
        
    IF EXISTS(SELECT TOP 1 1 FROM RespostasPFPJ t WHERE t.IdPessoa = @IdOrigem)
        UPDATE RespostasPFPJ
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem	 
        
    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela1Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela1PJ = @IdDestino
              ,IdTabela1Pessoa = NULL
        WHERE  IdTabela1Pessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela2Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela2PJ = @IdDestino
              ,IdTabela2Pessoa = NULL
        WHERE  IdTabela2Pessoa = @IdOrigem  

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela3Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela3PJ = @IdDestino
              ,IdTabela3Pessoa = NULL
        WHERE  IdTabela2Pessoa = @IdOrigem	

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela4Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela4PJ = @IdDestino
              ,IdTabela4Pessoa = NULL
        WHERE  IdTabela4Pessoa = @IdOrigem	

    IF EXISTS(SELECT TOP 1 1 FROM Processos t WHERE t.IdTabela5Pessoa = @IdOrigem)
        UPDATE Processos
        SET    IdTabela5PJ = @IdDestino
              ,IdTabela5Pessoa = NULL
        WHERE  IdTabela5Pessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Processos_Prof_PJ_Pessoas1 t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Processos_Prof_PJ_Pessoas1
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem	  

    IF EXISTS(SELECT TOP 1 1 FROM Processos_Prof_PJ t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Processos_Prof_PJ
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem   

    IF EXISTS(SELECT TOP 1 1 FROM ComplementosRemetente t WHERE t.IdPessoa = @IdOrigem)
        UPDATE ComplementosRemetente
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem   

    IF EXISTS(SELECT TOP 1 1 FROM Emissoes t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Emissoes
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM Debitos t WHERE t.IdPessoa = @IdOrigem)
        UPDATE Debitos
        SET    IdPessoaJuridica = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM DividaAtiva t WHERE t.IdPessoa = @IdOrigem)
        UPDATE DividaAtiva
        SET    IdProfissional = @IdDestino
              ,IdPessoa = NULL
        WHERE  IdPessoa = @IdOrigem

    IF EXISTS(SELECT TOP 1 1 FROM TiposPessoa_Pessoas t WHERE t.IdPessoa = @IdOrigem)
    BEGIN
        INSERT INTO TiposPessoa_PessoasJuridicas(IdPessoaJuridica,IdTipoPessoa)
        SELECT @IdDestino,IdTipoPessoa 
        FROM TiposPessoa_Pessoas tpp
        
        DELETE  FROM TiposPessoa_Pessoas WHERE  IdPessoa = @IdOrigem
    END	 

    IF EXISTS(SELECT TOP 1 1 FROM AreasAtuacao_Pessoas t WHERE t.IdPessoa = @IdOrigem)
    BEGIN
        INSERT INTO AreasAtuacao_PessoasJuridicas(IdPessoaJuridica,IdAreaAtuacao)
        SELECT @IdDestino,IdAreaAtuacao 
        FROM AreasAtuacao_Pessoas t
        
        DELETE  FROM AreasAtuacao_Pessoas WHERE  IdPessoa = @IdOrigem
    END

    IF EXISTS(SELECT TOP 1 1 FROM SetoresAtuacao_Pessoas t WHERE t.IdPessoa = @IdOrigem)
    BEGIN
        INSERT INTO SetoresAtuacao_PessoasJuridicas(IdPessoaJuridica,IdSetorAtuacao)
        SELECT @IdDestino,IdSetorAtuacao 
        FROM SetoresAtuacao_Pessoas t
        
        DELETE  FROM SetoresAtuacao_Pessoas WHERE  IdPessoa = @IdOrigem
    END     	                             

	
END


IF OBJECT_ID('TEMPDB..#Pendencias') IS NOT NULL
    DROP TABLE #Pendencias

CREATE TABLE #Pendencias(Info VARCHAR(500))

IF EXISTS(SELECT TOP 1 1 FROM Acessos t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Acessos')

IF EXISTS(SELECT TOP 1 1 FROM AssinaDoc t WHERE t.IdAssinatura = @IdOrigem)
    INSERT INTO #Pendencias VALUES('AssinaDoc')

IF EXISTS(SELECT TOP 1 1 FROM Consorcios t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Consorcios')

IF EXISTS(SELECT TOP 1 1 FROM Contratos t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Contratos')

IF EXISTS(SELECT TOP 1 1 FROM ContratosPessoas t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('ContratosPessoas')

IF EXISTS(SELECT TOP 1 1 FROM Cotacoes t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Cotacoes')

IF EXISTS(SELECT TOP 1 1 FROM CursosEventosOferecidos t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('CursosEventosOferecidos')

IF EXISTS(SELECT TOP 1 1 FROM CursosEventosRealizado t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('CursosEventosRealizado')

IF EXISTS(SELECT TOP 1 1 FROM Empenhos t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Empenhos')

IF EXISTS(SELECT TOP 1 1 FROM Propostas t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Propostas')

IF EXISTS(SELECT TOP 1 1 FROM EmprestimoBens t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('EmprestimoBens')

IF EXISTS(SELECT TOP 1 1 FROM FormasPagamento t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('FormasPagamento')

IF EXISTS(SELECT TOP 1 1 FROM ItensImoveis t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('ItensImoveis')

IF EXISTS(SELECT TOP 1 1 FROM LancamentosFinanceiros t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('LancamentosFinanceiros')

IF EXISTS(SELECT TOP 1 1 FROM ListaProcessos t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('ListaProcessos')

IF EXISTS(SELECT TOP 1 1 FROM PessoasTributos t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('PessoasTributos')

IF EXISTS(SELECT TOP 1 1 FROM RegistrosCursos t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('RegistrosCursos')

IF EXISTS(SELECT TOP 1 1 FROM Seguros t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Seguros')

IF EXISTS(SELECT TOP 1 1 FROM SetoresAtuacao_Pessoas t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('SetoresAtuacao_Pessoas')

IF EXISTS(SELECT TOP 1 1 FROM Usuarios t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Usuarios')

IF EXISTS(SELECT TOP 1 1 FROM Tributos t WHERE t.IdPessoa = @IdOrigem)
    INSERT INTO #Pendencias VALUES('Tributos')

IF EXISTS(SELECT TOP 1 1 FROM OutrasResponsabilidades t WHERE ((t.IdPessoaPJ =@IdOrigem) OR (t.IdPessoaPF=@IdOrigem)))
    INSERT INTO #Pendencias VALUES('OutrasResponsabilidades')

IF NOT EXISTS(SELECT TOP 1 1 FROM #Pendencias)
BEGIN
    DELETE  FROM CursosEventosRealizado WHERE  IdPessoa = @IdOrigem
    
    DELETE  FROM ExperienciasProfissionais WHERE  IdPessoa = @IdOrigem
    
    DELETE  FROM TiposPessoa_Pessoas WHERE  IdPessoa = @IdOrigem
    
    DELETE  FROM AreasAtuacao_Pessoas WHERE  IdPessoa = @IdOrigem
    
    DELETE  FROM SetoresAtuacao_Pessoas WHERE  IdPessoa = @IdOrigem
    
    DELETE  FROM CursosEventosRealizadoPessoas WHERE  IdPessoa = @IdOrigem
    
    DELETE  FROM OcorrenciasPessoa WHERE  IdPessoa = @IdOrigem
    
    DELETE  FROM DigitalizacoesPessoas WHERE  IdPessoa = @IdOrigem
    
    DELETE  FROM Pessoas WHERE  IdPessoa = @IdOrigem
END

SELECT * FROM #Pendencias

