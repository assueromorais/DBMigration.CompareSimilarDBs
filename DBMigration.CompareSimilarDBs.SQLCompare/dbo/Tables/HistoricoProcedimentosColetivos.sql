CREATE TABLE [dbo].[HistoricoProcedimentosColetivos] (
    [IdHistoricoProcedimentoColetivo] INT      IDENTITY (1, 1) NOT NULL,
    [IdProcedimentoColetivo]          INT      NOT NULL,
    [IdUsuario]                       INT      NOT NULL,
    [IdDepto]                         INT      NULL,
    [DataRealizacao]                  DATETIME DEFAULT (getdate()) NOT NULL,
    [ResumoProcedimento]              TEXT     NULL,
    CONSTRAINT [PK_HistoricoProcedimentosColetivos] PRIMARY KEY CLUSTERED ([IdHistoricoProcedimentoColetivo] ASC),
    CONSTRAINT [FK_HistoricoProcedimentosColetivos_Departamentos] FOREIGN KEY ([IdDepto]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_HistoricoProcedimentosColetivos_ProcedimentosColetivos] FOREIGN KEY ([IdProcedimentoColetivo]) REFERENCES [dbo].[ProcedimentosColetivos] ([IdProcedimentoColetivo]),
    CONSTRAINT [FK_HistoricoProcedimentosColetivos_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
CREATE TRIGGER [TrgLog_HistoricoProcedimentosColetivos] ON [Implanta_CRPAM].[dbo].[HistoricoProcedimentosColetivos] 
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
SET @TableName = 'HistoricoProcedimentosColetivos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoProcedimentoColetivo : «' + RTRIM( ISNULL( CAST (IdHistoricoProcedimentoColetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoColetivo : «' + RTRIM( ISNULL( CAST (IdProcedimentoColetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepto : «' + RTRIM( ISNULL( CAST (IdDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRealizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRealizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoProcedimentoColetivo : «' + RTRIM( ISNULL( CAST (IdHistoricoProcedimentoColetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoColetivo : «' + RTRIM( ISNULL( CAST (IdProcedimentoColetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepto : «' + RTRIM( ISNULL( CAST (IdDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRealizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRealizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoProcedimentoColetivo : «' + RTRIM( ISNULL( CAST (IdHistoricoProcedimentoColetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoColetivo : «' + RTRIM( ISNULL( CAST (IdProcedimentoColetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepto : «' + RTRIM( ISNULL( CAST (IdDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRealizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRealizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoProcedimentoColetivo : «' + RTRIM( ISNULL( CAST (IdHistoricoProcedimentoColetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcedimentoColetivo : «' + RTRIM( ISNULL( CAST (IdProcedimentoColetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepto : «' + RTRIM( ISNULL( CAST (IdDepto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRealizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRealizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
