CREATE TABLE [dbo].[ArquivosRemessa] (
    [IdArquivoRemessa]  INT          IDENTITY (1, 1) NOT NULL,
    [Nome]              VARCHAR (20) NOT NULL,
    [DataGeracao]       DATETIME     CONSTRAINT [DF_ArquivosRemessa_DataGeracao] DEFAULT (getdate()) NOT NULL,
    [IdBancoSiscafw]    INT          NOT NULL,
    [UsuarioGeracao]    VARCHAR (30) NULL,
    [Departamento]      VARCHAR (60) NULL,
    [RegistraLog]       BIT          CONSTRAINT [DF_ArquivosRemessa_RegistraLog] DEFAULT ((1)) NOT NULL,
    [QtdeRegistros]     INT          NOT NULL,
    [ValorTotal]        MONEY        NOT NULL,
    [SequencialRemessa] INT          NOT NULL,
    [Estornado]         BIT          CONSTRAINT [DF__ArquivosR__Estor__0377D017] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ArquivosRemessa] PRIMARY KEY CLUSTERED ([IdArquivoRemessa] ASC),
    CONSTRAINT [FK_ArquivosRemessa_BancosSiscafw] FOREIGN KEY ([IdBancoSiscafw]) REFERENCES [dbo].[BancosSiscafw] ([IdBancoSiscafw])
);


GO
create trigger [dbo].[Trg_ArquivosRemessa_Usuario] on [dbo].[ArquivosRemessa] 
for insert, update 
   as
   DECLARE @IdArquivoRemessa int, @Depto    varchar(60)
   declare @RegistraLogI integer
   declare @RegistraLogD integer
   select @IdArquivoRemessa = IdArquivoRemessa, @RegistraLogI = RegistraLog from inserted
   select @RegistraLogD = RegistraLog from deleted
   
   if (@IdArquivoRemessa > 0) and (@RegistraLogI = 1) 
	begin
		select @Depto = NomeDepto 
		from Departamentos 
		inner join Usuarios on	Departamentos.IdDepto = Usuarios.IdDepartamento 
		where NomeUsuario = host_name()
		update ArquivosRemessa 	
		set UsuarioGeracao = host_name(), Departamento = @Depto 
		where IdArquivoRemessa = @IdArquivoRemessa
    end






GO
CREATE TRIGGER [TrgLog_ArquivosRemessa] ON [Implanta_CRPAM].[dbo].[ArquivosRemessa] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
DECLARE 	@RegistraLogI	BIT 
DECLARE 	@RegistraLogD	BIT 
SELECT @RegistraLogI = RegistraLog FROM INSERTED 
SELECT @RegistraLogD = RegistraLog FROM DELETED 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'ArquivosRemessa'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioGeracao : «' + RTRIM( ISNULL( CAST (UsuarioGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| QtdeRegistros : «' + RTRIM( ISNULL( CAST (QtdeRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Estornado IS NULL THEN ' Estornado : «Nulo» '
                                              WHEN  Estornado = 0 THEN ' Estornado : «Falso» '
                                              WHEN  Estornado = 1 THEN ' Estornado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioGeracao : «' + RTRIM( ISNULL( CAST (UsuarioGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| QtdeRegistros : «' + RTRIM( ISNULL( CAST (QtdeRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Estornado IS NULL THEN ' Estornado : «Nulo» '
                                              WHEN  Estornado = 0 THEN ' Estornado : «Falso» '
                                              WHEN  Estornado = 1 THEN ' Estornado : «Verdadeiro» '
                                    END  FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
 END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
AND @RegistraLogI = 1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioGeracao : «' + RTRIM( ISNULL( CAST (UsuarioGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| QtdeRegistros : «' + RTRIM( ISNULL( CAST (QtdeRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Estornado IS NULL THEN ' Estornado : «Nulo» '
                                              WHEN  Estornado = 0 THEN ' Estornado : «Falso» '
                                              WHEN  Estornado = 1 THEN ' Estornado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| IdBancoSiscafw : «' + RTRIM( ISNULL( CAST (IdBancoSiscafw AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioGeracao : «' + RTRIM( ISNULL( CAST (UsuarioGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| QtdeRegistros : «' + RTRIM( ISNULL( CAST (QtdeRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorTotal : «' + RTRIM( ISNULL( CAST (ValorTotal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SequencialRemessa : «' + RTRIM( ISNULL( CAST (SequencialRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Estornado IS NULL THEN ' Estornado : «Nulo» '
                                              WHEN  Estornado = 0 THEN ' Estornado : «Falso» '
                                              WHEN  Estornado = 1 THEN ' Estornado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
