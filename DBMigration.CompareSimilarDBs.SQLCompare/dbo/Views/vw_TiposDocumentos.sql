

CREATE VIEW dbo.vw_TiposDocumentos
AS
SELECT     *
FROM         TiposDocumentos
WHERE     TipoDocumento NOT IN
                          (SELECT     TipoDocumento
                            FROM          TiposDocumentos
                            WHERE      (IndCriacao = 1) OR
                                                   (IndCriacao IS NULL))
UNION
SELECT     *
FROM         TiposDocumentos
WHERE     (IndCriacao = 1) OR
                      (IndCriacao IS NULL)




