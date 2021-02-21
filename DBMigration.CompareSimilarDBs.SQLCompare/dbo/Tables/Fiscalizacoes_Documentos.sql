CREATE TABLE [dbo].[Fiscalizacoes_Documentos] (
    [IdFiscalizacao]  INT NOT NULL,
    [IdDocumento]     INT NOT NULL,
    [IdProcessoFases] INT NULL,
    CONSTRAINT [FK_Fiscalizacoes_Documentos_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Fiscalizacoes_Documentos_Fiscalizacoes] FOREIGN KEY ([IdFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Processo_Fases] FOREIGN KEY ([IdProcessoFases]) REFERENCES [dbo].[Processo_Fases] ([IdProcessoFases])
);


GO
/*Ocorr. 57841 - Seila*/

CREATE TRIGGER [dbo].[Trg_Fiscalizacoes_Documentos_Usuario] ON [dbo].[Fiscalizacoes_Documentos] 
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

GO
CREATE TRIGGER [TrgLog_Fiscalizacoes_Documentos] ON [Implanta_CRPAM].[dbo].[Fiscalizacoes_Documentos] 
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
SET @TableName = 'Fiscalizacoes_Documentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoFases : «' + RTRIM( ISNULL( CAST (IdProcessoFases AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoFases : «' + RTRIM( ISNULL( CAST (IdProcessoFases AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoFases : «' + RTRIM( ISNULL( CAST (IdProcessoFases AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcessoFases : «' + RTRIM( ISNULL( CAST (IdProcessoFases AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
