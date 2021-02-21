CREATE TABLE [dbo].[ComplementoDocEmitido] (
    [IdComplementoDocEmitido] INT           IDENTITY (1, 1) NOT NULL,
    [IdDocumento]             INT           NOT NULL,
    [IdFormaNotificacao]      INT           NULL,
    [DataPostagem]            DATETIME      NULL,
    [DataRecebInteressado]    DATETIME      NULL,
    [DocRecebidoPor]          VARCHAR (50)  NULL,
    [NumeroRecibo]            VARCHAR (20)  NULL,
    [E_ValePostal]            BIT           NULL,
    [CodigoCorrespondencia]   VARCHAR (20)  NULL,
    [ValorTaxa]               MONEY         NULL,
    [ValorEnvio]              MONEY         NULL,
    [DataRetornoValePostal]   DATETIME      NULL,
    [Peso]                    MONEY         NULL,
    [IdPesosValores]          INT           NULL,
    [IdAssinatura1Prof]       INT           NULL,
    [IdAssinatura2Prof]       INT           NULL,
    [IdAssinatura3Prof]       INT           NULL,
    [IdMotivoDevolucao]       INT           NULL,
    [DtDevolucaoCorresp]      DATETIME      NULL,
    [Observacao]              VARCHAR (200) NULL,
    [idUsuarioPostagem]       INT           NULL,
    CONSTRAINT [PK_ComplementoDocEmitido] PRIMARY KEY CLUSTERED ([IdComplementoDocEmitido] ASC),
    CONSTRAINT [FK_ComplementoDocEmitido_documentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]),
    CONSTRAINT [FK_ComplementoDocEmitido_FormasNotificacao] FOREIGN KEY ([IdFormaNotificacao]) REFERENCES [dbo].[FormasNotificacao] ([IdFormaNotificacao]),
    CONSTRAINT [FK_ComplementoDocEmitido_Profissionais] FOREIGN KEY ([IdAssinatura1Prof]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ComplementoDocEmitido_Profissionais1] FOREIGN KEY ([IdAssinatura2Prof]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ComplementoDocEmitido_Profissionais2] FOREIGN KEY ([IdAssinatura3Prof]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ComplementoDocEmitido] ON [Implanta_CRPAM].[dbo].[ComplementoDocEmitido] 
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
SET @TableName = 'ComplementoDocEmitido'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdComplementoDocEmitido : «' + RTRIM( ISNULL( CAST (IdComplementoDocEmitido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaNotificacao : «' + RTRIM( ISNULL( CAST (IdFormaNotificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPostagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPostagem, 113 ),'Nulo'))+'» '
                         + '| DataRecebInteressado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebInteressado, 113 ),'Nulo'))+'» '
                         + '| DocRecebidoPor : «' + RTRIM( ISNULL( CAST (DocRecebidoPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRecibo : «' + RTRIM( ISNULL( CAST (NumeroRecibo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ValePostal IS NULL THEN ' E_ValePostal : «Nulo» '
                                              WHEN  E_ValePostal = 0 THEN ' E_ValePostal : «Falso» '
                                              WHEN  E_ValePostal = 1 THEN ' E_ValePostal : «Verdadeiro» '
                                    END 
                         + '| CodigoCorrespondencia : «' + RTRIM( ISNULL( CAST (CodigoCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTaxa : «' + RTRIM( ISNULL( CAST (ValorTaxa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEnvio : «' + RTRIM( ISNULL( CAST (ValorEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetornoValePostal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetornoValePostal, 113 ),'Nulo'))+'» '
                         + '| Peso : «' + RTRIM( ISNULL( CAST (Peso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPesosValores : «' + RTRIM( ISNULL( CAST (IdPesosValores AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura1Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura1Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura2Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura2Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura3Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura3Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtDevolucaoCorresp : «' + RTRIM( ISNULL( CONVERT (CHAR, DtDevolucaoCorresp, 113 ),'Nulo'))+'» '
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idUsuarioPostagem : «' + RTRIM( ISNULL( CAST (idUsuarioPostagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdComplementoDocEmitido : «' + RTRIM( ISNULL( CAST (IdComplementoDocEmitido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaNotificacao : «' + RTRIM( ISNULL( CAST (IdFormaNotificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPostagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPostagem, 113 ),'Nulo'))+'» '
                         + '| DataRecebInteressado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebInteressado, 113 ),'Nulo'))+'» '
                         + '| DocRecebidoPor : «' + RTRIM( ISNULL( CAST (DocRecebidoPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRecibo : «' + RTRIM( ISNULL( CAST (NumeroRecibo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ValePostal IS NULL THEN ' E_ValePostal : «Nulo» '
                                              WHEN  E_ValePostal = 0 THEN ' E_ValePostal : «Falso» '
                                              WHEN  E_ValePostal = 1 THEN ' E_ValePostal : «Verdadeiro» '
                                    END 
                         + '| CodigoCorrespondencia : «' + RTRIM( ISNULL( CAST (CodigoCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTaxa : «' + RTRIM( ISNULL( CAST (ValorTaxa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEnvio : «' + RTRIM( ISNULL( CAST (ValorEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetornoValePostal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetornoValePostal, 113 ),'Nulo'))+'» '
                         + '| Peso : «' + RTRIM( ISNULL( CAST (Peso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPesosValores : «' + RTRIM( ISNULL( CAST (IdPesosValores AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura1Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura1Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura2Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura2Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura3Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura3Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtDevolucaoCorresp : «' + RTRIM( ISNULL( CONVERT (CHAR, DtDevolucaoCorresp, 113 ),'Nulo'))+'» '
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idUsuarioPostagem : «' + RTRIM( ISNULL( CAST (idUsuarioPostagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdComplementoDocEmitido : «' + RTRIM( ISNULL( CAST (IdComplementoDocEmitido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaNotificacao : «' + RTRIM( ISNULL( CAST (IdFormaNotificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPostagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPostagem, 113 ),'Nulo'))+'» '
                         + '| DataRecebInteressado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebInteressado, 113 ),'Nulo'))+'» '
                         + '| DocRecebidoPor : «' + RTRIM( ISNULL( CAST (DocRecebidoPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRecibo : «' + RTRIM( ISNULL( CAST (NumeroRecibo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ValePostal IS NULL THEN ' E_ValePostal : «Nulo» '
                                              WHEN  E_ValePostal = 0 THEN ' E_ValePostal : «Falso» '
                                              WHEN  E_ValePostal = 1 THEN ' E_ValePostal : «Verdadeiro» '
                                    END 
                         + '| CodigoCorrespondencia : «' + RTRIM( ISNULL( CAST (CodigoCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTaxa : «' + RTRIM( ISNULL( CAST (ValorTaxa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEnvio : «' + RTRIM( ISNULL( CAST (ValorEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetornoValePostal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetornoValePostal, 113 ),'Nulo'))+'» '
                         + '| Peso : «' + RTRIM( ISNULL( CAST (Peso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPesosValores : «' + RTRIM( ISNULL( CAST (IdPesosValores AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura1Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura1Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura2Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura2Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura3Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura3Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtDevolucaoCorresp : «' + RTRIM( ISNULL( CONVERT (CHAR, DtDevolucaoCorresp, 113 ),'Nulo'))+'» '
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idUsuarioPostagem : «' + RTRIM( ISNULL( CAST (idUsuarioPostagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdComplementoDocEmitido : «' + RTRIM( ISNULL( CAST (IdComplementoDocEmitido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaNotificacao : «' + RTRIM( ISNULL( CAST (IdFormaNotificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPostagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPostagem, 113 ),'Nulo'))+'» '
                         + '| DataRecebInteressado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebInteressado, 113 ),'Nulo'))+'» '
                         + '| DocRecebidoPor : «' + RTRIM( ISNULL( CAST (DocRecebidoPor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroRecibo : «' + RTRIM( ISNULL( CAST (NumeroRecibo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_ValePostal IS NULL THEN ' E_ValePostal : «Nulo» '
                                              WHEN  E_ValePostal = 0 THEN ' E_ValePostal : «Falso» '
                                              WHEN  E_ValePostal = 1 THEN ' E_ValePostal : «Verdadeiro» '
                                    END 
                         + '| CodigoCorrespondencia : «' + RTRIM( ISNULL( CAST (CodigoCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTaxa : «' + RTRIM( ISNULL( CAST (ValorTaxa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEnvio : «' + RTRIM( ISNULL( CAST (ValorEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetornoValePostal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetornoValePostal, 113 ),'Nulo'))+'» '
                         + '| Peso : «' + RTRIM( ISNULL( CAST (Peso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPesosValores : «' + RTRIM( ISNULL( CAST (IdPesosValores AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura1Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura1Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura2Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura2Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssinatura3Prof : «' + RTRIM( ISNULL( CAST (IdAssinatura3Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtDevolucaoCorresp : «' + RTRIM( ISNULL( CONVERT (CHAR, DtDevolucaoCorresp, 113 ),'Nulo'))+'» '
                         + '| Observacao : «' + RTRIM( ISNULL( CAST (Observacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idUsuarioPostagem : «' + RTRIM( ISNULL( CAST (idUsuarioPostagem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
