/*Ocorrência - 139207 - Seila */
 
CREATE PROCEDURE [dbo].[spCalcPorte](@IdPessoaJuridica INT,@Coletivo BIT = 0) 
AS
BEGIN	
DECLARE @Filtro  TABLE (IdFiltro INT IDENTITY(1,1) NOT NULL,
	                    IdPessoaJuridica INT,						
						CalculaPorte BIT,
						QtdFunc INT,
						Potencia INT,	
						Porte VARCHAR(20),	
						DataSalarioMinimo DATETIME,
						ValorSalarioMinimo MONEY ,
						DataCapitalSocial DATETIME,
						ValorCapitalSocial MONEY 						
						)  	
	
DECLARE @DataVigSM DATETIME,
        @ValorSM MONEY,
        @DataCapital DATETIME,
        @ValorCapital MONEY,
        @IdFiltro INT

/*Preenche variáveis de Salário Mínimo*/
SELECT TOP 1 @DataVigSM =SM.[Data],@ValorSM = SM.Valor 
FROM SalarioMinimo SM
ORDER BY SM.Data DESC
	
IF @@ROWCOUNT=0
	SELECT  @DataVigSM = 0,@ValorSM = 0.00

/*Insere dados da PessoaJurídica e Salário Mínimo na tabela @Filtro*/
IF @Coletivo = 0
	INSERT INTO @Filtro(IdPessoaJuridica, CalculaPorte, QtdFunc,Potencia,DataSalarioMinimo,ValorSalarioMinimo)
		SELECT IdPessoaJuridica,CalculaPorte,ISNULL(QtdFunc,0),ISNULL(Potencia,0),@DataVigSM ,@ValorSM 
		FROM PessoasJuridicas 
		WHERE IdPessoaJuridica = @IdPessoaJuridica 
ELSE
BEGIN
	INSERT INTO @Filtro(IdPessoaJuridica, CalculaPorte, QtdFunc,Potencia,DataSalarioMinimo,ValorSalarioMinimo)
		SELECT IdPessoaJuridica,CalculaPorte,ISNULL(QtdFunc,0),ISNULL(Potencia,0),@DataVigSM ,@ValorSM 
		FROM PessoasJuridicas 
END

/*Insere dados do capital social na tabela @Filtro*/
SELECT @IdFiltro = MIN(IdFiltro) FROM @Filtro
WHILE @IdFiltro IS NOT NULL 
BEGIN
	SELECT @IdPessoaJuridica = IdPessoaJuridica
	FROM @Filtro 
	WHERE IdFiltro = @IdFiltro 
	
	SELECT TOP 1 @DataCapital = CS.[Data], @ValorCapital = CS.CapitalSocial
    FROM CapitaisSocial CS  
    WHERE CS.IdPessoaJuridica = @IdPessoaJuridica 
    ORDER BY CS.[Data] DESC,CS.IdCapitalSocial DESC
    
    UPDATE @Filtro
    SET DataCapitalSocial = @DataCapital, 
        ValorCapitalSocial = @ValorCapital
    WHERE IdPessoaJuridica = @IdPessoaJuridica   
      
SELECT @IdFiltro = MIN(IdFiltro) FROM @Filtro WHERE IdFiltro > @IdFiltro
END
/*Realiza cálculo de porte*/
  UPDATE @Filtro
  SET Porte = CASE WHEN (ValorCapitalSocial > (ValorSalarioMinimo * 1000)) OR 
                        (QtdFunc > 50) OR
                        (Potencia) > 400 OR 
                        (CalculaPorte) = 0
                 THEN 'Médio-Grande Porte' 
				 ELSE 'Pequeno Porte' END 
  FROM @Filtro
  
  /*AtualizaPorte em PessoasJurídicas*/	    
  UPDATE PessoasJuridicas
  SET PessoasJuridicas.Porte = FL.Porte
  FROM PessoasJuridicas INNER JOIN 
       @Filtro FL ON FL.IdPessoaJuridica = PessoasJuridicas.IdPessoaJuridica
       
  /*Insere o resultado na tabela PessoasJuridicasPorte*/	
  INSERT INTO  PessoasJuridicasPorte(IdPessoaJuridica,DataCadastro,CalculaPorte,QtdFunc,Potencia,
               DataSalarioMinimo,ValorSalarioMinimo,DataCapitalSocial,ValorCapitalSocial,Porte)
		SELECT IdPessoaJuridica,DataCadastro = GETDATE(), CalculaPorte, QtdFunc, Potencia, 
			   DataSalarioMinimo, ValorSalarioMinimo,DataCapitalSocial, ValorCapitalSocial,Porte
	    FROM @Filtro  
END
