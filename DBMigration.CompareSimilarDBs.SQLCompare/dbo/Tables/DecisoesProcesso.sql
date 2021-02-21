CREATE TABLE [dbo].[DecisoesProcesso] (
    [IdDecisaoProcesso]             INT          IDENTITY (1, 1) NOT NULL,
    [IdOrigemDecisao]               INT          NOT NULL,
    [IdDecisao]                     INT          NOT NULL,
    [DataInicioPena]                DATETIME     NULL,
    [DataFimPena]                   DATETIME     NULL,
    [PrazoDiasPena]                 INT          NULL,
    [PrazoMesesPena]                INT          NULL,
    [ValorMultaPena]                MONEY        NULL,
    [SituacaoDecisao]               INT          NULL,
    [IdProcesso]                    INT          NOT NULL,
    [IdSecao]                       INT          NULL,
    [DataDecisao]                   DATETIME     NULL,
    [IdRepresentado]                INT          NULL,
    [TipoRepresentado_PE_PF_PJ]     CHAR (2)     NULL,
    [ProrrogaAtePrestacao]          BIT          NULL,
    [ProrrogaAteQuitacao]           BIT          NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    CONSTRAINT [PK_DecisoesProcesso_1] PRIMARY KEY CLUSTERED ([IdDecisaoProcesso] ASC),
    CONSTRAINT [FK_DecisoesProcesso_Decisoes] FOREIGN KEY ([IdDecisao]) REFERENCES [dbo].[Decisoes] ([IdDecisao]),
    CONSTRAINT [FK_DecisoesProcesso_OrigensDecisao] FOREIGN KEY ([IdOrigemDecisao]) REFERENCES [dbo].[OrigensDecisao] ([IdOrigemDecisao]),
    CONSTRAINT [FK_DecisoesProcesso_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_DecisoesProcesso_Secao] FOREIGN KEY ([IdSecao]) REFERENCES [dbo].[Secao] ([IdSecao])
);


