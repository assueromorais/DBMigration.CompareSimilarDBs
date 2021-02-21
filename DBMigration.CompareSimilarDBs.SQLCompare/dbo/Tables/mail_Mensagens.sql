CREATE TABLE [dbo].[mail_Mensagens] (
    [IdMensagem]          INT            IDENTITY (1, 1) NOT NULL,
    [MsgId]               VARCHAR (250)  NULL,
    [IdConta]             INT            NULL,
    [Remetente]           VARCHAR (8000) NULL,
    [Destinatario]        VARCHAR (8000) NULL,
    [CopiaPara]           VARCHAR (8000) NULL,
    [CopiaOcultaPara]     VARCHAR (8000) NULL,
    [Assunto]             VARCHAR (8000) NULL,
    [CorpoTexto]          TEXT           NULL,
    [CorpoHTML]           TEXT           NULL,
    [Mensagem]            IMAGE          NULL,
    [DataCriacao]         DATETIME       NULL,
    [UsuarioCriacao]      VARCHAR (60)   NULL,
    [DepartamentoCriacao] VARCHAR (60)   NULL,
    [Recebido]            BIT            CONSTRAINT [DEF_mail_Mensagens_Recebido] DEFAULT ((0)) NOT NULL,
    [DataRecebido]        DATETIME       NULL,
    [DataEnvio]           DATETIME       NULL,
    [Enviado]             BIT            CONSTRAINT [DEF_mail_Mensagens_Enviado] DEFAULT ((0)) NOT NULL,
    [Lido]                BIT            CONSTRAINT [DEF_mail_Mensagens_Lido] DEFAULT ((0)) NOT NULL,
    [CharSet]             VARCHAR (250)  NULL,
    [Associado]           BIT            CONSTRAINT [DEF_mail_Mensagens_Associado] DEFAULT ((0)) NOT NULL,
    [Excluido]            BIT            CONSTRAINT [DEF_mail_Mensagens_Excluido] DEFAULT ((0)) NOT NULL,
    [MotivoPendencia]     VARCHAR (8000) NULL,
    CONSTRAINT [PK_mail_Mensagens] PRIMARY KEY CLUSTERED ([IdMensagem] ASC),
    CONSTRAINT [FK_mail_Mensagens_IdConta] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[mail_Contas] ([IdConta])
);


GO
CREATE NONCLUSTERED INDEX [IDX_mail_Mensagens_MsgId]
    ON [dbo].[mail_Mensagens]([MsgId] ASC);


