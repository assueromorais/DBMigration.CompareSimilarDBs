﻿CREATE TABLE [dbo].[Anb_Ambiente] (
    [IdAmbiente]  INT           IDENTITY (1, 1) NOT NULL,
    [EnderecoLog] VARCHAR (200) NULL,
    [EnderecoFTP] VARCHAR (200) NULL,
    [EnderecoXML] VARCHAR (200) NULL,
    [UsuarioFTP]  VARCHAR (200) NULL,
    [SenhaFTP]    VARCHAR (200) NULL,
    [PortaFTP]    VARCHAR (200) NULL,
    [HostFTP]     VARCHAR (15)  NULL,
    CONSTRAINT [PK_Anb_Ambiente] PRIMARY KEY CLUSTERED ([IdAmbiente] ASC)
);


GO
CREATE TRIGGER [TrgLog_Anb_Ambiente] ON [Implanta_CRPAM].[dbo].[Anb_Ambiente] 
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
SET @TableName = 'Anb_Ambiente'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAmbiente : «' + RTRIM( ISNULL( CAST (IdAmbiente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoLog : «' + RTRIM( ISNULL( CAST (EnderecoLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoFTP : «' + RTRIM( ISNULL( CAST (EnderecoFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoXML : «' + RTRIM( ISNULL( CAST (EnderecoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaFTP : «' + RTRIM( ISNULL( CAST (PortaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostFTP : «' + RTRIM( ISNULL( CAST (HostFTP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAmbiente : «' + RTRIM( ISNULL( CAST (IdAmbiente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoLog : «' + RTRIM( ISNULL( CAST (EnderecoLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoFTP : «' + RTRIM( ISNULL( CAST (EnderecoFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoXML : «' + RTRIM( ISNULL( CAST (EnderecoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaFTP : «' + RTRIM( ISNULL( CAST (PortaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostFTP : «' + RTRIM( ISNULL( CAST (HostFTP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAmbiente : «' + RTRIM( ISNULL( CAST (IdAmbiente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoLog : «' + RTRIM( ISNULL( CAST (EnderecoLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoFTP : «' + RTRIM( ISNULL( CAST (EnderecoFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoXML : «' + RTRIM( ISNULL( CAST (EnderecoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaFTP : «' + RTRIM( ISNULL( CAST (PortaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostFTP : «' + RTRIM( ISNULL( CAST (HostFTP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAmbiente : «' + RTRIM( ISNULL( CAST (IdAmbiente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoLog : «' + RTRIM( ISNULL( CAST (EnderecoLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoFTP : «' + RTRIM( ISNULL( CAST (EnderecoFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoXML : «' + RTRIM( ISNULL( CAST (EnderecoXML AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaFTP : «' + RTRIM( ISNULL( CAST (PortaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostFTP : «' + RTRIM( ISNULL( CAST (HostFTP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
