CREATE TABLE [dbo].[Ocorrencias] (
    [IdOcorrenciaProcesso]  INT      IDENTITY (1, 1) NOT NULL,
    [IndPaiOcorrencia]      INT      NOT NULL,
    [IdPaiOcorrencia]       INT      NOT NULL,
    [DataOcorrencia]        DATETIME NULL,
    [TextoOcorrencia]       TEXT     NOT NULL,
    [IdUsuarioCriacao]      INT      NULL,
    [IdDepartamentoCriacao] INT      NULL,
    [IdSituacaoOcorrencia]  INT      NULL,
    [IdTramitacao]          INT      NULL,
    [ExibirCadastroPFPJ]    BIT      CONSTRAINT [DF_Ocorrencias_ExibirCadastroPFPJ] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_OcorrenciaProcesso] PRIMARY KEY CLUSTERED ([IdOcorrenciaProcesso] ASC),
    CONSTRAINT [FK_IdTramitacao_Ocorrencias_Tramitacoes] FOREIGN KEY ([IdTramitacao]) REFERENCES [dbo].[Tramitacoes] ([IdTramitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ocorrencias_AutosInfracao] FOREIGN KEY ([IdPaiOcorrencia]) REFERENCES [dbo].[AutosInfracao] ([IdAutoInfracao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ocorrencias_DocumentosSisdoc] FOREIGN KEY ([IdPaiOcorrencia]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ocorrencias_Fiscalizacoes] FOREIGN KEY ([IdPaiOcorrencia]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ocorrencias_Processo_Processos] FOREIGN KEY ([IdPaiOcorrencia]) REFERENCES [dbo].[Processos] ([IdProcesso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ocorrencias_SituacoesOcorrencia] FOREIGN KEY ([IdSituacaoOcorrencia]) REFERENCES [dbo].[SituacoesOcorrencia] ([IdSituacaoOcorrencia]),
    CONSTRAINT [FK_Ocorrencias_Usuarios] FOREIGN KEY ([IdUsuarioCriacao]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
ALTER TABLE [dbo].[Ocorrencias] NOCHECK CONSTRAINT [FK_IdTramitacao_Ocorrencias_Tramitacoes];


GO
ALTER TABLE [dbo].[Ocorrencias] NOCHECK CONSTRAINT [FK_Ocorrencias_AutosInfracao];


GO
ALTER TABLE [dbo].[Ocorrencias] NOCHECK CONSTRAINT [FK_Ocorrencias_DocumentosSisdoc];


GO
ALTER TABLE [dbo].[Ocorrencias] NOCHECK CONSTRAINT [FK_Ocorrencias_Fiscalizacoes];


GO
ALTER TABLE [dbo].[Ocorrencias] NOCHECK CONSTRAINT [FK_Ocorrencias_Processo_Processos];


GO
/*Ocorr. 57841 - Seila*/

CREATE TRIGGER [dbo].[Trg_OcorrenciasAutosInfracao_Usuario] ON [dbo].[Ocorrencias] 
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
			JOIN AutosInfracao A ON A.IdAutoInfracao = I.IdPaiOcorrencia
			JOIN Ocorrencias O ON A.IdAutoInfracao = O.IdPaiOcorrencia	
		WHERE O.IndPaiOcorrencia = 6				
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
			JOIN AutosInfracao A ON A.IdAutoInfracao = D.IdPaiOcorrencia
			JOIN Ocorrencias O ON A.IdAutoInfracao = O.IdPaiOcorrencia	
		WHERE O.IndPaiOcorrencia = 6						
	END	 
SET NOCOUNT OFF

GO
CREATE TRIGGER [TrgLog_Ocorrencias] ON [Implanta_CRPAM].[dbo].[Ocorrencias] 
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
SET @TableName = 'Ocorrencias'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOcorrenciaProcesso : «' + RTRIM( ISNULL( CAST (IdOcorrenciaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPaiOcorrencia : «' + RTRIM( ISNULL( CAST (IndPaiOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPaiOcorrencia : «' + RTRIM( ISNULL( CAST (IdPaiOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOcorrencia, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTramitacao : «' + RTRIM( ISNULL( CAST (IdTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirCadastroPFPJ IS NULL THEN ' ExibirCadastroPFPJ : «Nulo» '
                                              WHEN  ExibirCadastroPFPJ = 0 THEN ' ExibirCadastroPFPJ : «Falso» '
                                              WHEN  ExibirCadastroPFPJ = 1 THEN ' ExibirCadastroPFPJ : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdOcorrenciaProcesso : «' + RTRIM( ISNULL( CAST (IdOcorrenciaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPaiOcorrencia : «' + RTRIM( ISNULL( CAST (IndPaiOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPaiOcorrencia : «' + RTRIM( ISNULL( CAST (IdPaiOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOcorrencia, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTramitacao : «' + RTRIM( ISNULL( CAST (IdTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirCadastroPFPJ IS NULL THEN ' ExibirCadastroPFPJ : «Nulo» '
                                              WHEN  ExibirCadastroPFPJ = 0 THEN ' ExibirCadastroPFPJ : «Falso» '
                                              WHEN  ExibirCadastroPFPJ = 1 THEN ' ExibirCadastroPFPJ : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdOcorrenciaProcesso : «' + RTRIM( ISNULL( CAST (IdOcorrenciaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPaiOcorrencia : «' + RTRIM( ISNULL( CAST (IndPaiOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPaiOcorrencia : «' + RTRIM( ISNULL( CAST (IdPaiOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOcorrencia, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTramitacao : «' + RTRIM( ISNULL( CAST (IdTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirCadastroPFPJ IS NULL THEN ' ExibirCadastroPFPJ : «Nulo» '
                                              WHEN  ExibirCadastroPFPJ = 0 THEN ' ExibirCadastroPFPJ : «Falso» '
                                              WHEN  ExibirCadastroPFPJ = 1 THEN ' ExibirCadastroPFPJ : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOcorrenciaProcesso : «' + RTRIM( ISNULL( CAST (IdOcorrenciaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndPaiOcorrencia : «' + RTRIM( ISNULL( CAST (IndPaiOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPaiOcorrencia : «' + RTRIM( ISNULL( CAST (IdPaiOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOcorrencia, 113 ),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTramitacao : «' + RTRIM( ISNULL( CAST (IdTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ExibirCadastroPFPJ IS NULL THEN ' ExibirCadastroPFPJ : «Nulo» '
                                              WHEN  ExibirCadastroPFPJ = 0 THEN ' ExibirCadastroPFPJ : «Falso» '
                                              WHEN  ExibirCadastroPFPJ = 1 THEN ' ExibirCadastroPFPJ : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
