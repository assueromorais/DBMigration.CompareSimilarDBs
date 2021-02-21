CREATE TABLE [dbo].[AutosInfracao] (
    [IdAutoInfracao]                INT          IDENTITY (1, 1) NOT NULL,
    [IdProcesso]                    INT          NULL,
    [IdDebitoInfracao]              INT          NULL,
    [NumeroInfracao]                VARCHAR (15) NULL,
    [DataInfracao]                  DATETIME     NULL,
    [RelatoInfracao]                TEXT         NULL,
    [IdFiscalizacao]                INT          NULL,
    [IdProfissional]                INT          NULL,
    [IdPessoaJuridica]              INT          NULL,
    [IdPessoa]                      INT          NULL,
    [HORA]                          DATETIME     NULL,
    [DataUltimaAtualizacao]         DATETIME     NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [Cancelado]                     BIT          DEFAULT ((0)) NOT NULL,
    [IdFaseInfracao]                INT          NULL,
    [Valor]                         MONEY        NULL,
    [Infrigencia]                   TEXT         NULL,
    [Sansao]                        TEXT         NULL,
    [Relato]                        TEXT         NULL,
    [Providencia]                   TEXT         NULL,
    [IdAndamentoFiscalizacao]       INT          NULL,
    CONSTRAINT [PK_AutosInfracao] PRIMARY KEY CLUSTERED ([IdAutoInfracao] ASC),
    CONSTRAINT [FK_AutosInfracao_Pessoa] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_AutosInfracao_PessoaJuridica] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_AutosInfracao_Profissional] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_Fiscalizacoes_AutosInfracao] FOREIGN KEY ([IdFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]),
    CONSTRAINT [FK_ZAutosInfracao_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]) NOT FOR REPLICATION
);


GO
/*Ocorr. 57841 - Seila*/

CREATE TRIGGER [dbo].[Trg_AutosInfracao_Usuario] ON [dbo].[AutosInfracao] 
	FOR INSERT,
		UPDATE
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
SET NOCOUNT OFF

GO
CREATE TRIGGER [TrgLog_AutosInfracao] ON [Implanta_CRPAM].[dbo].[AutosInfracao] 
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
SET @TableName = 'AutosInfracao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoInfracao : «' + RTRIM( ISNULL( CAST (IdDebitoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroInfracao : «' + RTRIM( ISNULL( CAST (NumeroInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInfracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInfracao, 113 ),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HORA : «' + RTRIM( ISNULL( CONVERT (CHAR, HORA, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Cancelado IS NULL THEN ' Cancelado : «Nulo» '
                                              WHEN  Cancelado = 0 THEN ' Cancelado : «Falso» '
                                              WHEN  Cancelado = 1 THEN ' Cancelado : «Verdadeiro» '
                                    END 
                         + '| IdFaseInfracao : «' + RTRIM( ISNULL( CAST (IdFaseInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAndamentoFiscalizacao : «' + RTRIM( ISNULL( CAST (IdAndamentoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoInfracao : «' + RTRIM( ISNULL( CAST (IdDebitoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroInfracao : «' + RTRIM( ISNULL( CAST (NumeroInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInfracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInfracao, 113 ),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HORA : «' + RTRIM( ISNULL( CONVERT (CHAR, HORA, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Cancelado IS NULL THEN ' Cancelado : «Nulo» '
                                              WHEN  Cancelado = 0 THEN ' Cancelado : «Falso» '
                                              WHEN  Cancelado = 1 THEN ' Cancelado : «Verdadeiro» '
                                    END 
                         + '| IdFaseInfracao : «' + RTRIM( ISNULL( CAST (IdFaseInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAndamentoFiscalizacao : «' + RTRIM( ISNULL( CAST (IdAndamentoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoInfracao : «' + RTRIM( ISNULL( CAST (IdDebitoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroInfracao : «' + RTRIM( ISNULL( CAST (NumeroInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInfracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInfracao, 113 ),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HORA : «' + RTRIM( ISNULL( CONVERT (CHAR, HORA, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Cancelado IS NULL THEN ' Cancelado : «Nulo» '
                                              WHEN  Cancelado = 0 THEN ' Cancelado : «Falso» '
                                              WHEN  Cancelado = 1 THEN ' Cancelado : «Verdadeiro» '
                                    END 
                         + '| IdFaseInfracao : «' + RTRIM( ISNULL( CAST (IdFaseInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAndamentoFiscalizacao : «' + RTRIM( ISNULL( CAST (IdAndamentoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAutoInfracao : «' + RTRIM( ISNULL( CAST (IdAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebitoInfracao : «' + RTRIM( ISNULL( CAST (IdDebitoInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroInfracao : «' + RTRIM( ISNULL( CAST (NumeroInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInfracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInfracao, 113 ),'Nulo'))+'» '
                         + '| IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HORA : «' + RTRIM( ISNULL( CONVERT (CHAR, HORA, 113 ),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Cancelado IS NULL THEN ' Cancelado : «Nulo» '
                                              WHEN  Cancelado = 0 THEN ' Cancelado : «Falso» '
                                              WHEN  Cancelado = 1 THEN ' Cancelado : «Verdadeiro» '
                                    END 
                         + '| IdFaseInfracao : «' + RTRIM( ISNULL( CAST (IdFaseInfracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAndamentoFiscalizacao : «' + RTRIM( ISNULL( CAST (IdAndamentoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
