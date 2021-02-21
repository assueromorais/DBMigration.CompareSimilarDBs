/*Ocorr 58774 - Selvino*/  
/*Alterado pelo Orlando em 30/08/2010 - ocorr. 66779*/
  
CREATE FUNCTION [dbo].[ufnZonaBairro]  
(  
 @IdEndereco INT  
)  
RETURNS VARCHAR(100)  
AS  
BEGIN  
 DECLARE @Zona VARCHAR(100)  
 SET @Zona = NULL;  
   
 SELECT @Zona = z.Descricao  
 FROM   Bairros b  
 JOIN ZonasBairros zb
	ON zb.IdBairro = b.IdBairro
 JOIN Zonas z  
    ON  z.IdZona = zb.idZona 
 JOIN Cidades c
    ON c.IdCidade = z.IdCidade
JOIN (  
            SELECT e.NomeBairro,
            e.nomeCidade
            FROM   Enderecos e  
            WHERE  e.IdEndereco = @IdEndereco  
        )AS Endereco 
     ON Endereco.NomeBairro = b.NomeBairro
        AND Endereco.nomeCidade = c.NomeCidade   
 RETURN @Zona;  
END  

