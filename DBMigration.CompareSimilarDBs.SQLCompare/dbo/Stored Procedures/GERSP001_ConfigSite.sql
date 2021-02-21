

CREATE PROC dbo.GERSP001_ConfigSite 
(  
    @OPCAO                            INT,
    @NU_CONFIG                        NUMERIC(05)       = NULL,
    @DE_MODELO_PADRAO	                CHAR(10)          = NULL,
    @DE_IMAGENS_CABECALHO             VARCHAR(80)       = NULL,
    @DE_ARQUIVO_LOGO	                VARCHAR(80)       = NULL,
    @DE_COR_LINHA_MODULO	            CHAR(07)          = NULL,
    @DE_TEXTO_EMPRESA	                VARCHAR(80)       = NULL,
    @DE_COR_FUNDO_CABECALHO_01	      CHAR(07)          = NULL,
    @DE_COR_FUNDO_CABECALHO_02	      CHAR(07)          = NULL,
    @DE_COR_FUNDO_MENU_01	            CHAR(07)          = NULL,
    @DE_COR_FUNDO_MENU_02	            CHAR(07)          = NULL,
    @DE_COR_LINHA_ABAIXO_MENU	        CHAR(07)          = NULL,
    @DE_COR_LINHA_CIMA_RODAPE	        CHAR(07)          = NULL,
    @DE_COR_FUNDO_RODAPE_01	          CHAR(07)          = NULL,
    @DE_COR_FUNDO_RODAPE_02	          CHAR(07)          = NULL,
    @DE_COR_LINHA_ABAIXO_RODAPE	      CHAR(07)          = NULL
)  
AS   
BEGIN  

    IF @OPCAO = 1 
    BEGIN   
        SELECT
            NU_CONFIG                             AS NU_CONFIG,
            DE_MODELO_PADRAO                      AS DE_MODELO_PADRAO,
            DE_IMAGENS_CABECALHO                  AS DE_IMAGENS_CABECALHO,
            DE_ARQUIVO_LOGO                       AS DE_ARQUIVO_LOGO,
            DE_COR_LINHA_MODULO                   AS DE_COR_LINHA_MODULO,
            DE_TEXTO_EMPRESA                      AS DE_TEXTO_EMPRESA,
            DE_COR_FUNDO_CABECALHO_01             AS DE_COR_FUNDO_CABECALHO_01,
            DE_COR_FUNDO_CABECALHO_02             AS DE_COR_FUNDO_CABECALHO_02,
            DE_COR_FUNDO_MENU_01                  AS DE_COR_FUNDO_MENU_01,
            DE_COR_FUNDO_MENU_02                  AS DE_COR_FUNDO_MENU_02,
            DE_COR_LINHA_ABAIXO_MENU              AS DE_COR_LINHA_ABAIXO_MENU,
            DE_COR_LINHA_CIMA_RODAPE              AS DE_COR_LINHA_CIMA_RODAPE,
            DE_COR_FUNDO_RODAPE_01                AS DE_COR_FUNDO_RODAPE_01,
            DE_COR_FUNDO_RODAPE_02                AS DE_COR_FUNDO_RODAPE_02,
            DE_COR_LINHA_ABAIXO_RODAPE            AS DE_COR_LINHA_ABAIXO_RODAPE
        FROM
            ConfiguracaoModuloGerencial
        WHERE
            NU_CONFIG                             = @NU_CONFIG
    END

    ELSE
    IF @OPCAO = 2 
    BEGIN
        UPDATE
            ConfiguracaoModuloGerencial
        SET
            DE_MODELO_PADRAO                      = @DE_MODELO_PADRAO,
            DE_IMAGENS_CABECALHO                  = @DE_IMAGENS_CABECALHO,
            DE_ARQUIVO_LOGO                       = @DE_ARQUIVO_LOGO,
            DE_COR_LINHA_MODULO                   = @DE_COR_LINHA_MODULO,
            DE_TEXTO_EMPRESA                      = @DE_TEXTO_EMPRESA,
            DE_COR_FUNDO_CABECALHO_01             = @DE_COR_FUNDO_CABECALHO_01,
            DE_COR_FUNDO_CABECALHO_02             = @DE_COR_FUNDO_CABECALHO_02,
            DE_COR_FUNDO_MENU_01                  = @DE_COR_FUNDO_MENU_01,
            DE_COR_FUNDO_MENU_02                  = @DE_COR_FUNDO_MENU_02,
            DE_COR_LINHA_ABAIXO_MENU              = @DE_COR_LINHA_ABAIXO_MENU,
            DE_COR_LINHA_CIMA_RODAPE              = @DE_COR_LINHA_CIMA_RODAPE,
            DE_COR_FUNDO_RODAPE_01                = @DE_COR_FUNDO_RODAPE_01,
            DE_COR_FUNDO_RODAPE_02                = @DE_COR_FUNDO_RODAPE_02,
            DE_COR_LINHA_ABAIXO_RODAPE            = @DE_COR_LINHA_ABAIXO_RODAPE
        WHERE
            NU_CONFIG                             = @NU_CONFIG
    END

END




