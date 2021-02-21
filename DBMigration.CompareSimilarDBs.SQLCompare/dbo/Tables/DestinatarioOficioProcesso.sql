CREATE TABLE [dbo].[DestinatarioOficioProcesso] (
    [IdOficioProcesso]     INT            NOT NULL,
    [IdProcesso]           INT            NOT NULL,
    [IdDestinatario]       INT            NOT NULL,
    [TipoPesso_PE_PF_PJ]   CHAR (2)       NOT NULL,
    [NomeDestinatario]     VARCHAR (120)  NOT NULL,
    [RegistroDestinatario] VARCHAR (20)   NULL,
    [SiglaUFRegistroDest]  CHAR (2)       NULL,
    [DescEnderecoDest]     NVARCHAR (300) NOT NULL,
    [DescNumOficioSisdoc]  VARCHAR (100)  NOT NULL,
    [DescTipoParteDest]    VARCHAR (100)  NOT NULL,
    [Excluido]             BIT            CONSTRAINT [DF__Destinata__Exclu__1B623806] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_DestinatarioOficioProcesso_1] PRIMARY KEY CLUSTERED ([IdOficioProcesso] ASC, [IdProcesso] ASC, [IdDestinatario] ASC, [TipoPesso_PE_PF_PJ] ASC),
    CONSTRAINT [FK_DestinatarioOficioProcesso_OficioProcesso] FOREIGN KEY ([IdOficioProcesso], [IdProcesso]) REFERENCES [dbo].[OficioProcesso] ([IdOficioProcesso], [IdProcesso])
);


GO
CREATE TRIGGER [TrgLog_DestinatarioOficioProcesso] ON [Implanta_CRPAM].[dbo].[DestinatarioOficioProcesso] 
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
SET @TableName = 'DestinatarioOficioProcesso'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOficioProcesso : «' + RTRIM( ISNULL( CAST (IdOficioProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDestinatario : «' + RTRIM( ISNULL( CAST (IdDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPesso_PE_PF_PJ : «' + RTRIM( ISNULL( CAST (TipoPesso_PE_PF_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeDestinatario : «' + RTRIM( ISNULL( CAST (NomeDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroDestinatario : «' + RTRIM( ISNULL( CAST (RegistroDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUFRegistroDest : «' + RTRIM( ISNULL( CAST (SiglaUFRegistroDest AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescNumOficioSisdoc : «' + RTRIM( ISNULL( CAST (DescNumOficioSisdoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescTipoParteDest : «' + RTRIM( ISNULL( CAST (DescTipoParteDest AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Excluido IS NULL THEN ' Excluido : «Nulo» '
                                              WHEN  Excluido = 0 THEN ' Excluido : «Falso» '
                                              WHEN  Excluido = 1 THEN ' Excluido : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdOficioProcesso : «' + RTRIM( ISNULL( CAST (IdOficioProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDestinatario : «' + RTRIM( ISNULL( CAST (IdDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPesso_PE_PF_PJ : «' + RTRIM( ISNULL( CAST (TipoPesso_PE_PF_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeDestinatario : «' + RTRIM( ISNULL( CAST (NomeDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroDestinatario : «' + RTRIM( ISNULL( CAST (RegistroDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUFRegistroDest : «' + RTRIM( ISNULL( CAST (SiglaUFRegistroDest AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescNumOficioSisdoc : «' + RTRIM( ISNULL( CAST (DescNumOficioSisdoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescTipoParteDest : «' + RTRIM( ISNULL( CAST (DescTipoParteDest AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Excluido IS NULL THEN ' Excluido : «Nulo» '
                                              WHEN  Excluido = 0 THEN ' Excluido : «Falso» '
                                              WHEN  Excluido = 1 THEN ' Excluido : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdOficioProcesso : «' + RTRIM( ISNULL( CAST (IdOficioProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDestinatario : «' + RTRIM( ISNULL( CAST (IdDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPesso_PE_PF_PJ : «' + RTRIM( ISNULL( CAST (TipoPesso_PE_PF_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeDestinatario : «' + RTRIM( ISNULL( CAST (NomeDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroDestinatario : «' + RTRIM( ISNULL( CAST (RegistroDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUFRegistroDest : «' + RTRIM( ISNULL( CAST (SiglaUFRegistroDest AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescNumOficioSisdoc : «' + RTRIM( ISNULL( CAST (DescNumOficioSisdoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescTipoParteDest : «' + RTRIM( ISNULL( CAST (DescTipoParteDest AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Excluido IS NULL THEN ' Excluido : «Nulo» '
                                              WHEN  Excluido = 0 THEN ' Excluido : «Falso» '
                                              WHEN  Excluido = 1 THEN ' Excluido : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOficioProcesso : «' + RTRIM( ISNULL( CAST (IdOficioProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDestinatario : «' + RTRIM( ISNULL( CAST (IdDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPesso_PE_PF_PJ : «' + RTRIM( ISNULL( CAST (TipoPesso_PE_PF_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeDestinatario : «' + RTRIM( ISNULL( CAST (NomeDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroDestinatario : «' + RTRIM( ISNULL( CAST (RegistroDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUFRegistroDest : «' + RTRIM( ISNULL( CAST (SiglaUFRegistroDest AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescNumOficioSisdoc : «' + RTRIM( ISNULL( CAST (DescNumOficioSisdoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescTipoParteDest : «' + RTRIM( ISNULL( CAST (DescTipoParteDest AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Excluido IS NULL THEN ' Excluido : «Nulo» '
                                              WHEN  Excluido = 0 THEN ' Excluido : «Falso» '
                                              WHEN  Excluido = 1 THEN ' Excluido : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
