CREATE TABLE [dbo].[MovimentacoesBensWeb] (
    [IdMovimentacaoWeb]      INT           IDENTITY (1, 1) NOT NULL,
    [IdItem]                 INT           NOT NULL,
    [IdUnidadeOrigem]        INT           NULL,
    [IdResponsavelOrigem]    INT           NULL,
    [IdUnidadeDestino]       INT           NULL,
    [IdResponsavelDestino]   INT           NULL,
    [DataMovimentacao]       DATETIME      NOT NULL,
    [DataRecebido]           DATETIME      NOT NULL,
    [DataEfetivacao]         DATETIME      NOT NULL,
    [IdSituacaoMovimentacao] INT           NULL,
    [Observacao]             VARCHAR (500) NULL,
    CONSTRAINT [PK_MovimentacoesBensWeb] PRIMARY KEY NONCLUSTERED ([IdMovimentacaoWeb] ASC),
    CONSTRAINT [FK_MovimentacoesBens_ResponsaveisDestino] FOREIGN KEY ([IdResponsavelDestino]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_MovimentacoesBens_ResponsaveisOrigem] FOREIGN KEY ([IdResponsavelOrigem]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_MovimentacoesBens_SituacoesMovimentacao] FOREIGN KEY ([IdSituacaoMovimentacao]) REFERENCES [dbo].[SituacoesMovimentacao] ([IdSituacaoMovimentacao]),
    CONSTRAINT [FK_MovimentacoesBens_UnidadesDestino] FOREIGN KEY ([IdUnidadeDestino]) REFERENCES [dbo].[Unidades] ([IdUnidade]),
    CONSTRAINT [FK_MovimentacoesBens_UnidadesOrigem] FOREIGN KEY ([IdUnidadeOrigem]) REFERENCES [dbo].[Unidades] ([IdUnidade]),
    CONSTRAINT [FK_MovimentacoesBensWeb_ItensMoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensMoveis] ([IdItem])
);


GO
CREATE TRIGGER [TrgLog_MovimentacoesBensWeb] ON [Implanta_CRPAM].[dbo].[MovimentacoesBensWeb] 
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
SET @TableName = 'MovimentacoesBensWeb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMovimentacaoWeb : «' + RTRIM( ISNULL( CAST (IdMovimentacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeOrigem : «' + RTRIM( ISNULL( CAST (IdUnidadeOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelOrigem : «' + RTRIM( ISNULL( CAST (IdResponsavelOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeDestino : «' + RTRIM( ISNULL( CAST (IdUnidadeDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelDestino : «' + RTRIM( ISNULL( CAST (IdResponsavelDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| DataRecebido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebido, 113 ),'Nulo'))+'» '
                         + '| DataEfetivacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEfetivacao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoMovimentacao : «' + RTRIM( ISNULL( CAST (IdSituacaoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMovimentacaoWeb : «' + RTRIM( ISNULL( CAST (IdMovimentacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeOrigem : «' + RTRIM( ISNULL( CAST (IdUnidadeOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelOrigem : «' + RTRIM( ISNULL( CAST (IdResponsavelOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeDestino : «' + RTRIM( ISNULL( CAST (IdUnidadeDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelDestino : «' + RTRIM( ISNULL( CAST (IdResponsavelDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| DataRecebido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebido, 113 ),'Nulo'))+'» '
                         + '| DataEfetivacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEfetivacao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoMovimentacao : «' + RTRIM( ISNULL( CAST (IdSituacaoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMovimentacaoWeb : «' + RTRIM( ISNULL( CAST (IdMovimentacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeOrigem : «' + RTRIM( ISNULL( CAST (IdUnidadeOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelOrigem : «' + RTRIM( ISNULL( CAST (IdResponsavelOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeDestino : «' + RTRIM( ISNULL( CAST (IdUnidadeDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelDestino : «' + RTRIM( ISNULL( CAST (IdResponsavelDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| DataRecebido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebido, 113 ),'Nulo'))+'» '
                         + '| DataEfetivacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEfetivacao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoMovimentacao : «' + RTRIM( ISNULL( CAST (IdSituacaoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMovimentacaoWeb : «' + RTRIM( ISNULL( CAST (IdMovimentacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeOrigem : «' + RTRIM( ISNULL( CAST (IdUnidadeOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelOrigem : «' + RTRIM( ISNULL( CAST (IdResponsavelOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeDestino : «' + RTRIM( ISNULL( CAST (IdUnidadeDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelDestino : «' + RTRIM( ISNULL( CAST (IdResponsavelDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentacao, 113 ),'Nulo'))+'» '
                         + '| DataRecebido : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebido, 113 ),'Nulo'))+'» '
                         + '| DataEfetivacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEfetivacao, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoMovimentacao : «' + RTRIM( ISNULL( CAST (IdSituacaoMovimentacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
