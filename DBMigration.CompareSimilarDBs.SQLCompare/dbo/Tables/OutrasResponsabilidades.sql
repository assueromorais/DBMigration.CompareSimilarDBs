CREATE TABLE [dbo].[OutrasResponsabilidades] (
    [IdOutraResponsabilidade] INT          IDENTITY (1, 1) NOT NULL,
    [IdPessoaJuridica]        INT          NULL,
    [IdProfissional]          INT          NULL,
    [IdPessoaPJ]              INT          NULL,
    [IdPessoaPF]              INT          NULL,
    [IdTipoResponsabilidade]  INT          NULL,
    [IdSetorResponsabilidade] INT          NULL,
    [IdCargo]                 INT          NULL,
    [Tratamento]              VARCHAR (20) NULL,
    [E_Ativo]                 BIT          NULL,
    [DataInicio]              DATETIME     NULL,
    [DataFim]                 DATETIME     NULL,
    [PercentualParticipacao]  FLOAT (53)   NULL,
    [Observacoes]             TEXT         NULL,
    [ValorParticipacao]       MONEY        NULL,
    [TipoSocio]               INT          NULL,
    [SituacaoSocio]           INT          NULL,
    [idPessoaJuridicaResp]    INT          NULL,
    [AssinaDocumentos]        BIT          CONSTRAINT [DF_OutrasResponsabilidades_AssinaDocumentos] DEFAULT ((0)) NOT NULL,
    [Assinatura]              IMAGE        NULL,
    CONSTRAINT [PK_OutrasResponsabilidades] PRIMARY KEY CLUSTERED ([IdOutraResponsabilidade] ASC),
    CONSTRAINT [FK_OutrasResponsabilidades_Cargos] FOREIGN KEY ([IdCargo]) REFERENCES [dbo].[Cargos] ([IdCargo]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OutrasResponsabilidades_Pessoas] FOREIGN KEY ([IdPessoaPJ]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OutrasResponsabilidades_Pessoas1] FOREIGN KEY ([IdPessoaPF]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OutrasResponsabilidades_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OutrasResponsabilidades_PessoasJuridicas_IdPJResp] FOREIGN KEY ([idPessoaJuridicaResp]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OutrasResponsabilidades_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_OutrasResponsabilidades_SetoresResponsabilidade] FOREIGN KEY ([IdSetorResponsabilidade]) REFERENCES [dbo].[SetoresResponsabilidade] ([IdSetorResponsabilidade]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OutrasResponsabilidades_TiposResponsabilidade] FOREIGN KEY ([IdTipoResponsabilidade]) REFERENCES [dbo].[TiposResponsabilidade] ([IdTipoResponsabilidade]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_OutrasResponsabilidades] ON [Implanta_CRPAM].[dbo].[OutrasResponsabilidades] 
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
SET @TableName = 'OutrasResponsabilidades'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOutraResponsabilidade : «' + RTRIM( ISNULL( CAST (IdOutraResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPJ : «' + RTRIM( ISNULL( CAST (IdPessoaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPF : «' + RTRIM( ISNULL( CAST (IdPessoaPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoResponsabilidade : «' + RTRIM( ISNULL( CAST (IdTipoResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSetorResponsabilidade : «' + RTRIM( ISNULL( CAST (IdSetorResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tratamento : «' + RTRIM( ISNULL( CAST (Tratamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Ativo IS NULL THEN ' E_Ativo : «Nulo» '
                                              WHEN  E_Ativo = 0 THEN ' E_Ativo : «Falso» '
                                              WHEN  E_Ativo = 1 THEN ' E_Ativo : «Verdadeiro» '
                                    END 
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| PercentualParticipacao : «' + RTRIM( ISNULL( CAST (PercentualParticipacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorParticipacao : «' + RTRIM( ISNULL( CAST (ValorParticipacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoSocio : «' + RTRIM( ISNULL( CAST (TipoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoSocio : «' + RTRIM( ISNULL( CAST (SituacaoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idPessoaJuridicaResp : «' + RTRIM( ISNULL( CAST (idPessoaJuridicaResp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AssinaDocumentos IS NULL THEN ' AssinaDocumentos : «Nulo» '
                                              WHEN  AssinaDocumentos = 0 THEN ' AssinaDocumentos : «Falso» '
                                              WHEN  AssinaDocumentos = 1 THEN ' AssinaDocumentos : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdOutraResponsabilidade : «' + RTRIM( ISNULL( CAST (IdOutraResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPJ : «' + RTRIM( ISNULL( CAST (IdPessoaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPF : «' + RTRIM( ISNULL( CAST (IdPessoaPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoResponsabilidade : «' + RTRIM( ISNULL( CAST (IdTipoResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSetorResponsabilidade : «' + RTRIM( ISNULL( CAST (IdSetorResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tratamento : «' + RTRIM( ISNULL( CAST (Tratamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Ativo IS NULL THEN ' E_Ativo : «Nulo» '
                                              WHEN  E_Ativo = 0 THEN ' E_Ativo : «Falso» '
                                              WHEN  E_Ativo = 1 THEN ' E_Ativo : «Verdadeiro» '
                                    END 
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| PercentualParticipacao : «' + RTRIM( ISNULL( CAST (PercentualParticipacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorParticipacao : «' + RTRIM( ISNULL( CAST (ValorParticipacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoSocio : «' + RTRIM( ISNULL( CAST (TipoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoSocio : «' + RTRIM( ISNULL( CAST (SituacaoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idPessoaJuridicaResp : «' + RTRIM( ISNULL( CAST (idPessoaJuridicaResp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AssinaDocumentos IS NULL THEN ' AssinaDocumentos : «Nulo» '
                                              WHEN  AssinaDocumentos = 0 THEN ' AssinaDocumentos : «Falso» '
                                              WHEN  AssinaDocumentos = 1 THEN ' AssinaDocumentos : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdOutraResponsabilidade : «' + RTRIM( ISNULL( CAST (IdOutraResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPJ : «' + RTRIM( ISNULL( CAST (IdPessoaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPF : «' + RTRIM( ISNULL( CAST (IdPessoaPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoResponsabilidade : «' + RTRIM( ISNULL( CAST (IdTipoResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSetorResponsabilidade : «' + RTRIM( ISNULL( CAST (IdSetorResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tratamento : «' + RTRIM( ISNULL( CAST (Tratamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Ativo IS NULL THEN ' E_Ativo : «Nulo» '
                                              WHEN  E_Ativo = 0 THEN ' E_Ativo : «Falso» '
                                              WHEN  E_Ativo = 1 THEN ' E_Ativo : «Verdadeiro» '
                                    END 
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| PercentualParticipacao : «' + RTRIM( ISNULL( CAST (PercentualParticipacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorParticipacao : «' + RTRIM( ISNULL( CAST (ValorParticipacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoSocio : «' + RTRIM( ISNULL( CAST (TipoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoSocio : «' + RTRIM( ISNULL( CAST (SituacaoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idPessoaJuridicaResp : «' + RTRIM( ISNULL( CAST (idPessoaJuridicaResp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AssinaDocumentos IS NULL THEN ' AssinaDocumentos : «Nulo» '
                                              WHEN  AssinaDocumentos = 0 THEN ' AssinaDocumentos : «Falso» '
                                              WHEN  AssinaDocumentos = 1 THEN ' AssinaDocumentos : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOutraResponsabilidade : «' + RTRIM( ISNULL( CAST (IdOutraResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPJ : «' + RTRIM( ISNULL( CAST (IdPessoaPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPF : «' + RTRIM( ISNULL( CAST (IdPessoaPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoResponsabilidade : «' + RTRIM( ISNULL( CAST (IdTipoResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSetorResponsabilidade : «' + RTRIM( ISNULL( CAST (IdSetorResponsabilidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tratamento : «' + RTRIM( ISNULL( CAST (Tratamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Ativo IS NULL THEN ' E_Ativo : «Nulo» '
                                              WHEN  E_Ativo = 0 THEN ' E_Ativo : «Falso» '
                                              WHEN  E_Ativo = 1 THEN ' E_Ativo : «Verdadeiro» '
                                    END 
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| PercentualParticipacao : «' + RTRIM( ISNULL( CAST (PercentualParticipacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorParticipacao : «' + RTRIM( ISNULL( CAST (ValorParticipacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoSocio : «' + RTRIM( ISNULL( CAST (TipoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoSocio : «' + RTRIM( ISNULL( CAST (SituacaoSocio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idPessoaJuridicaResp : «' + RTRIM( ISNULL( CAST (idPessoaJuridicaResp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AssinaDocumentos IS NULL THEN ' AssinaDocumentos : «Nulo» '
                                              WHEN  AssinaDocumentos = 0 THEN ' AssinaDocumentos : «Falso» '
                                              WHEN  AssinaDocumentos = 1 THEN ' AssinaDocumentos : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
