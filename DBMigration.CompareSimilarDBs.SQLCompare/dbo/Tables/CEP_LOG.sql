CREATE TABLE [dbo].[CEP_LOG] (
    [CHAVE_LOG]    INT       NOT NULL,
    [NOME_LOG]     CHAR (60) NULL,
    [CHVLOCAL_LOG] INT       NOT NULL,
    [CHVBAI1_LOG]  INT       NULL,
    [CHVBAI2_LOG]  INT       NULL,
    [CEP8_LOG]     INT       NULL,
    [UF_LOG]       CHAR (2)  NULL,
    [CHVTIPO_LOG]  INT       NULL,
    [COMPLE_LOG]   CHAR (65) NULL,
    [REOP_LOG]     CHAR (2)  NULL,
    [OPER_LOG]     INT       NULL,
    [DATA_LOG]     INT       NULL,
    CONSTRAINT [PK_CEP_LOG] PRIMARY KEY NONCLUSTERED ([CHAVE_LOG] ASC, [CHVLOCAL_LOG] ASC),
    CONSTRAINT [FK_CEP_LOG_CEP_BAI] FOREIGN KEY ([CHVBAI1_LOG], [CHVLOCAL_LOG]) REFERENCES [dbo].[CEP_BAI] ([CHAVE_BAI], [CHVLOC_BAI]) NOT FOR REPLICATION,
    CONSTRAINT [FK_CEP_LOG_CEP_LOC] FOREIGN KEY ([CHVLOCAL_LOG]) REFERENCES [dbo].[CEP_LOC] ([CHAVE_LOCAL]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_CEP_LOG] ON [Implanta_CRPAM].[dbo].[CEP_LOG] 
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
SET @TableName = 'CEP_LOG'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'CHAVE_LOG : «' + RTRIM( ISNULL( CAST (CHAVE_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_LOG : «' + RTRIM( ISNULL( CAST (NOME_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVLOCAL_LOG : «' + RTRIM( ISNULL( CAST (CHVLOCAL_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVBAI1_LOG : «' + RTRIM( ISNULL( CAST (CHVBAI1_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVBAI2_LOG : «' + RTRIM( ISNULL( CAST (CHVBAI2_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP8_LOG : «' + RTRIM( ISNULL( CAST (CEP8_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_LOG : «' + RTRIM( ISNULL( CAST (UF_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVTIPO_LOG : «' + RTRIM( ISNULL( CAST (CHVTIPO_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| COMPLE_LOG : «' + RTRIM( ISNULL( CAST (COMPLE_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| REOP_LOG : «' + RTRIM( ISNULL( CAST (REOP_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_LOG : «' + RTRIM( ISNULL( CAST (OPER_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_LOG : «' + RTRIM( ISNULL( CAST (DATA_LOG AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'CHAVE_LOG : «' + RTRIM( ISNULL( CAST (CHAVE_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_LOG : «' + RTRIM( ISNULL( CAST (NOME_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVLOCAL_LOG : «' + RTRIM( ISNULL( CAST (CHVLOCAL_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVBAI1_LOG : «' + RTRIM( ISNULL( CAST (CHVBAI1_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVBAI2_LOG : «' + RTRIM( ISNULL( CAST (CHVBAI2_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP8_LOG : «' + RTRIM( ISNULL( CAST (CEP8_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_LOG : «' + RTRIM( ISNULL( CAST (UF_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVTIPO_LOG : «' + RTRIM( ISNULL( CAST (CHVTIPO_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| COMPLE_LOG : «' + RTRIM( ISNULL( CAST (COMPLE_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| REOP_LOG : «' + RTRIM( ISNULL( CAST (REOP_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_LOG : «' + RTRIM( ISNULL( CAST (OPER_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_LOG : «' + RTRIM( ISNULL( CAST (DATA_LOG AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'CHAVE_LOG : «' + RTRIM( ISNULL( CAST (CHAVE_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_LOG : «' + RTRIM( ISNULL( CAST (NOME_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVLOCAL_LOG : «' + RTRIM( ISNULL( CAST (CHVLOCAL_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVBAI1_LOG : «' + RTRIM( ISNULL( CAST (CHVBAI1_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVBAI2_LOG : «' + RTRIM( ISNULL( CAST (CHVBAI2_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP8_LOG : «' + RTRIM( ISNULL( CAST (CEP8_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_LOG : «' + RTRIM( ISNULL( CAST (UF_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVTIPO_LOG : «' + RTRIM( ISNULL( CAST (CHVTIPO_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| COMPLE_LOG : «' + RTRIM( ISNULL( CAST (COMPLE_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| REOP_LOG : «' + RTRIM( ISNULL( CAST (REOP_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_LOG : «' + RTRIM( ISNULL( CAST (OPER_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_LOG : «' + RTRIM( ISNULL( CAST (DATA_LOG AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'CHAVE_LOG : «' + RTRIM( ISNULL( CAST (CHAVE_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_LOG : «' + RTRIM( ISNULL( CAST (NOME_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVLOCAL_LOG : «' + RTRIM( ISNULL( CAST (CHVLOCAL_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVBAI1_LOG : «' + RTRIM( ISNULL( CAST (CHVBAI1_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVBAI2_LOG : «' + RTRIM( ISNULL( CAST (CHVBAI2_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP8_LOG : «' + RTRIM( ISNULL( CAST (CEP8_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_LOG : «' + RTRIM( ISNULL( CAST (UF_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVTIPO_LOG : «' + RTRIM( ISNULL( CAST (CHVTIPO_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| COMPLE_LOG : «' + RTRIM( ISNULL( CAST (COMPLE_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| REOP_LOG : «' + RTRIM( ISNULL( CAST (REOP_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_LOG : «' + RTRIM( ISNULL( CAST (OPER_LOG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_LOG : «' + RTRIM( ISNULL( CAST (DATA_LOG AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
