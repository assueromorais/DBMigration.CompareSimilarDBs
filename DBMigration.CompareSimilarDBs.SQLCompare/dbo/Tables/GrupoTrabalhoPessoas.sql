CREATE TABLE [dbo].[GrupoTrabalhoPessoas] (
    [IdGrupoTrabalhoPessoas] INT      IDENTITY (1, 1) NOT NULL,
    [IdGrupoTrabalho]        INT      NOT NULL,
    [IdPessoaSispad]         INT      NOT NULL,
    [DataInicio]             DATETIME NULL,
    [DataTermino]            DATETIME NULL,
    [E_Coordenador]          BIT      NULL,
    [E_CoordenadorAdjunto]   BIT      NULL,
    CONSTRAINT [PK_GrupoTrabalhoPessoas] PRIMARY KEY CLUSTERED ([IdGrupoTrabalho] ASC, [IdPessoaSispad] ASC),
    CONSTRAINT [FK_GrupoTrabalhoPessoas_GrupoTrabalho] FOREIGN KEY ([IdGrupoTrabalho]) REFERENCES [dbo].[GrupoTrabalho] ([IdGrupoTrabalho]),
    CONSTRAINT [FK_GrupoTrabalhoPessoas_PessoasSispad] FOREIGN KEY ([IdPessoaSispad]) REFERENCES [dbo].[PessoasSispad] ([IdPessoaSispad])
);


GO
CREATE TRIGGER [TrgLog_GrupoTrabalhoPessoas] ON [Implanta_CRPAM].[dbo].[GrupoTrabalhoPessoas] 
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
SET @TableName = 'GrupoTrabalhoPessoas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdGrupoTrabalhoPessoas : «' + RTRIM( ISNULL( CAST (IdGrupoTrabalhoPessoas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoTrabalho : «' + RTRIM( ISNULL( CAST (IdGrupoTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Coordenador IS NULL THEN ' E_Coordenador : «Nulo» '
                                              WHEN  E_Coordenador = 0 THEN ' E_Coordenador : «Falso» '
                                              WHEN  E_Coordenador = 1 THEN ' E_Coordenador : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_CoordenadorAdjunto IS NULL THEN ' E_CoordenadorAdjunto : «Nulo» '
                                              WHEN  E_CoordenadorAdjunto = 0 THEN ' E_CoordenadorAdjunto : «Falso» '
                                              WHEN  E_CoordenadorAdjunto = 1 THEN ' E_CoordenadorAdjunto : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdGrupoTrabalhoPessoas : «' + RTRIM( ISNULL( CAST (IdGrupoTrabalhoPessoas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoTrabalho : «' + RTRIM( ISNULL( CAST (IdGrupoTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Coordenador IS NULL THEN ' E_Coordenador : «Nulo» '
                                              WHEN  E_Coordenador = 0 THEN ' E_Coordenador : «Falso» '
                                              WHEN  E_Coordenador = 1 THEN ' E_Coordenador : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_CoordenadorAdjunto IS NULL THEN ' E_CoordenadorAdjunto : «Nulo» '
                                              WHEN  E_CoordenadorAdjunto = 0 THEN ' E_CoordenadorAdjunto : «Falso» '
                                              WHEN  E_CoordenadorAdjunto = 1 THEN ' E_CoordenadorAdjunto : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdGrupoTrabalhoPessoas : «' + RTRIM( ISNULL( CAST (IdGrupoTrabalhoPessoas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoTrabalho : «' + RTRIM( ISNULL( CAST (IdGrupoTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Coordenador IS NULL THEN ' E_Coordenador : «Nulo» '
                                              WHEN  E_Coordenador = 0 THEN ' E_Coordenador : «Falso» '
                                              WHEN  E_Coordenador = 1 THEN ' E_Coordenador : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_CoordenadorAdjunto IS NULL THEN ' E_CoordenadorAdjunto : «Nulo» '
                                              WHEN  E_CoordenadorAdjunto = 0 THEN ' E_CoordenadorAdjunto : «Falso» '
                                              WHEN  E_CoordenadorAdjunto = 1 THEN ' E_CoordenadorAdjunto : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdGrupoTrabalhoPessoas : «' + RTRIM( ISNULL( CAST (IdGrupoTrabalhoPessoas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoTrabalho : «' + RTRIM( ISNULL( CAST (IdGrupoTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSispad : «' + RTRIM( ISNULL( CAST (IdPessoaSispad AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataTermino : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermino, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Coordenador IS NULL THEN ' E_Coordenador : «Nulo» '
                                              WHEN  E_Coordenador = 0 THEN ' E_Coordenador : «Falso» '
                                              WHEN  E_Coordenador = 1 THEN ' E_Coordenador : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  E_CoordenadorAdjunto IS NULL THEN ' E_CoordenadorAdjunto : «Nulo» '
                                              WHEN  E_CoordenadorAdjunto = 0 THEN ' E_CoordenadorAdjunto : «Falso» '
                                              WHEN  E_CoordenadorAdjunto = 1 THEN ' E_CoordenadorAdjunto : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
