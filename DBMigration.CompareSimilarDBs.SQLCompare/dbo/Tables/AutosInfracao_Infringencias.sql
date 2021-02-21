CREATE TABLE [dbo].[AutosInfracao_Infringencias] (
    [IdAutoInfracao] INT      NOT NULL,
    [IdInfringencia] INT      NOT NULL,
    [Numero]         INT      NULL,
    [data]           DATETIME NULL,
    CONSTRAINT [PK_AutosInfracao_Infringencias] PRIMARY KEY CLUSTERED ([IdAutoInfracao] ASC, [IdInfringencia] ASC),
    CONSTRAINT [FK_AutosInfracao_Infringencias_AutosInfracao] FOREIGN KEY ([IdAutoInfracao]) REFERENCES [dbo].[AutosInfracao] ([IdAutoInfracao]),
    CONSTRAINT [FK_AutosInfracao_Infringencias_Infringencias] FOREIGN KEY ([IdInfringencia]) REFERENCES [dbo].[Infringencias] ([IdInfringencia])
);


GO
CREATE TRIGGER [TrgLog_AutosInfracao_Infringencias] ON [Implanta_CRPAM].[dbo].[AutosInfracao_Infringencias] 
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
SET @TableName = 'AutosInfracao_Infringencias'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInfringencia : «' + RTRIM( ISNULL( CAST (IdInfringencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| data : «' + RTRIM( ISNULL( CONVERT (CHAR, data, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInfringencia : «' + RTRIM( ISNULL( CAST (IdInfringencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| data : «' + RTRIM( ISNULL( CONVERT (CHAR, data, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInfringencia : «' + RTRIM( ISNULL( CAST (IdInfringencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| data : «' + RTRIM( ISNULL( CONVERT (CHAR, data, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInfringencia : «' + RTRIM( ISNULL( CAST (IdInfringencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| data : «' + RTRIM( ISNULL( CONVERT (CHAR, data, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 

GO
/*Ocorr. 57841 - Seila*/

CREATE TRIGGER [dbo].[Trg_AutosInfracao_Infringencias_Usuario] ON [dbo].[AutosInfracao_Infringencias] 
	FOR INSERT,
		UPDATE,
		DELETE
AS
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
	BEGIN		
		UPDATE
			A	
		SET
			A.DataUltimaAtualizacao = GETDATE(),
			A.UsuarioUltimaAtualizacao = HOST_NAME(),
			A.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			INSERTED I
			JOIN AutosInfracao A ON A.IdAutoInfracao = I.IdAutoInfracao	
	END
ELSE IF EXISTS (SELECT TOP 1 1 FROM DELETED)
	BEGIN		
		UPDATE
			A	
		SET
			A.DataUltimaAtualizacao = GETDATE(),
			A.UsuarioUltimaAtualizacao = HOST_NAME(),
			A.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			DELETED D
			JOIN AutosInfracao A ON A.IdAutoInfracao = D.IdAutoInfracao			
	END	 
SET NOCOUNT OFF
