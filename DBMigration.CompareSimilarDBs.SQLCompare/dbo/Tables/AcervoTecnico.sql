CREATE TABLE [dbo].[AcervoTecnico] (
    [IdAcervoTecnico]             INT           IDENTITY (1, 1) NOT NULL,
    [IdProfissional]              INT           NULL,
    [IdPessoaJuridica]            INT           NULL,
    [IdPessoa]                    INT           NULL,
    [Numero]                      VARCHAR (100) NULL,
    [DataContratacao]             DATETIME      NULL,
    [DataVigencia]                DATETIME      NULL,
    [Ativo]                       BIT           CONSTRAINT [DEF_AcervoTecnico_Ativo] DEFAULT ((1)) NOT NULL,
    [IdSetorAtuacao]              INT           NULL,
    [DescricaoServicos]           TEXT          NULL,
    [Valor]                       MONEY         NULL,
    [IdTipoDocumentoAT]           INT           NULL,
    [IdProfissionalContratante]   INT           NULL,
    [DataCriacao]                 DATETIME      NULL,
    [NumContrato]                 VARCHAR (30)  NULL,
    [IdAcervoTecnicoPai]          INT           NULL,
    [NumeroDocumentoOrigem]       VARCHAR (100) NULL,
    [NotasFiscais]                VARCHAR (100) NULL,
    [DataAtestado]                DATETIME      NULL,
    [FolhasAtestado]              INT           NULL,
    [Sequencia]                   INT           NULL,
    [Observacao]                  TEXT          NULL,
    [CRAOrigem]                   VARCHAR (6)   NULL,
    [RCAOrigem]                   VARCHAR (100) NULL,
    [DataOrigem]                  DATETIME      NULL,
    [DataRegistro]                DATETIME      NULL,
    [IdTipoAtestado]              INT           NULL,
    [IdPessoaJuridicaContratante] INT           NULL,
    CONSTRAINT [PK_AcervoTecnico] PRIMARY KEY CLUSTERED ([IdAcervoTecnico] ASC),
    CONSTRAINT [FK_AcervoTecnico_IdAcervoTecnicoPai] FOREIGN KEY ([IdAcervoTecnicoPai]) REFERENCES [dbo].[AcervoTecnico] ([IdAcervoTecnico]),
    CONSTRAINT [FK_AcervoTecnico_PessoaJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_AcervoTecnico_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_AcervoTecnico_PessoasJuridicasContratantes] FOREIGN KEY ([IdPessoaJuridicaContratante]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_AcervoTecnico_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_AcervoTecnico_ProfissionaisContratantes] FOREIGN KEY ([IdProfissionalContratante]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_AcervoTecnico_SetoresAtuacao] FOREIGN KEY ([IdSetorAtuacao]) REFERENCES [dbo].[SetoresAtuacao] ([IdSetorAtuacao]),
    CONSTRAINT [FK_AcervoTecnico_TipoDocumentoAT] FOREIGN KEY ([IdTipoDocumentoAT]) REFERENCES [dbo].[TipoDocumentoAT] ([IdTipoDocumentoAT])
);


