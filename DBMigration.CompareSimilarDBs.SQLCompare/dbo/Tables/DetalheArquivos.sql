CREATE TABLE [dbo].[DetalheArquivos] (
    [IdDetalhe]         INT          IDENTITY (1, 1) NOT NULL,
    [IdDetalheOriginal] INT          NULL,
    [IdArquivo]         INT          NULL,
    [SeuNumero]         VARCHAR (20) NULL,
    [Retorno]           BIT          NULL,
    [Cancelado]         BIT          NULL,
    [Ocorrencias]       VARCHAR (10) NULL,
    [DataPagamento]     DATETIME     NULL,
    [Lote]              INT          NULL,
    [Banco]             VARCHAR (3)  NULL,
    [Agencia]           VARCHAR (6)  NULL,
    [Conta]             VARCHAR (13) NULL,
    [Favorecido]        VARCHAR (30) NULL,
    [Valor]             MONEY        NULL,
    [CPFCNPJPASEP]      VARCHAR (15) NULL,
    [FormaLancamento]   INT          NULL,
    [CodGrupo]          VARCHAR (20) NULL,
    [IdFormaPagamento]  INT          NULL,
    CONSTRAINT [PK_DetalheArquivos] PRIMARY KEY CLUSTERED ([IdDetalhe] ASC),
    CONSTRAINT [FK_DetalheArquivos_ControleArquivos] FOREIGN KEY ([IdArquivo]) REFERENCES [dbo].[ControleArquivos] ([IdArquivo]),
    CONSTRAINT [FK_DetalheArquivos_DetalheArquivos] FOREIGN KEY ([IdDetalheOriginal]) REFERENCES [dbo].[DetalheArquivos] ([IdDetalhe])
);


GO
CREATE TRIGGER [TrgLog_DetalheArquivos] ON [Implanta_CRPAM].[dbo].[DetalheArquivos] 
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
SET @TableName = 'DetalheArquivos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalhe : «' + RTRIM( ISNULL( CAST (IdDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheOriginal : «' + RTRIM( ISNULL( CAST (IdDetalheOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Retorno IS NULL THEN ' Retorno : «Nulo» '
                                              WHEN  Retorno = 0 THEN ' Retorno : «Falso» '
                                              WHEN  Retorno = 1 THEN ' Retorno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Cancelado IS NULL THEN ' Cancelado : «Nulo» '
                                              WHEN  Cancelado = 0 THEN ' Cancelado : «Falso» '
                                              WHEN  Cancelado = 1 THEN ' Cancelado : «Verdadeiro» '
                                    END 
                         + '| Ocorrencias : «' + RTRIM( ISNULL( CAST (Ocorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| Lote : «' + RTRIM( ISNULL( CAST (Lote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Favorecido : «' + RTRIM( ISNULL( CAST (Favorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJPASEP : «' + RTRIM( ISNULL( CAST (CPFCNPJPASEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaLancamento : «' + RTRIM( ISNULL( CAST (FormaLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodGrupo : «' + RTRIM( ISNULL( CAST (CodGrupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalhe : «' + RTRIM( ISNULL( CAST (IdDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheOriginal : «' + RTRIM( ISNULL( CAST (IdDetalheOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Retorno IS NULL THEN ' Retorno : «Nulo» '
                                              WHEN  Retorno = 0 THEN ' Retorno : «Falso» '
                                              WHEN  Retorno = 1 THEN ' Retorno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Cancelado IS NULL THEN ' Cancelado : «Nulo» '
                                              WHEN  Cancelado = 0 THEN ' Cancelado : «Falso» '
                                              WHEN  Cancelado = 1 THEN ' Cancelado : «Verdadeiro» '
                                    END 
                         + '| Ocorrencias : «' + RTRIM( ISNULL( CAST (Ocorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| Lote : «' + RTRIM( ISNULL( CAST (Lote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Favorecido : «' + RTRIM( ISNULL( CAST (Favorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJPASEP : «' + RTRIM( ISNULL( CAST (CPFCNPJPASEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaLancamento : «' + RTRIM( ISNULL( CAST (FormaLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodGrupo : «' + RTRIM( ISNULL( CAST (CodGrupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDetalhe : «' + RTRIM( ISNULL( CAST (IdDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheOriginal : «' + RTRIM( ISNULL( CAST (IdDetalheOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Retorno IS NULL THEN ' Retorno : «Nulo» '
                                              WHEN  Retorno = 0 THEN ' Retorno : «Falso» '
                                              WHEN  Retorno = 1 THEN ' Retorno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Cancelado IS NULL THEN ' Cancelado : «Nulo» '
                                              WHEN  Cancelado = 0 THEN ' Cancelado : «Falso» '
                                              WHEN  Cancelado = 1 THEN ' Cancelado : «Verdadeiro» '
                                    END 
                         + '| Ocorrencias : «' + RTRIM( ISNULL( CAST (Ocorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| Lote : «' + RTRIM( ISNULL( CAST (Lote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Favorecido : «' + RTRIM( ISNULL( CAST (Favorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJPASEP : «' + RTRIM( ISNULL( CAST (CPFCNPJPASEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaLancamento : «' + RTRIM( ISNULL( CAST (FormaLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodGrupo : «' + RTRIM( ISNULL( CAST (CodGrupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalhe : «' + RTRIM( ISNULL( CAST (IdDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheOriginal : «' + RTRIM( ISNULL( CAST (IdDetalheOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SeuNumero : «' + RTRIM( ISNULL( CAST (SeuNumero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Retorno IS NULL THEN ' Retorno : «Nulo» '
                                              WHEN  Retorno = 0 THEN ' Retorno : «Falso» '
                                              WHEN  Retorno = 1 THEN ' Retorno : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Cancelado IS NULL THEN ' Cancelado : «Nulo» '
                                              WHEN  Cancelado = 0 THEN ' Cancelado : «Falso» '
                                              WHEN  Cancelado = 1 THEN ' Cancelado : «Verdadeiro» '
                                    END 
                         + '| Ocorrencias : «' + RTRIM( ISNULL( CAST (Ocorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» '
                         + '| Lote : «' + RTRIM( ISNULL( CAST (Lote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Favorecido : «' + RTRIM( ISNULL( CAST (Favorecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJPASEP : «' + RTRIM( ISNULL( CAST (CPFCNPJPASEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaLancamento : «' + RTRIM( ISNULL( CAST (FormaLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodGrupo : «' + RTRIM( ISNULL( CAST (CodGrupo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
