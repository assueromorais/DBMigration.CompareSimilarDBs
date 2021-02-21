CREATE TABLE [dbo].[Mensagens] (
    [IdMensagem]            INT      IDENTITY (1, 1) NOT NULL,
    [IdSistema]             INT      NULL,
    [IdUsuarioOrigem]       INT      NULL,
    [IdUsuarioDestino]      INT      NOT NULL,
    [IdTramitacao]          INT      NULL,
    [Mensagem]              TEXT     NOT NULL,
    [DataMsg]               DATETIME NOT NULL,
    [DataRecebimentoMsg]    DATETIME NULL,
    [Recebido]              BIT      NOT NULL,
    [IndAcao]               INT      NULL,
    [MensagemLida]          BIT      NULL,
    [DataLeitura]           DATETIME NULL,
    [IdDepartamentoDestino] INT      NULL,
    [Notificar]             BIT      DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Mensagens] PRIMARY KEY CLUSTERED ([IdMensagem] ASC),
    CONSTRAINT [FK_Mensagens_Departamentos] FOREIGN KEY ([IdDepartamentoDestino]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_Mensagens_Sistemas] FOREIGN KEY ([IdSistema]) REFERENCES [dbo].[Sistemas] ([IdSistema]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Mensagens_Tramitacoes] FOREIGN KEY ([IdTramitacao]) REFERENCES [dbo].[Tramitacoes] ([IdTramitacao]),
    CONSTRAINT [FK_Mensagens_UsuariosDestino] FOREIGN KEY ([IdUsuarioDestino]) REFERENCES [dbo].[Usuarios] ([IdUsuario]),
    CONSTRAINT [FK_Mensagens_UsuariosOrigem] FOREIGN KEY ([IdUsuarioOrigem]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
ALTER TABLE [dbo].[Mensagens] NOCHECK CONSTRAINT [FK_Mensagens_Tramitacoes];


GO
/*Ocorr. 57841 - Seila */

CREATE TRIGGER [dbo].[Trg_MensagensTramitacoes_Usuario] ON [dbo].[Mensagens] 
	FOR INSERT,
		UPDATE,
		DELETE
AS
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
	BEGIN		
		UPDATE
			T	
		SET
			T.DataUltimaAtualizacao = GETDATE(),
			T.UsuarioUltimaAtualizacao = HOST_NAME(),
			T.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			INSERTED I
			JOIN Tramitacoes T ON T.IdTramitacao = I.IdTramitacao	
	END
ELSE IF EXISTS (SELECT TOP 1 1 FROM DELETED)
	BEGIN		
		UPDATE
			T	
		SET
			T.DataUltimaAtualizacao = GETDATE(),
			T.UsuarioUltimaAtualizacao = HOST_NAME(),
			T.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			DELETED D
			JOIN Tramitacoes T ON T.IdTramitacao = D.IdTramitacao			
	END	 
SET NOCOUNT OFF

GO
CREATE TRIGGER [TrgLog_Mensagens] ON [Implanta_CRPAM].[dbo].[Mensagens] 
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
SET @TableName = 'Mensagens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioOrigem : «' + RTRIM( ISNULL( CAST (IdUsuarioOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioDestino : «' + RTRIM( ISNULL( CAST (IdUsuarioDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTramitacao : «' + RTRIM( ISNULL( CAST (IdTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMsg : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMsg, 113 ),'Nulo'))+'» '
                         + '| DataRecebimentoMsg : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimentoMsg, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recebido IS NULL THEN ' Recebido : «Nulo» '
                                              WHEN  Recebido = 0 THEN ' Recebido : «Falso» '
                                              WHEN  Recebido = 1 THEN ' Recebido : «Verdadeiro» '
                                    END 
                         + '| IndAcao : «' + RTRIM( ISNULL( CAST (IndAcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MensagemLida IS NULL THEN ' MensagemLida : «Nulo» '
                                              WHEN  MensagemLida = 0 THEN ' MensagemLida : «Falso» '
                                              WHEN  MensagemLida = 1 THEN ' MensagemLida : «Verdadeiro» '
                                    END 
                         + '| DataLeitura : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLeitura, 113 ),'Nulo'))+'» '
                         + '| IdDepartamentoDestino : «' + RTRIM( ISNULL( CAST (IdDepartamentoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Notificar IS NULL THEN ' Notificar : «Nulo» '
                                              WHEN  Notificar = 0 THEN ' Notificar : «Falso» '
                                              WHEN  Notificar = 1 THEN ' Notificar : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioOrigem : «' + RTRIM( ISNULL( CAST (IdUsuarioOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioDestino : «' + RTRIM( ISNULL( CAST (IdUsuarioDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTramitacao : «' + RTRIM( ISNULL( CAST (IdTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMsg : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMsg, 113 ),'Nulo'))+'» '
                         + '| DataRecebimentoMsg : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimentoMsg, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recebido IS NULL THEN ' Recebido : «Nulo» '
                                              WHEN  Recebido = 0 THEN ' Recebido : «Falso» '
                                              WHEN  Recebido = 1 THEN ' Recebido : «Verdadeiro» '
                                    END 
                         + '| IndAcao : «' + RTRIM( ISNULL( CAST (IndAcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MensagemLida IS NULL THEN ' MensagemLida : «Nulo» '
                                              WHEN  MensagemLida = 0 THEN ' MensagemLida : «Falso» '
                                              WHEN  MensagemLida = 1 THEN ' MensagemLida : «Verdadeiro» '
                                    END 
                         + '| DataLeitura : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLeitura, 113 ),'Nulo'))+'» '
                         + '| IdDepartamentoDestino : «' + RTRIM( ISNULL( CAST (IdDepartamentoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Notificar IS NULL THEN ' Notificar : «Nulo» '
                                              WHEN  Notificar = 0 THEN ' Notificar : «Falso» '
                                              WHEN  Notificar = 1 THEN ' Notificar : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioOrigem : «' + RTRIM( ISNULL( CAST (IdUsuarioOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioDestino : «' + RTRIM( ISNULL( CAST (IdUsuarioDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTramitacao : «' + RTRIM( ISNULL( CAST (IdTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMsg : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMsg, 113 ),'Nulo'))+'» '
                         + '| DataRecebimentoMsg : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimentoMsg, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recebido IS NULL THEN ' Recebido : «Nulo» '
                                              WHEN  Recebido = 0 THEN ' Recebido : «Falso» '
                                              WHEN  Recebido = 1 THEN ' Recebido : «Verdadeiro» '
                                    END 
                         + '| IndAcao : «' + RTRIM( ISNULL( CAST (IndAcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MensagemLida IS NULL THEN ' MensagemLida : «Nulo» '
                                              WHEN  MensagemLida = 0 THEN ' MensagemLida : «Falso» '
                                              WHEN  MensagemLida = 1 THEN ' MensagemLida : «Verdadeiro» '
                                    END 
                         + '| DataLeitura : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLeitura, 113 ),'Nulo'))+'» '
                         + '| IdDepartamentoDestino : «' + RTRIM( ISNULL( CAST (IdDepartamentoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Notificar IS NULL THEN ' Notificar : «Nulo» '
                                              WHEN  Notificar = 0 THEN ' Notificar : «Falso» '
                                              WHEN  Notificar = 1 THEN ' Notificar : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioOrigem : «' + RTRIM( ISNULL( CAST (IdUsuarioOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioDestino : «' + RTRIM( ISNULL( CAST (IdUsuarioDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTramitacao : «' + RTRIM( ISNULL( CAST (IdTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMsg : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMsg, 113 ),'Nulo'))+'» '
                         + '| DataRecebimentoMsg : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimentoMsg, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Recebido IS NULL THEN ' Recebido : «Nulo» '
                                              WHEN  Recebido = 0 THEN ' Recebido : «Falso» '
                                              WHEN  Recebido = 1 THEN ' Recebido : «Verdadeiro» '
                                    END 
                         + '| IndAcao : «' + RTRIM( ISNULL( CAST (IndAcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  MensagemLida IS NULL THEN ' MensagemLida : «Nulo» '
                                              WHEN  MensagemLida = 0 THEN ' MensagemLida : «Falso» '
                                              WHEN  MensagemLida = 1 THEN ' MensagemLida : «Verdadeiro» '
                                    END 
                         + '| DataLeitura : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLeitura, 113 ),'Nulo'))+'» '
                         + '| IdDepartamentoDestino : «' + RTRIM( ISNULL( CAST (IdDepartamentoDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Notificar IS NULL THEN ' Notificar : «Nulo» '
                                              WHEN  Notificar = 0 THEN ' Notificar : «Falso» '
                                              WHEN  Notificar = 1 THEN ' Notificar : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
