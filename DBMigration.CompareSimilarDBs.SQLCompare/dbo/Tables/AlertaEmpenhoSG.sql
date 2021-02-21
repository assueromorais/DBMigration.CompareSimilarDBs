CREATE TABLE [dbo].[AlertaEmpenhoSG] (
    [IdAlertaEmpenhoSG]                     INT              IDENTITY (1, 1) NOT NULL,
    [IdConta]                               INT              NULL,
    [IdPessoa]                              INT              NULL,
    [DataSolicitacao]                       DATETIME         NULL,
    [Valor]                                 MONEY            NULL,
    [Historico]                             TEXT             NULL,
    [E_Empenho]                             BIT              NOT NULL,
    [IdProcesso]                            INT              NULL,
    [IdOrdem]                               INT              NULL,
    [IdPreEmpenho]                          INT              NULL,
    [IdEmpenho]                             INT              NULL,
    [Situacao]                              VARCHAR (15)     NOT NULL,
    [JustificativaRecusa]                   TEXT             NULL,
    [DataRecusa]                            DATETIME         NULL,
    [IdPessoaSolicitacaoViagem]             INT              NULL,
    [IdSolicitacaoReservaOrcamentariaMCASP] UNIQUEIDENTIFIER NULL,
    [IdEmpenhoMCASP]                        INT              NULL,
    [IdPreEmpenhoMCASP]                     UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_AlertaEmpenhoSG] PRIMARY KEY NONCLUSTERED ([IdAlertaEmpenhoSG] ASC),
    CONSTRAINT [FK_AlertaEmpenhoSG_EmpenhosMCASP] FOREIGN KEY ([IdEmpenhoMCASP]) REFERENCES [dbo].[EmpenhosMCASP] ([IdEmpenhoMCASP]) NOT FOR REPLICATION,
    CONSTRAINT [FK_AlertaEmpenhoSG_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacaoViagem]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem]),
    CONSTRAINT [FK_AlertaEmpenhoSG_PreEmpenhosMCASP] FOREIGN KEY ([IdPreEmpenhoMCASP]) REFERENCES [dbo].[PreEmpenhosMCASP] ([IdPreEmpenhoMCASP]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_AlertaEmpenhoSG] ON [Implanta_CRPAM].[dbo].[AlertaEmpenhoSG] 
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
SET @TableName = 'AlertaEmpenhoSG'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAlertaEmpenhoSG : «' + RTRIM( ISNULL( CAST (IdAlertaEmpenhoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Empenho IS NULL THEN ' E_Empenho : «Nulo» '
                                              WHEN  E_Empenho = 0 THEN ' E_Empenho : «Falso» '
                                              WHEN  E_Empenho = 1 THEN ' E_Empenho : «Verdadeiro» '
                                    END 
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreEmpenho : «' + RTRIM( ISNULL( CAST (IdPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecusa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecusa, 113 ),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAlertaEmpenhoSG : «' + RTRIM( ISNULL( CAST (IdAlertaEmpenhoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Empenho IS NULL THEN ' E_Empenho : «Nulo» '
                                              WHEN  E_Empenho = 0 THEN ' E_Empenho : «Falso» '
                                              WHEN  E_Empenho = 1 THEN ' E_Empenho : «Verdadeiro» '
                                    END 
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreEmpenho : «' + RTRIM( ISNULL( CAST (IdPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecusa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecusa, 113 ),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAlertaEmpenhoSG : «' + RTRIM( ISNULL( CAST (IdAlertaEmpenhoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Empenho IS NULL THEN ' E_Empenho : «Nulo» '
                                              WHEN  E_Empenho = 0 THEN ' E_Empenho : «Falso» '
                                              WHEN  E_Empenho = 1 THEN ' E_Empenho : «Verdadeiro» '
                                    END 
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreEmpenho : «' + RTRIM( ISNULL( CAST (IdPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecusa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecusa, 113 ),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAlertaEmpenhoSG : «' + RTRIM( ISNULL( CAST (IdAlertaEmpenhoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Empenho IS NULL THEN ' E_Empenho : «Nulo» '
                                              WHEN  E_Empenho = 0 THEN ' E_Empenho : «Falso» '
                                              WHEN  E_Empenho = 1 THEN ' E_Empenho : «Verdadeiro» '
                                    END 
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreEmpenho : «' + RTRIM( ISNULL( CAST (IdPreEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecusa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecusa, 113 ),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
