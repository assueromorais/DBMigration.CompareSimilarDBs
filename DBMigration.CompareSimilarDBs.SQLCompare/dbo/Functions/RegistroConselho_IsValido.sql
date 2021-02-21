/*
 * Oc 223120 
 * Criado por Wesley
 */
/* Criando uma função que valida se o registro e valido. */
CREATE FUNCTION RegistroConselho_IsValido(@RegistroConselho VARCHAR(20),@IdProfissional INT) 
RETURNS BIT AS
BEGIN
    DECLARE @VALIDO BIT 
    SET @VALIDO = 1 
    
    IF ( SELECT ISNULL(IndIncrementoRegistroProf, 0) FROM   ParametrosSiscafw ) >= 1 
    BEGIN 
          /* existe pelo menos um registro cadastrado */
        IF EXISTS(SELECT top 1 1 FROM Profissionais_CategoriasProf WHERE IdProfissional = @IdProfissional and ((ISNULL(RegistroConselho ,0) <> 0) or (RTRIM(LTRIM(RegistroConselho)) <> '')) )
        BEGIN
                 /* verifica se existe o registro passado como parametro existe, caso não exista não poderá ser cadastrado. */
              IF NOT EXISTS(SELECT TOP 1 1 FROM Profissionais_CategoriasProf WHERE IdProfissional = @IdProfissional  AND ISNULL(RegistroConselho ,0) = ISNULL(@RegistroConselho ,0)) 
              BEGIN
                     /* já existe outro registro cadastrado. Não será possivel incluir este número de registro. */
                  SET @VALIDO = 0
              END
        END
    END
      
    RETURN @VALIDO
END