GO
CREATE TRIGGER [TrgLog_AcervoTecnico] ON [Implanta_CRPAM].[dbo].[AcervoTecnico] 
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
SET @TableName = 'AcervoTecnico'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContratacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContratacao, 113 ),'Nulo'))+'» '
                         + '| DataVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVigencia, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdSetorAtuacao : «' + RTRIM( ISNULL( CAST (IdSetorAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoAT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalContratante : «' + RTRIM( ISNULL( CAST (IdProfissionalContratante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| NumContrato : «' + RTRIM( ISNULL( CAST (NumContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnicoPai : «' + RTRIM( ISNULL( CAST (IdAcervoTecnicoPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumentoOrigem : «' + RTRIM( ISNULL( CAST (NumeroDocumentoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotasFiscais : «' + RTRIM( ISNULL( CAST (NotasFiscais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtestado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtestado, 113 ),'Nulo'))+'» '
                         + '| FolhasAtestado : «' + RTRIM( ISNULL( CAST (FolhasAtestado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CRAOrigem : «' + RTRIM( ISNULL( CAST (CRAOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RCAOrigem : «' + RTRIM( ISNULL( CAST (RCAOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOrigem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOrigem, 113 ),'Nulo'))+'» '
                         + '| DataRegistro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistro, 113 ),'Nulo'))+'» '
                         + '| IdTipoAtestado : «' + RTRIM( ISNULL( CAST (IdTipoAtestado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaContratante : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaContratante AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContratacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContratacao, 113 ),'Nulo'))+'» '
                         + '| DataVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVigencia, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdSetorAtuacao : «' + RTRIM( ISNULL( CAST (IdSetorAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoAT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalContratante : «' + RTRIM( ISNULL( CAST (IdProfissionalContratante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| NumContrato : «' + RTRIM( ISNULL( CAST (NumContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnicoPai : «' + RTRIM( ISNULL( CAST (IdAcervoTecnicoPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumentoOrigem : «' + RTRIM( ISNULL( CAST (NumeroDocumentoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotasFiscais : «' + RTRIM( ISNULL( CAST (NotasFiscais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtestado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtestado, 113 ),'Nulo'))+'» '
                         + '| FolhasAtestado : «' + RTRIM( ISNULL( CAST (FolhasAtestado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CRAOrigem : «' + RTRIM( ISNULL( CAST (CRAOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RCAOrigem : «' + RTRIM( ISNULL( CAST (RCAOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOrigem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOrigem, 113 ),'Nulo'))+'» '
                         + '| DataRegistro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistro, 113 ),'Nulo'))+'» '
                         + '| IdTipoAtestado : «' + RTRIM( ISNULL( CAST (IdTipoAtestado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaContratante : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaContratante AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContratacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContratacao, 113 ),'Nulo'))+'» '
                         + '| DataVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVigencia, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdSetorAtuacao : «' + RTRIM( ISNULL( CAST (IdSetorAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoAT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalContratante : «' + RTRIM( ISNULL( CAST (IdProfissionalContratante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| NumContrato : «' + RTRIM( ISNULL( CAST (NumContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnicoPai : «' + RTRIM( ISNULL( CAST (IdAcervoTecnicoPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumentoOrigem : «' + RTRIM( ISNULL( CAST (NumeroDocumentoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotasFiscais : «' + RTRIM( ISNULL( CAST (NotasFiscais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtestado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtestado, 113 ),'Nulo'))+'» '
                         + '| FolhasAtestado : «' + RTRIM( ISNULL( CAST (FolhasAtestado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CRAOrigem : «' + RTRIM( ISNULL( CAST (CRAOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RCAOrigem : «' + RTRIM( ISNULL( CAST (RCAOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOrigem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOrigem, 113 ),'Nulo'))+'» '
                         + '| DataRegistro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistro, 113 ),'Nulo'))+'» '
                         + '| IdTipoAtestado : «' + RTRIM( ISNULL( CAST (IdTipoAtestado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaContratante : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaContratante AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContratacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContratacao, 113 ),'Nulo'))+'» '
                         + '| DataVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVigencia, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Ativo IS NULL THEN ' Ativo : «Nulo» '
                                              WHEN  Ativo = 0 THEN ' Ativo : «Falso» '
                                              WHEN  Ativo = 1 THEN ' Ativo : «Verdadeiro» '
                                    END 
                         + '| IdSetorAtuacao : «' + RTRIM( ISNULL( CAST (IdSetorAtuacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoAT : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoAT AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalContratante : «' + RTRIM( ISNULL( CAST (IdProfissionalContratante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| NumContrato : «' + RTRIM( ISNULL( CAST (NumContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnicoPai : «' + RTRIM( ISNULL( CAST (IdAcervoTecnicoPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumentoOrigem : «' + RTRIM( ISNULL( CAST (NumeroDocumentoOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotasFiscais : «' + RTRIM( ISNULL( CAST (NotasFiscais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtestado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtestado, 113 ),'Nulo'))+'» '
                         + '| FolhasAtestado : «' + RTRIM( ISNULL( CAST (FolhasAtestado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencia : «' + RTRIM( ISNULL( CAST (Sequencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CRAOrigem : «' + RTRIM( ISNULL( CAST (CRAOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RCAOrigem : «' + RTRIM( ISNULL( CAST (RCAOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOrigem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOrigem, 113 ),'Nulo'))+'» '
                         + '| DataRegistro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistro, 113 ),'Nulo'))+'» '
                         + '| IdTipoAtestado : «' + RTRIM( ISNULL( CAST (IdTipoAtestado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaContratante : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaContratante AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
