CREATE TABLE [dbo].[Fiscalizacoes] (
    [IdFiscalizacao]                INT          IDENTITY (1, 1) NOT NULL,
    [IdProcesso]                    INT          NULL,
    [IdFiscal]                      INT          NULL,
    [IdFiscalPessoa]                INT          NULL,
    [NumeroFiscalizacao]            VARCHAR (50) NOT NULL,
    [Data1Fisc]                     DATETIME     NULL,
    [Data2Fisc]                     DATETIME     NULL,
    [Data3Fisc]                     DATETIME     NULL,
    [Data4Fisc]                     DATETIME     NULL,
    [Num1Fisc]                      INT          NULL,
    [Num2Fisc]                      INT          NULL,
    [Num3Fisc]                      INT          NULL,
    [Num4Fisc]                      INT          NULL,
    [Num5Fisc]                      INT          NULL,
    [IdTabela1Fisc]                 INT          NULL,
    [IdTabela2Fisc]                 INT          NULL,
    [IdTabela3Fisc]                 INT          NULL,
    [IdTabela4Fisc]                 INT          NULL,
    [IdTabela5Fisc]                 INT          NULL,
    [Alfa1Fisc]                     VARCHAR (40) NULL,
    [Alfa2Fisc]                     VARCHAR (40) NULL,
    [Alfa3Fisc]                     VARCHAR (40) NULL,
    [Alfa4Fisc]                     VARCHAR (40) NULL,
    [Alfa5Fisc]                     VARCHAR (40) NULL,
    [Valor1Fisc]                    MONEY        NULL,
    [Valor2Fisc]                    MONEY        NULL,
    [Valor3Fisc]                    MONEY        NULL,
    [IdCidade1]                     INT          NULL,
    [IdCidade2]                     INT          NULL,
    [IdUF1]                         INT          NULL,
    [IdUF2]                         INT          NULL,
    [Observacao]                    TEXT         NULL,
    [IdPessoa_Denunciante]          INT          NULL,
    [IdProfissional_Denunciante]    INT          NULL,
    [IdPessoaJuridica_Denunciante]  INT          NULL,
    [IdTabela1Prof]                 INT          NULL,
    [IdTabela1PJ]                   INT          NULL,
    [IdTabela1Pessoa]               INT          NULL,
    [Alfa6Fisc]                     VARCHAR (40) NULL,
    [Alfa7Fisc]                     VARCHAR (40) NULL,
    [Alfa8Fisc]                     VARCHAR (40) NULL,
    [Alfa9Fisc]                     VARCHAR (40) NULL,
    [Alfa10Fisc]                    VARCHAR (40) NULL,
    [Chk1Fisc]                      BIT          NULL,
    [Chk2Fisc]                      BIT          NULL,
    [Chk3Fisc]                      BIT          NULL,
    [Chk4Fisc]                      BIT          NULL,
    [Chk5Fisc]                      BIT          NULL,
    [Chk6Fisc]                      BIT          NULL,
    [IdFiscalizacaoPrincipal]       INT          NULL,
    [Visita]                        VARCHAR (25) NULL,
    [IdCidade]                      INT          NULL,
    [DataVisita]                    DATETIME     NULL,
    [IdCargo]                       INT          NULL,
    [Atendente]                     VARCHAR (25) NULL,
    [Chegada]                       VARCHAR (25) NULL,
    [TpRecepcao]                    VARCHAR (25) NULL,
    [TempoTotal]                    VARCHAR (25) NULL,
    [TempoEfetivo]                  VARCHAR (25) NULL,
    [Encerramento]                  VARCHAR (25) NULL,
    [Atendimento]                   VARCHAR (25) NULL,
    [Roteiro]                       INT          NULL,
    [IdTipoRecepcaoFiscalizacao]    INT          NULL,
    [DataUltimaAtualizacao]         DATETIME     NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [DataCriacaoFiscalizacao]       DATETIME     NULL,
    CONSTRAINT [PK_Fiscalizacao] PRIMARY KEY CLUSTERED ([IdFiscalizacao] ASC),
    CONSTRAINT [FK_Fiscalizacao_Fiscalizacao] FOREIGN KEY ([IdFiscalizacaoPrincipal]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Fiscalizacoes_Cargos] FOREIGN KEY ([IdCargo]) REFERENCES [dbo].[Cargos] ([IdCargo]),
    CONSTRAINT [FK_Fiscalizacoes_Cidades] FOREIGN KEY ([IdCidade1]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_Fiscalizacoes_Cidades1] FOREIGN KEY ([IdCidade2]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_Fiscalizacoes_Cidades2] FOREIGN KEY ([IdCidade]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_Fiscalizacoes_Estados] FOREIGN KEY ([IdUF1]) REFERENCES [dbo].[Estados] ([IdEstado]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Fiscalizacoes_Estados1] FOREIGN KEY ([IdUF2]) REFERENCES [dbo].[Estados] ([IdEstado]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Fiscalizacoes_FiscalizacoesTabela1] FOREIGN KEY ([IdTabela1Fisc]) REFERENCES [dbo].[FiscalizacoesTabela1] ([IdTabela1Fisc]),
    CONSTRAINT [FK_Fiscalizacoes_FiscalizacoesTabela2] FOREIGN KEY ([IdTabela2Fisc]) REFERENCES [dbo].[FiscalizacoesTabela2] ([IdTabela2Fisc]),
    CONSTRAINT [FK_Fiscalizacoes_FiscalizacoesTabela3] FOREIGN KEY ([IdTabela3Fisc]) REFERENCES [dbo].[FiscalizacoesTabela3] ([IdTabela3Fisc]),
    CONSTRAINT [FK_Fiscalizacoes_FiscalizacoesTabela4] FOREIGN KEY ([IdTabela4Fisc]) REFERENCES [dbo].[FiscalizacoesTabela4] ([IdTabela4Fisc]),
    CONSTRAINT [FK_Fiscalizacoes_FiscalizacoesTabela5] FOREIGN KEY ([IdTabela5Fisc]) REFERENCES [dbo].[FiscalizacoesTabela5] ([IdTabela5Fisc]),
    CONSTRAINT [FK_Fiscalizacoes_Pessoas] FOREIGN KEY ([IdTabela1Pessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_Fiscalizacoes_Pessoas_Denunciante] FOREIGN KEY ([IdPessoa_Denunciante]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_Fiscalizacoes_PessoasJuridicas] FOREIGN KEY ([IdTabela1PJ]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_Fiscalizacoes_PessoasJuridicas_Denunciante] FOREIGN KEY ([IdPessoaJuridica_Denunciante]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_Fiscalizacoes_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Fiscalizacoes_Prof] FOREIGN KEY ([IdTabela1Prof]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_Fiscalizacoes_Profissionais_Denunciante] FOREIGN KEY ([IdProfissional_Denunciante]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_Fiscalizacoes_Profissionais1] FOREIGN KEY ([IdFiscal]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Fiscalizacoes] NOCHECK CONSTRAINT [FK_Fiscalizacoes_Processos];


GO
/*Ocorr. 57841 - Seila*/

CREATE TRIGGER [dbo].[Trg_Fiscalizacoes_Usuario] ON [dbo].[Fiscalizacoes] 
	FOR INSERT,
		UPDATE
AS
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
	BEGIN		
		UPDATE
			F	
		SET
			F.DataUltimaAtualizacao = GETDATE(),
			F.UsuarioUltimaAtualizacao = HOST_NAME(),
			F.DepartamentoUltimaAtualizacao = ( SELECT
													NomeDepto 
												FROM 
													Departamentos
													JOIN Usuarios ON Departamentos.IdDepto = Usuarios.IdDepartamento
												WHERE
													NomeUsuario = HOST_NAME())
		FROM
			INSERTED I
			JOIN Fiscalizacoes F ON F.IdFiscalizacao = I.IdFiscalizacao
	END
SET NOCOUNT OFF

GO
CREATE TRIGGER [TrgLog_Fiscalizacoes] ON [Implanta_CRPAM].[dbo].[Fiscalizacoes] 
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
SET @TableName = 'Fiscalizacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscal : «' + RTRIM( ISNULL( CAST (IdFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalPessoa : «' + RTRIM( ISNULL( CAST (IdFiscalPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFiscalizacao : «' + RTRIM( ISNULL( CAST (NumeroFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data1Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Fisc, 113 ),'Nulo'))+'» '
                         + '| Data2Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Fisc, 113 ),'Nulo'))+'» '
                         + '| Data3Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data3Fisc, 113 ),'Nulo'))+'» '
                         + '| Data4Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data4Fisc, 113 ),'Nulo'))+'» '
                         + '| Num1Fisc : «' + RTRIM( ISNULL( CAST (Num1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num2Fisc : «' + RTRIM( ISNULL( CAST (Num2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num3Fisc : «' + RTRIM( ISNULL( CAST (Num3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num4Fisc : «' + RTRIM( ISNULL( CAST (Num4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num5Fisc : «' + RTRIM( ISNULL( CAST (Num5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Fisc : «' + RTRIM( ISNULL( CAST (IdTabela1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela2Fisc : «' + RTRIM( ISNULL( CAST (IdTabela2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela3Fisc : «' + RTRIM( ISNULL( CAST (IdTabela3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela4Fisc : «' + RTRIM( ISNULL( CAST (IdTabela4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela5Fisc : «' + RTRIM( ISNULL( CAST (IdTabela5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa1Fisc : «' + RTRIM( ISNULL( CAST (Alfa1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa2Fisc : «' + RTRIM( ISNULL( CAST (Alfa2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa3Fisc : «' + RTRIM( ISNULL( CAST (Alfa3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa4Fisc : «' + RTRIM( ISNULL( CAST (Alfa4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa5Fisc : «' + RTRIM( ISNULL( CAST (Alfa5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor1Fisc : «' + RTRIM( ISNULL( CAST (Valor1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor2Fisc : «' + RTRIM( ISNULL( CAST (Valor2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor3Fisc : «' + RTRIM( ISNULL( CAST (Valor3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade1 : «' + RTRIM( ISNULL( CAST (IdCidade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade2 : «' + RTRIM( ISNULL( CAST (IdCidade2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUF1 : «' + RTRIM( ISNULL( CAST (IdUF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUF2 : «' + RTRIM( ISNULL( CAST (IdUF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa_Denunciante : «' + RTRIM( ISNULL( CAST (IdPessoa_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional_Denunciante : «' + RTRIM( ISNULL( CAST (IdProfissional_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica_Denunciante : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Prof : «' + RTRIM( ISNULL( CAST (IdTabela1Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1PJ : «' + RTRIM( ISNULL( CAST (IdTabela1PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Pessoa : «' + RTRIM( ISNULL( CAST (IdTabela1Pessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa6Fisc : «' + RTRIM( ISNULL( CAST (Alfa6Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa7Fisc : «' + RTRIM( ISNULL( CAST (Alfa7Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa8Fisc : «' + RTRIM( ISNULL( CAST (Alfa8Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa9Fisc : «' + RTRIM( ISNULL( CAST (Alfa9Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa10Fisc : «' + RTRIM( ISNULL( CAST (Alfa10Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Chk1Fisc IS NULL THEN ' Chk1Fisc : «Nulo» '
                                              WHEN  Chk1Fisc = 0 THEN ' Chk1Fisc : «Falso» '
                                              WHEN  Chk1Fisc = 1 THEN ' Chk1Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk2Fisc IS NULL THEN ' Chk2Fisc : «Nulo» '
                                              WHEN  Chk2Fisc = 0 THEN ' Chk2Fisc : «Falso» '
                                              WHEN  Chk2Fisc = 1 THEN ' Chk2Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk3Fisc IS NULL THEN ' Chk3Fisc : «Nulo» '
                                              WHEN  Chk3Fisc = 0 THEN ' Chk3Fisc : «Falso» '
                                              WHEN  Chk3Fisc = 1 THEN ' Chk3Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk4Fisc IS NULL THEN ' Chk4Fisc : «Nulo» '
                                              WHEN  Chk4Fisc = 0 THEN ' Chk4Fisc : «Falso» '
                                              WHEN  Chk4Fisc = 1 THEN ' Chk4Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk5Fisc IS NULL THEN ' Chk5Fisc : «Nulo» '
                                              WHEN  Chk5Fisc = 0 THEN ' Chk5Fisc : «Falso» '
                                              WHEN  Chk5Fisc = 1 THEN ' Chk5Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk6Fisc IS NULL THEN ' Chk6Fisc : «Nulo» '
                                              WHEN  Chk6Fisc = 0 THEN ' Chk6Fisc : «Falso» '
                                              WHEN  Chk6Fisc = 1 THEN ' Chk6Fisc : «Verdadeiro» '
                                    END 
                         + '| IdFiscalizacaoPrincipal : «' + RTRIM( ISNULL( CAST (IdFiscalizacaoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Visita : «' + RTRIM( ISNULL( CAST (Visita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVisita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVisita, 113 ),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Atendente : «' + RTRIM( ISNULL( CAST (Atendente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chegada : «' + RTRIM( ISNULL( CAST (Chegada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpRecepcao : «' + RTRIM( ISNULL( CAST (TpRecepcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoTotal : «' + RTRIM( ISNULL( CAST (TempoTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoEfetivo : «' + RTRIM( ISNULL( CAST (TempoEfetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Encerramento : «' + RTRIM( ISNULL( CAST (Encerramento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Atendimento : «' + RTRIM( ISNULL( CAST (Atendimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Roteiro : «' + RTRIM( ISNULL( CAST (Roteiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoRecepcaoFiscalizacao : «' + RTRIM( ISNULL( CAST (IdTipoRecepcaoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacaoFiscalizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacaoFiscalizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscal : «' + RTRIM( ISNULL( CAST (IdFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalPessoa : «' + RTRIM( ISNULL( CAST (IdFiscalPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFiscalizacao : «' + RTRIM( ISNULL( CAST (NumeroFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data1Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Fisc, 113 ),'Nulo'))+'» '
                         + '| Data2Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Fisc, 113 ),'Nulo'))+'» '
                         + '| Data3Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data3Fisc, 113 ),'Nulo'))+'» '
                         + '| Data4Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data4Fisc, 113 ),'Nulo'))+'» '
                         + '| Num1Fisc : «' + RTRIM( ISNULL( CAST (Num1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num2Fisc : «' + RTRIM( ISNULL( CAST (Num2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num3Fisc : «' + RTRIM( ISNULL( CAST (Num3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num4Fisc : «' + RTRIM( ISNULL( CAST (Num4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num5Fisc : «' + RTRIM( ISNULL( CAST (Num5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Fisc : «' + RTRIM( ISNULL( CAST (IdTabela1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela2Fisc : «' + RTRIM( ISNULL( CAST (IdTabela2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela3Fisc : «' + RTRIM( ISNULL( CAST (IdTabela3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela4Fisc : «' + RTRIM( ISNULL( CAST (IdTabela4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela5Fisc : «' + RTRIM( ISNULL( CAST (IdTabela5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa1Fisc : «' + RTRIM( ISNULL( CAST (Alfa1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa2Fisc : «' + RTRIM( ISNULL( CAST (Alfa2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa3Fisc : «' + RTRIM( ISNULL( CAST (Alfa3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa4Fisc : «' + RTRIM( ISNULL( CAST (Alfa4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa5Fisc : «' + RTRIM( ISNULL( CAST (Alfa5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor1Fisc : «' + RTRIM( ISNULL( CAST (Valor1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor2Fisc : «' + RTRIM( ISNULL( CAST (Valor2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor3Fisc : «' + RTRIM( ISNULL( CAST (Valor3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade1 : «' + RTRIM( ISNULL( CAST (IdCidade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade2 : «' + RTRIM( ISNULL( CAST (IdCidade2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUF1 : «' + RTRIM( ISNULL( CAST (IdUF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUF2 : «' + RTRIM( ISNULL( CAST (IdUF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa_Denunciante : «' + RTRIM( ISNULL( CAST (IdPessoa_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional_Denunciante : «' + RTRIM( ISNULL( CAST (IdProfissional_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica_Denunciante : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Prof : «' + RTRIM( ISNULL( CAST (IdTabela1Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1PJ : «' + RTRIM( ISNULL( CAST (IdTabela1PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Pessoa : «' + RTRIM( ISNULL( CAST (IdTabela1Pessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa6Fisc : «' + RTRIM( ISNULL( CAST (Alfa6Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa7Fisc : «' + RTRIM( ISNULL( CAST (Alfa7Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa8Fisc : «' + RTRIM( ISNULL( CAST (Alfa8Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa9Fisc : «' + RTRIM( ISNULL( CAST (Alfa9Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa10Fisc : «' + RTRIM( ISNULL( CAST (Alfa10Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Chk1Fisc IS NULL THEN ' Chk1Fisc : «Nulo» '
                                              WHEN  Chk1Fisc = 0 THEN ' Chk1Fisc : «Falso» '
                                              WHEN  Chk1Fisc = 1 THEN ' Chk1Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk2Fisc IS NULL THEN ' Chk2Fisc : «Nulo» '
                                              WHEN  Chk2Fisc = 0 THEN ' Chk2Fisc : «Falso» '
                                              WHEN  Chk2Fisc = 1 THEN ' Chk2Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk3Fisc IS NULL THEN ' Chk3Fisc : «Nulo» '
                                              WHEN  Chk3Fisc = 0 THEN ' Chk3Fisc : «Falso» '
                                              WHEN  Chk3Fisc = 1 THEN ' Chk3Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk4Fisc IS NULL THEN ' Chk4Fisc : «Nulo» '
                                              WHEN  Chk4Fisc = 0 THEN ' Chk4Fisc : «Falso» '
                                              WHEN  Chk4Fisc = 1 THEN ' Chk4Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk5Fisc IS NULL THEN ' Chk5Fisc : «Nulo» '
                                              WHEN  Chk5Fisc = 0 THEN ' Chk5Fisc : «Falso» '
                                              WHEN  Chk5Fisc = 1 THEN ' Chk5Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk6Fisc IS NULL THEN ' Chk6Fisc : «Nulo» '
                                              WHEN  Chk6Fisc = 0 THEN ' Chk6Fisc : «Falso» '
                                              WHEN  Chk6Fisc = 1 THEN ' Chk6Fisc : «Verdadeiro» '
                                    END 
                         + '| IdFiscalizacaoPrincipal : «' + RTRIM( ISNULL( CAST (IdFiscalizacaoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Visita : «' + RTRIM( ISNULL( CAST (Visita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVisita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVisita, 113 ),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Atendente : «' + RTRIM( ISNULL( CAST (Atendente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chegada : «' + RTRIM( ISNULL( CAST (Chegada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpRecepcao : «' + RTRIM( ISNULL( CAST (TpRecepcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoTotal : «' + RTRIM( ISNULL( CAST (TempoTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoEfetivo : «' + RTRIM( ISNULL( CAST (TempoEfetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Encerramento : «' + RTRIM( ISNULL( CAST (Encerramento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Atendimento : «' + RTRIM( ISNULL( CAST (Atendimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Roteiro : «' + RTRIM( ISNULL( CAST (Roteiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoRecepcaoFiscalizacao : «' + RTRIM( ISNULL( CAST (IdTipoRecepcaoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacaoFiscalizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacaoFiscalizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscal : «' + RTRIM( ISNULL( CAST (IdFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalPessoa : «' + RTRIM( ISNULL( CAST (IdFiscalPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFiscalizacao : «' + RTRIM( ISNULL( CAST (NumeroFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data1Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Fisc, 113 ),'Nulo'))+'» '
                         + '| Data2Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Fisc, 113 ),'Nulo'))+'» '
                         + '| Data3Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data3Fisc, 113 ),'Nulo'))+'» '
                         + '| Data4Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data4Fisc, 113 ),'Nulo'))+'» '
                         + '| Num1Fisc : «' + RTRIM( ISNULL( CAST (Num1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num2Fisc : «' + RTRIM( ISNULL( CAST (Num2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num3Fisc : «' + RTRIM( ISNULL( CAST (Num3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num4Fisc : «' + RTRIM( ISNULL( CAST (Num4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num5Fisc : «' + RTRIM( ISNULL( CAST (Num5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Fisc : «' + RTRIM( ISNULL( CAST (IdTabela1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela2Fisc : «' + RTRIM( ISNULL( CAST (IdTabela2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela3Fisc : «' + RTRIM( ISNULL( CAST (IdTabela3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela4Fisc : «' + RTRIM( ISNULL( CAST (IdTabela4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela5Fisc : «' + RTRIM( ISNULL( CAST (IdTabela5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa1Fisc : «' + RTRIM( ISNULL( CAST (Alfa1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa2Fisc : «' + RTRIM( ISNULL( CAST (Alfa2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa3Fisc : «' + RTRIM( ISNULL( CAST (Alfa3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa4Fisc : «' + RTRIM( ISNULL( CAST (Alfa4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa5Fisc : «' + RTRIM( ISNULL( CAST (Alfa5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor1Fisc : «' + RTRIM( ISNULL( CAST (Valor1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor2Fisc : «' + RTRIM( ISNULL( CAST (Valor2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor3Fisc : «' + RTRIM( ISNULL( CAST (Valor3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade1 : «' + RTRIM( ISNULL( CAST (IdCidade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade2 : «' + RTRIM( ISNULL( CAST (IdCidade2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUF1 : «' + RTRIM( ISNULL( CAST (IdUF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUF2 : «' + RTRIM( ISNULL( CAST (IdUF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa_Denunciante : «' + RTRIM( ISNULL( CAST (IdPessoa_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional_Denunciante : «' + RTRIM( ISNULL( CAST (IdProfissional_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica_Denunciante : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Prof : «' + RTRIM( ISNULL( CAST (IdTabela1Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1PJ : «' + RTRIM( ISNULL( CAST (IdTabela1PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Pessoa : «' + RTRIM( ISNULL( CAST (IdTabela1Pessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa6Fisc : «' + RTRIM( ISNULL( CAST (Alfa6Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa7Fisc : «' + RTRIM( ISNULL( CAST (Alfa7Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa8Fisc : «' + RTRIM( ISNULL( CAST (Alfa8Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa9Fisc : «' + RTRIM( ISNULL( CAST (Alfa9Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa10Fisc : «' + RTRIM( ISNULL( CAST (Alfa10Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Chk1Fisc IS NULL THEN ' Chk1Fisc : «Nulo» '
                                              WHEN  Chk1Fisc = 0 THEN ' Chk1Fisc : «Falso» '
                                              WHEN  Chk1Fisc = 1 THEN ' Chk1Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk2Fisc IS NULL THEN ' Chk2Fisc : «Nulo» '
                                              WHEN  Chk2Fisc = 0 THEN ' Chk2Fisc : «Falso» '
                                              WHEN  Chk2Fisc = 1 THEN ' Chk2Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk3Fisc IS NULL THEN ' Chk3Fisc : «Nulo» '
                                              WHEN  Chk3Fisc = 0 THEN ' Chk3Fisc : «Falso» '
                                              WHEN  Chk3Fisc = 1 THEN ' Chk3Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk4Fisc IS NULL THEN ' Chk4Fisc : «Nulo» '
                                              WHEN  Chk4Fisc = 0 THEN ' Chk4Fisc : «Falso» '
                                              WHEN  Chk4Fisc = 1 THEN ' Chk4Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk5Fisc IS NULL THEN ' Chk5Fisc : «Nulo» '
                                              WHEN  Chk5Fisc = 0 THEN ' Chk5Fisc : «Falso» '
                                              WHEN  Chk5Fisc = 1 THEN ' Chk5Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk6Fisc IS NULL THEN ' Chk6Fisc : «Nulo» '
                                              WHEN  Chk6Fisc = 0 THEN ' Chk6Fisc : «Falso» '
                                              WHEN  Chk6Fisc = 1 THEN ' Chk6Fisc : «Verdadeiro» '
                                    END 
                         + '| IdFiscalizacaoPrincipal : «' + RTRIM( ISNULL( CAST (IdFiscalizacaoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Visita : «' + RTRIM( ISNULL( CAST (Visita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVisita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVisita, 113 ),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Atendente : «' + RTRIM( ISNULL( CAST (Atendente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chegada : «' + RTRIM( ISNULL( CAST (Chegada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpRecepcao : «' + RTRIM( ISNULL( CAST (TpRecepcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoTotal : «' + RTRIM( ISNULL( CAST (TempoTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoEfetivo : «' + RTRIM( ISNULL( CAST (TempoEfetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Encerramento : «' + RTRIM( ISNULL( CAST (Encerramento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Atendimento : «' + RTRIM( ISNULL( CAST (Atendimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Roteiro : «' + RTRIM( ISNULL( CAST (Roteiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoRecepcaoFiscalizacao : «' + RTRIM( ISNULL( CAST (IdTipoRecepcaoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacaoFiscalizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacaoFiscalizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFiscalizacao : «' + RTRIM( ISNULL( CAST (IdFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscal : «' + RTRIM( ISNULL( CAST (IdFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFiscalPessoa : «' + RTRIM( ISNULL( CAST (IdFiscalPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroFiscalizacao : «' + RTRIM( ISNULL( CAST (NumeroFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data1Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data1Fisc, 113 ),'Nulo'))+'» '
                         + '| Data2Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data2Fisc, 113 ),'Nulo'))+'» '
                         + '| Data3Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data3Fisc, 113 ),'Nulo'))+'» '
                         + '| Data4Fisc : «' + RTRIM( ISNULL( CONVERT (CHAR, Data4Fisc, 113 ),'Nulo'))+'» '
                         + '| Num1Fisc : «' + RTRIM( ISNULL( CAST (Num1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num2Fisc : «' + RTRIM( ISNULL( CAST (Num2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num3Fisc : «' + RTRIM( ISNULL( CAST (Num3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num4Fisc : «' + RTRIM( ISNULL( CAST (Num4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Num5Fisc : «' + RTRIM( ISNULL( CAST (Num5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Fisc : «' + RTRIM( ISNULL( CAST (IdTabela1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela2Fisc : «' + RTRIM( ISNULL( CAST (IdTabela2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela3Fisc : «' + RTRIM( ISNULL( CAST (IdTabela3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela4Fisc : «' + RTRIM( ISNULL( CAST (IdTabela4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela5Fisc : «' + RTRIM( ISNULL( CAST (IdTabela5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa1Fisc : «' + RTRIM( ISNULL( CAST (Alfa1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa2Fisc : «' + RTRIM( ISNULL( CAST (Alfa2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa3Fisc : «' + RTRIM( ISNULL( CAST (Alfa3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa4Fisc : «' + RTRIM( ISNULL( CAST (Alfa4Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa5Fisc : «' + RTRIM( ISNULL( CAST (Alfa5Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor1Fisc : «' + RTRIM( ISNULL( CAST (Valor1Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor2Fisc : «' + RTRIM( ISNULL( CAST (Valor2Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor3Fisc : «' + RTRIM( ISNULL( CAST (Valor3Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade1 : «' + RTRIM( ISNULL( CAST (IdCidade1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade2 : «' + RTRIM( ISNULL( CAST (IdCidade2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUF1 : «' + RTRIM( ISNULL( CAST (IdUF1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUF2 : «' + RTRIM( ISNULL( CAST (IdUF2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa_Denunciante : «' + RTRIM( ISNULL( CAST (IdPessoa_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional_Denunciante : «' + RTRIM( ISNULL( CAST (IdProfissional_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica_Denunciante : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica_Denunciante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Prof : «' + RTRIM( ISNULL( CAST (IdTabela1Prof AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1PJ : «' + RTRIM( ISNULL( CAST (IdTabela1PJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTabela1Pessoa : «' + RTRIM( ISNULL( CAST (IdTabela1Pessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa6Fisc : «' + RTRIM( ISNULL( CAST (Alfa6Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa7Fisc : «' + RTRIM( ISNULL( CAST (Alfa7Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa8Fisc : «' + RTRIM( ISNULL( CAST (Alfa8Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa9Fisc : «' + RTRIM( ISNULL( CAST (Alfa9Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Alfa10Fisc : «' + RTRIM( ISNULL( CAST (Alfa10Fisc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Chk1Fisc IS NULL THEN ' Chk1Fisc : «Nulo» '
                                              WHEN  Chk1Fisc = 0 THEN ' Chk1Fisc : «Falso» '
                                              WHEN  Chk1Fisc = 1 THEN ' Chk1Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk2Fisc IS NULL THEN ' Chk2Fisc : «Nulo» '
                                              WHEN  Chk2Fisc = 0 THEN ' Chk2Fisc : «Falso» '
                                              WHEN  Chk2Fisc = 1 THEN ' Chk2Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk3Fisc IS NULL THEN ' Chk3Fisc : «Nulo» '
                                              WHEN  Chk3Fisc = 0 THEN ' Chk3Fisc : «Falso» '
                                              WHEN  Chk3Fisc = 1 THEN ' Chk3Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk4Fisc IS NULL THEN ' Chk4Fisc : «Nulo» '
                                              WHEN  Chk4Fisc = 0 THEN ' Chk4Fisc : «Falso» '
                                              WHEN  Chk4Fisc = 1 THEN ' Chk4Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk5Fisc IS NULL THEN ' Chk5Fisc : «Nulo» '
                                              WHEN  Chk5Fisc = 0 THEN ' Chk5Fisc : «Falso» '
                                              WHEN  Chk5Fisc = 1 THEN ' Chk5Fisc : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Chk6Fisc IS NULL THEN ' Chk6Fisc : «Nulo» '
                                              WHEN  Chk6Fisc = 0 THEN ' Chk6Fisc : «Falso» '
                                              WHEN  Chk6Fisc = 1 THEN ' Chk6Fisc : «Verdadeiro» '
                                    END 
                         + '| IdFiscalizacaoPrincipal : «' + RTRIM( ISNULL( CAST (IdFiscalizacaoPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Visita : «' + RTRIM( ISNULL( CAST (Visita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCidade : «' + RTRIM( ISNULL( CAST (IdCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVisita : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVisita, 113 ),'Nulo'))+'» '
                         + '| IdCargo : «' + RTRIM( ISNULL( CAST (IdCargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Atendente : «' + RTRIM( ISNULL( CAST (Atendente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chegada : «' + RTRIM( ISNULL( CAST (Chegada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TpRecepcao : «' + RTRIM( ISNULL( CAST (TpRecepcao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoTotal : «' + RTRIM( ISNULL( CAST (TempoTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoEfetivo : «' + RTRIM( ISNULL( CAST (TempoEfetivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Encerramento : «' + RTRIM( ISNULL( CAST (Encerramento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Atendimento : «' + RTRIM( ISNULL( CAST (Atendimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Roteiro : «' + RTRIM( ISNULL( CAST (Roteiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoRecepcaoFiscalizacao : «' + RTRIM( ISNULL( CAST (IdTipoRecepcaoFiscalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacaoFiscalizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacaoFiscalizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
