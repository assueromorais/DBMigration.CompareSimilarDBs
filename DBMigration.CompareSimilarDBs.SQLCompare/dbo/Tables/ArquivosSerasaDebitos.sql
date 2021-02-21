CREATE TABLE [dbo].[ArquivosSerasaDebitos] (
    [IdArqSerasaDebito]    INT           IDENTITY (1, 1) NOT NULL,
    [IdArquivoSerasa]      INT           NULL,
    [Tipo]                 INT           NULL,
    [IdMotivoBaixa]        INT           NULL,
    [Aprovado]             BIT           CONSTRAINT [DEF_ArquivosSerasaDebitos_Aprovado] DEFAULT ((0)) NOT NULL,
    [DataInclusao]         DATETIME      NULL,
    [UsuarioInclusao]      VARCHAR (100) NULL,
    [DepartamentoInclusao] VARCHAR (100) NULL,
    [DataRetorno]          DATETIME      NULL,
    [UsuarioRetorno]       VARCHAR (100) NULL,
    [DepartamentoRetorno]  VARCHAR (100) NULL,
    [ErrosRetorno]         VARCHAR (250) NULL,
    [IdDividaAtiva]        INT           NULL,
    CONSTRAINT [PK_ArquivosSerasaDebitos_IdArqSerasaDebito] PRIMARY KEY CLUSTERED ([IdArqSerasaDebito] ASC),
    CONSTRAINT [FK_ArquivosSerasaDebitos_ArquivosSerasa] FOREIGN KEY ([IdArquivoSerasa]) REFERENCES [dbo].[ArquivosSerasa] ([IdArquivoSerasa]),
    CONSTRAINT [FK_ArquivosSerasaDebitos_Divida] FOREIGN KEY ([IdDividaAtiva]) REFERENCES [dbo].[DividaAtiva] ([IdDividaAtiva]),
    CONSTRAINT [FK_ArquivosSerasaDebitos_Motivo] FOREIGN KEY ([IdMotivoBaixa]) REFERENCES [dbo].[MotivosBaixaSerasa] ([IdMotivoBaixa])
);


GO
CREATE NONCLUSTERED INDEX [IX_ArquivosSerasaDebitosDividaAtiva]
    ON [dbo].[ArquivosSerasaDebitos]([IdDividaAtiva] ASC);


GO
CREATE TRIGGER [TrgLog_ArquivosSerasaDebitos] ON [Implanta_CRPAM].[dbo].[ArquivosSerasaDebitos] 
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
SET @TableName = 'ArquivosSerasaDebitos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArqSerasaDebito : «' + RTRIM( ISNULL( CAST (IdArqSerasaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoSerasa : «' + RTRIM( ISNULL( CAST (IdArquivoSerasa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoBaixa : «' + RTRIM( ISNULL( CAST (IdMotivoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Aprovado IS NULL THEN ' Aprovado : «Nulo» '
                                              WHEN  Aprovado = 0 THEN ' Aprovado : «Falso» '
                                              WHEN  Aprovado = 1 THEN ' Aprovado : «Verdadeiro» '
                                    END 
                         + '| DataInclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInclusao, 113 ),'Nulo'))+'» '
                         + '| UsuarioInclusao : «' + RTRIM( ISNULL( CAST (UsuarioInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoInclusao : «' + RTRIM( ISNULL( CAST (DepartamentoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| UsuarioRetorno : «' + RTRIM( ISNULL( CAST (UsuarioRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoRetorno : «' + RTRIM( ISNULL( CAST (DepartamentoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErrosRetorno : «' + RTRIM( ISNULL( CAST (ErrosRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArqSerasaDebito : «' + RTRIM( ISNULL( CAST (IdArqSerasaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoSerasa : «' + RTRIM( ISNULL( CAST (IdArquivoSerasa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoBaixa : «' + RTRIM( ISNULL( CAST (IdMotivoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Aprovado IS NULL THEN ' Aprovado : «Nulo» '
                                              WHEN  Aprovado = 0 THEN ' Aprovado : «Falso» '
                                              WHEN  Aprovado = 1 THEN ' Aprovado : «Verdadeiro» '
                                    END 
                         + '| DataInclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInclusao, 113 ),'Nulo'))+'» '
                         + '| UsuarioInclusao : «' + RTRIM( ISNULL( CAST (UsuarioInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoInclusao : «' + RTRIM( ISNULL( CAST (DepartamentoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| UsuarioRetorno : «' + RTRIM( ISNULL( CAST (UsuarioRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoRetorno : «' + RTRIM( ISNULL( CAST (DepartamentoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErrosRetorno : «' + RTRIM( ISNULL( CAST (ErrosRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArqSerasaDebito : «' + RTRIM( ISNULL( CAST (IdArqSerasaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoSerasa : «' + RTRIM( ISNULL( CAST (IdArquivoSerasa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoBaixa : «' + RTRIM( ISNULL( CAST (IdMotivoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Aprovado IS NULL THEN ' Aprovado : «Nulo» '
                                              WHEN  Aprovado = 0 THEN ' Aprovado : «Falso» '
                                              WHEN  Aprovado = 1 THEN ' Aprovado : «Verdadeiro» '
                                    END 
                         + '| DataInclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInclusao, 113 ),'Nulo'))+'» '
                         + '| UsuarioInclusao : «' + RTRIM( ISNULL( CAST (UsuarioInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoInclusao : «' + RTRIM( ISNULL( CAST (DepartamentoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| UsuarioRetorno : «' + RTRIM( ISNULL( CAST (UsuarioRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoRetorno : «' + RTRIM( ISNULL( CAST (DepartamentoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErrosRetorno : «' + RTRIM( ISNULL( CAST (ErrosRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArqSerasaDebito : «' + RTRIM( ISNULL( CAST (IdArqSerasaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoSerasa : «' + RTRIM( ISNULL( CAST (IdArquivoSerasa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoBaixa : «' + RTRIM( ISNULL( CAST (IdMotivoBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Aprovado IS NULL THEN ' Aprovado : «Nulo» '
                                              WHEN  Aprovado = 0 THEN ' Aprovado : «Falso» '
                                              WHEN  Aprovado = 1 THEN ' Aprovado : «Verdadeiro» '
                                    END 
                         + '| DataInclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInclusao, 113 ),'Nulo'))+'» '
                         + '| UsuarioInclusao : «' + RTRIM( ISNULL( CAST (UsuarioInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoInclusao : «' + RTRIM( ISNULL( CAST (DepartamentoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| UsuarioRetorno : «' + RTRIM( ISNULL( CAST (UsuarioRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoRetorno : «' + RTRIM( ISNULL( CAST (DepartamentoRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ErrosRetorno : «' + RTRIM( ISNULL( CAST (ErrosRetorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