GO
CREATE TRIGGER [TrgLog_DecisoesProcesso] ON [Implanta_CRPAM].[dbo].[DecisoesProcesso] 
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
SET @TableName = 'DecisoesProcesso'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDecisaoProcesso : «' + RTRIM( ISNULL( CAST (IdDecisaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrigemDecisao : «' + RTRIM( ISNULL( CAST (IdOrigemDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDecisao : «' + RTRIM( ISNULL( CAST (IdDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioPena : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioPena, 113 ),'Nulo'))+'» '
                         + '| DataFimPena : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimPena, 113 ),'Nulo'))+'» '
                         + '| PrazoDiasPena : «' + RTRIM( ISNULL( CAST (PrazoDiasPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoMesesPena : «' + RTRIM( ISNULL( CAST (PrazoMesesPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMultaPena : «' + RTRIM( ISNULL( CAST (ValorMultaPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoDecisao : «' + RTRIM( ISNULL( CAST (SituacaoDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSecao : «' + RTRIM( ISNULL( CAST (IdSecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDecisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDecisao, 113 ),'Nulo'))+'» '
                         + '| IdRepresentado : «' + RTRIM( ISNULL( CAST (IdRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRepresentado_PE_PF_PJ : «' + RTRIM( ISNULL( CAST (TipoRepresentado_PE_PF_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ProrrogaAtePrestacao IS NULL THEN ' ProrrogaAtePrestacao : «Nulo» '
                                              WHEN  ProrrogaAtePrestacao = 0 THEN ' ProrrogaAtePrestacao : «Falso» '
                                              WHEN  ProrrogaAtePrestacao = 1 THEN ' ProrrogaAtePrestacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ProrrogaAteQuitacao IS NULL THEN ' ProrrogaAteQuitacao : «Nulo» '
                                              WHEN  ProrrogaAteQuitacao = 0 THEN ' ProrrogaAteQuitacao : «Falso» '
                                              WHEN  ProrrogaAteQuitacao = 1 THEN ' ProrrogaAteQuitacao : «Verdadeiro» '
                                    END 
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDecisaoProcesso : «' + RTRIM( ISNULL( CAST (IdDecisaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrigemDecisao : «' + RTRIM( ISNULL( CAST (IdOrigemDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDecisao : «' + RTRIM( ISNULL( CAST (IdDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioPena : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioPena, 113 ),'Nulo'))+'» '
                         + '| DataFimPena : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimPena, 113 ),'Nulo'))+'» '
                         + '| PrazoDiasPena : «' + RTRIM( ISNULL( CAST (PrazoDiasPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoMesesPena : «' + RTRIM( ISNULL( CAST (PrazoMesesPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMultaPena : «' + RTRIM( ISNULL( CAST (ValorMultaPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoDecisao : «' + RTRIM( ISNULL( CAST (SituacaoDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSecao : «' + RTRIM( ISNULL( CAST (IdSecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDecisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDecisao, 113 ),'Nulo'))+'» '
                         + '| IdRepresentado : «' + RTRIM( ISNULL( CAST (IdRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRepresentado_PE_PF_PJ : «' + RTRIM( ISNULL( CAST (TipoRepresentado_PE_PF_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ProrrogaAtePrestacao IS NULL THEN ' ProrrogaAtePrestacao : «Nulo» '
                                              WHEN  ProrrogaAtePrestacao = 0 THEN ' ProrrogaAtePrestacao : «Falso» '
                                              WHEN  ProrrogaAtePrestacao = 1 THEN ' ProrrogaAtePrestacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ProrrogaAteQuitacao IS NULL THEN ' ProrrogaAteQuitacao : «Nulo» '
                                              WHEN  ProrrogaAteQuitacao = 0 THEN ' ProrrogaAteQuitacao : «Falso» '
                                              WHEN  ProrrogaAteQuitacao = 1 THEN ' ProrrogaAteQuitacao : «Verdadeiro» '
                                    END 
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDecisaoProcesso : «' + RTRIM( ISNULL( CAST (IdDecisaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrigemDecisao : «' + RTRIM( ISNULL( CAST (IdOrigemDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDecisao : «' + RTRIM( ISNULL( CAST (IdDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioPena : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioPena, 113 ),'Nulo'))+'» '
                         + '| DataFimPena : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimPena, 113 ),'Nulo'))+'» '
                         + '| PrazoDiasPena : «' + RTRIM( ISNULL( CAST (PrazoDiasPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoMesesPena : «' + RTRIM( ISNULL( CAST (PrazoMesesPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMultaPena : «' + RTRIM( ISNULL( CAST (ValorMultaPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoDecisao : «' + RTRIM( ISNULL( CAST (SituacaoDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSecao : «' + RTRIM( ISNULL( CAST (IdSecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDecisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDecisao, 113 ),'Nulo'))+'» '
                         + '| IdRepresentado : «' + RTRIM( ISNULL( CAST (IdRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRepresentado_PE_PF_PJ : «' + RTRIM( ISNULL( CAST (TipoRepresentado_PE_PF_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ProrrogaAtePrestacao IS NULL THEN ' ProrrogaAtePrestacao : «Nulo» '
                                              WHEN  ProrrogaAtePrestacao = 0 THEN ' ProrrogaAtePrestacao : «Falso» '
                                              WHEN  ProrrogaAtePrestacao = 1 THEN ' ProrrogaAtePrestacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ProrrogaAteQuitacao IS NULL THEN ' ProrrogaAteQuitacao : «Nulo» '
                                              WHEN  ProrrogaAteQuitacao = 0 THEN ' ProrrogaAteQuitacao : «Falso» '
                                              WHEN  ProrrogaAteQuitacao = 1 THEN ' ProrrogaAteQuitacao : «Verdadeiro» '
                                    END 
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDecisaoProcesso : «' + RTRIM( ISNULL( CAST (IdDecisaoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOrigemDecisao : «' + RTRIM( ISNULL( CAST (IdOrigemDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDecisao : «' + RTRIM( ISNULL( CAST (IdDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioPena : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioPena, 113 ),'Nulo'))+'» '
                         + '| DataFimPena : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimPena, 113 ),'Nulo'))+'» '
                         + '| PrazoDiasPena : «' + RTRIM( ISNULL( CAST (PrazoDiasPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrazoMesesPena : «' + RTRIM( ISNULL( CAST (PrazoMesesPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMultaPena : «' + RTRIM( ISNULL( CAST (ValorMultaPena AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SituacaoDecisao : «' + RTRIM( ISNULL( CAST (SituacaoDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSecao : «' + RTRIM( ISNULL( CAST (IdSecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDecisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDecisao, 113 ),'Nulo'))+'» '
                         + '| IdRepresentado : «' + RTRIM( ISNULL( CAST (IdRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRepresentado_PE_PF_PJ : «' + RTRIM( ISNULL( CAST (TipoRepresentado_PE_PF_PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ProrrogaAtePrestacao IS NULL THEN ' ProrrogaAtePrestacao : «Nulo» '
                                              WHEN  ProrrogaAtePrestacao = 0 THEN ' ProrrogaAtePrestacao : «Falso» '
                                              WHEN  ProrrogaAtePrestacao = 1 THEN ' ProrrogaAtePrestacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  ProrrogaAteQuitacao IS NULL THEN ' ProrrogaAteQuitacao : «Nulo» '
                                              WHEN  ProrrogaAteQuitacao = 0 THEN ' ProrrogaAteQuitacao : «Falso» '
                                              WHEN  ProrrogaAteQuitacao = 1 THEN ' ProrrogaAteQuitacao : «Verdadeiro» '
                                    END 
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