GO
CREATE TRIGGER [TrgLog_mail_Mensagens] ON [Implanta_CRPAM].[dbo].[mail_Mensagens] 
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
SET @TableName = 'mail_Mensagens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgId : «' + RTRIM( ISNULL( CAST (MsgId AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remetente : «' + RTRIM( ISNULL( CAST (Remetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destinatario : «' + RTRIM( ISNULL( CAST (Destinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CopiaPara : «' + RTRIM( ISNULL( CAST (CopiaPara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CopiaOcultaPara : «' + RTRIM( ISNULL( CAST (CopiaOcultaPara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoCriacao : «' + RTRIM( ISNULL( CAST (DepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recebido IS NULL THEN ' Recebido : «Nulo» '
                                              WHEN  Recebido = 0 THEN ' Recebido : «Falso» '
                                              WHEN  Recebido = 1 THEN ' Recebido : «Verdadeiro» '
                                    END 
                         + '| DataRecebido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebido, 113 ),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Lido IS NULL THEN ' Lido : «Nulo» '
                                              WHEN  Lido = 0 THEN ' Lido : «Falso» '
                                              WHEN  Lido = 1 THEN ' Lido : «Verdadeiro» '
                                    END 
                         + '| CharSet : «' + RTRIM( ISNULL( CAST (CharSet AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Associado IS NULL THEN ' Associado : «Nulo» '
                                              WHEN  Associado = 0 THEN ' Associado : «Falso» '
                                              WHEN  Associado = 1 THEN ' Associado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Excluido IS NULL THEN ' Excluido : «Nulo» '
                                              WHEN  Excluido = 0 THEN ' Excluido : «Falso» '
                                              WHEN  Excluido = 1 THEN ' Excluido : «Verdadeiro» '
                                    END 
                         + '| MotivoPendencia : «' + RTRIM( ISNULL( CAST (MotivoPendencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgId : «' + RTRIM( ISNULL( CAST (MsgId AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remetente : «' + RTRIM( ISNULL( CAST (Remetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destinatario : «' + RTRIM( ISNULL( CAST (Destinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CopiaPara : «' + RTRIM( ISNULL( CAST (CopiaPara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CopiaOcultaPara : «' + RTRIM( ISNULL( CAST (CopiaOcultaPara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoCriacao : «' + RTRIM( ISNULL( CAST (DepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recebido IS NULL THEN ' Recebido : «Nulo» '
                                              WHEN  Recebido = 0 THEN ' Recebido : «Falso» '
                                              WHEN  Recebido = 1 THEN ' Recebido : «Verdadeiro» '
                                    END 
                         + '| DataRecebido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebido, 113 ),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Lido IS NULL THEN ' Lido : «Nulo» '
                                              WHEN  Lido = 0 THEN ' Lido : «Falso» '
                                              WHEN  Lido = 1 THEN ' Lido : «Verdadeiro» '
                                    END 
                         + '| CharSet : «' + RTRIM( ISNULL( CAST (CharSet AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Associado IS NULL THEN ' Associado : «Nulo» '
                                              WHEN  Associado = 0 THEN ' Associado : «Falso» '
                                              WHEN  Associado = 1 THEN ' Associado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Excluido IS NULL THEN ' Excluido : «Nulo» '
                                              WHEN  Excluido = 0 THEN ' Excluido : «Falso» '
                                              WHEN  Excluido = 1 THEN ' Excluido : «Verdadeiro» '
                                    END 
                         + '| MotivoPendencia : «' + RTRIM( ISNULL( CAST (MotivoPendencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgId : «' + RTRIM( ISNULL( CAST (MsgId AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remetente : «' + RTRIM( ISNULL( CAST (Remetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destinatario : «' + RTRIM( ISNULL( CAST (Destinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CopiaPara : «' + RTRIM( ISNULL( CAST (CopiaPara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CopiaOcultaPara : «' + RTRIM( ISNULL( CAST (CopiaOcultaPara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoCriacao : «' + RTRIM( ISNULL( CAST (DepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recebido IS NULL THEN ' Recebido : «Nulo» '
                                              WHEN  Recebido = 0 THEN ' Recebido : «Falso» '
                                              WHEN  Recebido = 1 THEN ' Recebido : «Verdadeiro» '
                                    END 
                         + '| DataRecebido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebido, 113 ),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Lido IS NULL THEN ' Lido : «Nulo» '
                                              WHEN  Lido = 0 THEN ' Lido : «Falso» '
                                              WHEN  Lido = 1 THEN ' Lido : «Verdadeiro» '
                                    END 
                         + '| CharSet : «' + RTRIM( ISNULL( CAST (CharSet AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Associado IS NULL THEN ' Associado : «Nulo» '
                                              WHEN  Associado = 0 THEN ' Associado : «Falso» '
                                              WHEN  Associado = 1 THEN ' Associado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Excluido IS NULL THEN ' Excluido : «Nulo» '
                                              WHEN  Excluido = 0 THEN ' Excluido : «Falso» '
                                              WHEN  Excluido = 1 THEN ' Excluido : «Verdadeiro» '
                                    END 
                         + '| MotivoPendencia : «' + RTRIM( ISNULL( CAST (MotivoPendencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MsgId : «' + RTRIM( ISNULL( CAST (MsgId AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remetente : «' + RTRIM( ISNULL( CAST (Remetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Destinatario : «' + RTRIM( ISNULL( CAST (Destinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CopiaPara : «' + RTRIM( ISNULL( CAST (CopiaPara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CopiaOcultaPara : «' + RTRIM( ISNULL( CAST (CopiaOcultaPara AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoCriacao : «' + RTRIM( ISNULL( CAST (DepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recebido IS NULL THEN ' Recebido : «Nulo» '
                                              WHEN  Recebido = 0 THEN ' Recebido : «Falso» '
                                              WHEN  Recebido = 1 THEN ' Recebido : «Verdadeiro» '
                                    END 
                         + '| DataRecebido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebido, 113 ),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Lido IS NULL THEN ' Lido : «Nulo» '
                                              WHEN  Lido = 0 THEN ' Lido : «Falso» '
                                              WHEN  Lido = 1 THEN ' Lido : «Verdadeiro» '
                                    END 
                         + '| CharSet : «' + RTRIM( ISNULL( CAST (CharSet AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Associado IS NULL THEN ' Associado : «Nulo» '
                                              WHEN  Associado = 0 THEN ' Associado : «Falso» '
                                              WHEN  Associado = 1 THEN ' Associado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Excluido IS NULL THEN ' Excluido : «Nulo» '
                                              WHEN  Excluido = 0 THEN ' Excluido : «Falso» '
                                              WHEN  Excluido = 1 THEN ' Excluido : «Verdadeiro» '
                                    END 
                         + '| MotivoPendencia : «' + RTRIM( ISNULL( CAST (MotivoPendencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
