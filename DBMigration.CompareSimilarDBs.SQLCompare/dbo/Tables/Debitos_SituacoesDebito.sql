CREATE TABLE [dbo].[Debitos_SituacoesDebito] (
    [IdDebito]                      INT          NOT NULL,
    [IdSituacaoDebito]              INT          NOT NULL,
    [DataSituacao]                  DATETIME     NOT NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [IdMotivoEstorno]               INT          NULL,
    CONSTRAINT [FK_Debitos_SituacoesDebito_Debitos] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito]),
    CONSTRAINT [FK_Debitos_SituacoesDebito_SituacoesDebito] FOREIGN KEY ([IdSituacaoDebito]) REFERENCES [dbo].[SituacoesDebito] ([IdSituacaoDebito])
);


GO
CREATE TRIGGER [TrgLog_Debitos_SituacoesDebito] ON [Implanta_CRPAM].[dbo].[Debitos_SituacoesDebito] 
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
SET @TableName = 'Debitos_SituacoesDebito'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoEstorno : «' + RTRIM( ISNULL( CAST (IdMotivoEstorno AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoEstorno : «' + RTRIM( ISNULL( CAST (IdMotivoEstorno AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoEstorno : «' + RTRIM( ISNULL( CAST (IdMotivoEstorno AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoEstorno : «' + RTRIM( ISNULL( CAST (IdMotivoEstorno AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 

GO


/*Oc. 96534 - Gustavo*/
    
CREATE TRIGGER [Trg_Debitos_SituacoesDebito_Usuario]
ON [Debitos_SituacoesDebito]
FOR  INSERT, UPDATE
AS
	DECLARE @Depto VARCHAR(60)
	
	SELECT @Depto = NomeDepto
	FROM   Departamentos
	       INNER JOIN Usuarios
	            ON  Departamentos.IdDepto = Usuarios.IdDepartamento
	WHERE  NomeUsuario = HOST_NAME()	
	
	UPDATE dsd
	SET    dsd.UsuarioUltimaAtualizacao = HOST_NAME(),
	       dsd.DepartamentoUltimaAtualizacao = @Depto
	FROM   Debitos_SituacoesDebito dsd
	       JOIN INSERTED i
	            ON  dsd.IdDebito = i.IdDebito
	            AND dsd.IdSituacaoDebito = i.IdSituacaoDebito
	            AND dsd.DataSituacao = i.DataSituacao

