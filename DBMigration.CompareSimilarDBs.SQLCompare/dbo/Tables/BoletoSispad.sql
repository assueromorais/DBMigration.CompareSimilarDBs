CREATE TABLE [dbo].[BoletoSispad] (
    [IdBoleto]                  INT          IDENTITY (1, 1) NOT NULL,
    [IdPessoaSolicitacaoViagem] INT          NOT NULL,
    [DataEmissaoBoleto]         DATETIME     NOT NULL,
    [DataVencimentoBoleto]      DATETIME     NOT NULL,
    [ValorBoleto]               MONEY        NOT NULL,
    [NossoNumeroBoleto]         VARCHAR (30) NOT NULL,
    [Pago]                      BIT          CONSTRAINT [DF_BoletoSispad_Pago] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_BoletoSispad] PRIMARY KEY NONCLUSTERED ([IdBoleto] ASC),
    CONSTRAINT [FK_BoletoSispad_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacaoViagem]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_BoletoSispad] ON [Implanta_CRPAM].[dbo].[BoletoSispad] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'BoletoSispad'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdBoleto : «' + RTRIM( ISNULL( CAST (IdBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissaoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissaoBoleto, 113 ),'Nulo'))+'» '
                         + '| DataVencimentoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoBoleto, 113 ),'Nulo'))+'» '
                         + '| ValorBoleto : «' + RTRIM( ISNULL( CAST (ValorBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumeroBoleto : «' + RTRIM( ISNULL( CAST (NossoNumeroBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Pago IS NULL THEN ' Pago : «Nulo» '
                                              WHEN  Pago = 0 THEN ' Pago : «Falso» '
                                              WHEN  Pago = 1 THEN ' Pago : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdBoleto : «' + RTRIM( ISNULL( CAST (IdBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissaoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissaoBoleto, 113 ),'Nulo'))+'» '
                         + '| DataVencimentoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoBoleto, 113 ),'Nulo'))+'» '
                         + '| ValorBoleto : «' + RTRIM( ISNULL( CAST (ValorBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumeroBoleto : «' + RTRIM( ISNULL( CAST (NossoNumeroBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Pago IS NULL THEN ' Pago : «Nulo» '
                                              WHEN  Pago = 0 THEN ' Pago : «Falso» '
                                              WHEN  Pago = 1 THEN ' Pago : «Verdadeiro» '
                                    END  FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdBoleto : «' + RTRIM( ISNULL( CAST (IdBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissaoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissaoBoleto, 113 ),'Nulo'))+'» '
                         + '| DataVencimentoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoBoleto, 113 ),'Nulo'))+'» '
                         + '| ValorBoleto : «' + RTRIM( ISNULL( CAST (ValorBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumeroBoleto : «' + RTRIM( ISNULL( CAST (NossoNumeroBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Pago IS NULL THEN ' Pago : «Nulo» '
                                              WHEN  Pago = 0 THEN ' Pago : «Falso» '
                                              WHEN  Pago = 1 THEN ' Pago : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdBoleto : «' + RTRIM( ISNULL( CAST (IdBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmissaoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmissaoBoleto, 113 ),'Nulo'))+'» '
                         + '| DataVencimentoBoleto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoBoleto, 113 ),'Nulo'))+'» '
                         + '| ValorBoleto : «' + RTRIM( ISNULL( CAST (ValorBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NossoNumeroBoleto : «' + RTRIM( ISNULL( CAST (NossoNumeroBoleto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Pago IS NULL THEN ' Pago : «Nulo» '
                                              WHEN  Pago = 0 THEN ' Pago : «Falso» '
                                              WHEN  Pago = 1 THEN ' Pago : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
