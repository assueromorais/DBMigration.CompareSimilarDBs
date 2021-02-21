CREATE TABLE [dbo].[Fiscalizacoes_SituacoesFiscalizacao] (
    [IdFiscalizacao_SitFiscalizacao] INT      IDENTITY (1, 1) NOT NULL,
    [IdFiscalizacao]                 INT      NOT NULL,
    [IdSituacaoProcFis]              INT      NOT NULL,
    [DataSituacaoFisc]               DATETIME NOT NULL,
    CONSTRAINT [PK_Fiscalizacoes_SituacoesFiscalizacoes] PRIMARY KEY CLUSTERED ([IdFiscalizacao_SitFiscalizacao] ASC),
    CONSTRAINT [FK_Fiscalizacoes_SituacoesFiscalizacao_SituacoesProcFis] FOREIGN KEY ([IdSituacaoProcFis]) REFERENCES [dbo].[SituacoesProcFis] ([IdSituacaoProcFis]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Fiscalizacoes_SituacoesFiscalizacoes_Fiscalizacoes] FOREIGN KEY ([IdFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao])
);


GO
CREATE TRIGGER [TrgLog_Fiscalizacoes_SituacoesFiscalizacao] ON [Implanta_CRPAM].[dbo].[Fiscalizacoes_SituacoesFiscalizacao] 
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
SET @TableName = 'Fiscalizacoes_SituacoesFiscalizacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFiscalizacao_SitFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao_SitFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoProcFis : «' + RTRIM( ISNULL( CAST (IdSituacaoProcFis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacaoFisc : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacaoFisc, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFiscalizacao_SitFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao_SitFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoProcFis : «' + RTRIM( ISNULL( CAST (IdSituacaoProcFis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacaoFisc : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacaoFisc, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFiscalizacao_SitFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao_SitFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoProcFis : «' + RTRIM( ISNULL( CAST (IdSituacaoProcFis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacaoFisc : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacaoFisc, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFiscalizacao_SitFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao_SitFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoProcFis : «' + RTRIM( ISNULL( CAST (IdSituacaoProcFis AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacaoFisc : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacaoFisc, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 

GO
/*Ocorr. 57841 - Seila.*/

CREATE TRIGGER [dbo].[Trg_Fiscalizacoes_SituacoesFiscalizacao_Usuario] ON [dbo].[Fiscalizacoes_SituacoesFiscalizacao] 
	FOR INSERT,
		UPDATE,
		DELETE
AS
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
	BEGIN		
		UPDATE
			F	
		SET
			F.DataUltimaAtualizacao = GETDATE(),
			F.UsuarioUltimaAtualizacao = HOST_NAME(),
			F.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			INSERTED I
			JOIN Fiscalizacoes F ON F.IdFiscalizacao = I.IdFiscalizacao			
	END
ELSE IF EXISTS (SELECT TOP 1 1 FROM DELETED)
	BEGIN		
		UPDATE
			F	
		SET
			F.DataUltimaAtualizacao = GETDATE(),
			F.UsuarioUltimaAtualizacao = HOST_NAME(),
			F.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			DELETED D
			JOIN Fiscalizacoes F ON F.IdFiscalizacao = D.IdFiscalizacao			
	END	 
SET NOCOUNT OFF
