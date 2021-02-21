

/* 
OC 53039 - Selvino 
OC 68399  - orlando - implementação dos campos tipo valor e listagem, UF e cidades
*/

   
CREATE PROCEDURE [dbo].[CamposDinamicosProcesso] 
@TipoProcesso INT,
@Where VARCHAR(8000),
@Order VARCHAR(8000)
AS

DECLARE
	@SQL VARCHAR(8000),
	@Coluna VARCHAR(8000),
    @Titulo VARCHAR(8000),
    @Campos VARCHAR(8000)
    
SET
	@SQL = 'SELECT Processos.NumeroProc as [Número], Processos.AnoProc as [Ano], '
 
DECLARE campos_dinamicos_cursor CURSOR FAST_FORWARD READ_ONLY FOR

 SELECT CASE TipoCampo
         /* alpha */
         WHEN 'G' THEN 'dbo.CampoGridProcesso(IdProcesso,''' + NomeCampo + ''') '
         WHEN 'A' THEN NomeCampo
         WHEN 'D' THEN NomeCampo
         WHEN 'N' THEN NomeCampo
         WHEN 'V' THEN NomeCampo
         /* tabela */
         WHEN 'T' THEN '(SELECT Descricao  
                          FROM ' + RTRIM(NomeTabelaAux) + 
                       ' WHERE Processos.' + RTRIM(NomeCampo) + ' = ' + RTRIM(NomeTabelaAux) + '.' + RTRIM(NomeCampo) + ')'
		 /* pessoa */                         
         WHEN 'P' THEN 
         	         CASE td.NomeCampo 
          	           WHEN 'IdTabela1Pessoa' THEN
         	            '(SELECT CASE  
                                  WHEN Processos.IdTabela1Prof IS NOT NULL THEN   
                                       (SELECT Nome FROM Profissionais where IdProfissional = Processos.IdTabela1Prof ) 
                                  WHEN Processos.IdTabela1PJ IS NOT NULL THEN 
                                       (SELECT Nome FROM PessoasJuridicas where IdPessoaJuridica = Processos.IdTabela1PJ) 
                                  WHEN Processos.IdTabela1Pessoa IS NOT NULL THEN 
                                       (SELECT Nome FROM Pessoas where IdPessoa = Processos.IdTabela1Pessoa )  
                               END)'
          	           WHEN 'IdTabela2Pessoa' THEN
         	            '(SELECT CASE  
                                  WHEN Processos.IdTabela2Prof IS NOT NULL THEN   
                                       (SELECT Nome FROM Profissionais where IdProfissional = Processos.IdTabela2Prof ) 
                                  WHEN Processos.IdTabela2PJ IS NOT NULL THEN 
                                       (SELECT Nome FROM PessoasJuridicas where IdPessoaJuridica = Processos.IdTabela2PJ) 
                                  WHEN Processos.IdTabela2Pessoa IS NOT NULL THEN 
                                       (SELECT Nome FROM Pessoas where IdPessoa = Processos.IdTabela2Pessoa )  
                               END)'
          	           WHEN 'IdTabela3Pessoa' THEN
         	            '(SELECT CASE  
                                  WHEN Processos.IdTabela3Prof IS NOT NULL THEN   
                                       (SELECT Nome FROM Profissionais where IdProfissional = Processos.IdTabela3Prof ) 
                                  WHEN Processos.IdTabela3PJ IS NOT NULL THEN 
                                       (SELECT Nome FROM PessoasJuridicas where IdPessoaJuridica = Processos.IdTabela3PJ) 
                                  WHEN Processos.IdTabela3Pessoa IS NOT NULL THEN 
                                       (SELECT Nome FROM Pessoas where IdPessoa = Processos.IdTabela3Pessoa )  
                               END)'
          	           WHEN 'IdTabela4Pessoa' THEN
         	            '(SELECT CASE  
                                  WHEN Processos.IdTabela4Prof IS NOT NULL THEN   
                                       (SELECT Nome FROM Profissionais where IdProfissional = Processos.IdTabela4Prof ) 
                                  WHEN Processos.IdTabela4PJ IS NOT NULL THEN 
                                       (SELECT Nome FROM PessoasJuridicas where IdPessoaJuridica = Processos.IdTabela4PJ) 
                                  WHEN Processos.IdTabela4Pessoa IS NOT NULL THEN 
                                       (SELECT Nome FROM Pessoas where IdPessoa = Processos.IdTabela4Pessoa )  
                               END)'
          	           WHEN 'IdTabela5Pessoa' THEN
         	            '(SELECT CASE  
                                  WHEN Processos.IdTabela5Prof IS NOT NULL THEN   
                                       (SELECT Nome FROM Profissionais where IdProfissional = Processos.IdTabela5Prof ) 
                                  WHEN Processos.IdTabela5PJ IS NOT NULL THEN 
                                       (SELECT Nome FROM PessoasJuridicas where IdPessoaJuridica = Processos.IdTabela5PJ) 
                                  WHEN Processos.IdTabela5Pessoa IS NOT NULL THEN 
                                       (SELECT Nome FROM Pessoas where IdPessoa = Processos.IdTabela5Pessoa )  
                               END)'
                        ELSE '/* NAO IMPLEMENTADO ' + td.NomeCampo + '*/'
                      END 
               WHEN '¿' THEN 
         	         CASE td.NomeCampo 
          	           WHEN 'processoLista1' THEN
         	            '(SELECT descricao FROM Processos_ProcessosLista1 PL1 JOIN ProcessosLista1 L1 ON L1.IdProcessoLista1 = PL1.IdProcessoLista1 WHERE PL1.IdProcesso = Processos.IdProcesso) '
         	         ELSE '/* NAO IMPLEMENTADO ' + td.NomeCampo + '*/'
                     END 
                WHEN 'U' THEN 
         	         CASE td.NomeCampo 
          	           WHEN 'IdUF1' THEN
         	            '(SELECT SiglaUF FROM Estados E WHERE E.IdEstado = Processos.IdUF1) '
         	           WHEN 'IdUF2' THEN
         	            '(SELECT SiglaUF FROM Estados E WHERE E.IdEstado = Processos.IdUF2) '
         	         ELSE '/* NAO IMPLEMENTADO ' + td.NomeCampo + '*/'
                     END   
                WHEN 'C' THEN 
         	         CASE td.NomeCampo 
          	           WHEN 'IdCidade1' THEN
         	            '(SELECT NomeCidade FROM Cidades E WHERE E.IdCidade = Processos.IdCidade1) '
         	           WHEN 'IdCidade2' THEN
         	            '(SELECT NomeCidade FROM Cidades E WHERE E.IdCidade = Processos.IdCidade2) '
         	         ELSE '/* NAO IMPLEMENTADO ' + td.NomeCampo + '*/'
                     END   
         ELSE '/* TIPO ' + TipoCampo + ' NÃO IMPLEMENTADO */'
        END AS Coluna, RTRIM(td.TituloImpressora)
  FROM TelasDefinicoes td
WHERE td.CodigoTela = 1
  --AND TipoCampo <> 'G'
  AND td.IdTipoProcesso = @TipoProcesso
OPEN campos_dinamicos_cursor 
FETCH FROM campos_dinamicos_cursor INTO @Coluna, @Titulo
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = @SQL + RTRIM(@Coluna) + ' AS [' + @Titulo +'], ' 
	FETCH FROM campos_dinamicos_cursor INTO @Coluna, @Titulo
END
CLOSE campos_dinamicos_cursor
DEALLOCATE campos_dinamicos_cursor


SET @Campos = ' Processos.Observacao as [Observação], ' +   
'(SELECT TOP 1 DataSituacao  
    FROM Processos_SituacoesProcesso psp
   WHERE psp.IdProcesso = Processos.IdProcesso 
   ORDER BY psp.DataSituacao DESC) AS [Data Última Situação],' +  
'(SELECT TOP 1 spf.SituacaoProcFis
   FROM Processos_SituacoesProcesso psp
        JOIN SituacoesProcFis spf
          ON spf.IdSituacaoProcFis = psp.IdSituacaoProcFis 
 WHERE psp.IdProcesso = Processos.IdProcesso 
  ORDER BY psp.DataSituacao DESC)  AS [Última Situação],'
  
/* Foram adicionados varios exec's abaixo pois a concatenação de campos está limitada
*  devido a impossibilidade de utilizar VARCHAR(MAX) no SQL 2000, e verificamos que o 
*  exec concatenado nao esta limitado.
*/

/* WHERE OK e ORDER NO */
IF (LEN(RTRIM(ISNULL(@Where, ''))) > 0) AND (LEN(RTRIM(ISNULL(@Order, ''))) <= 0)
	EXEC (@SQL + @Campos + ' Processos.IdProcesso  FROM Processos' + ' WHERE ' + @Where)

/* WHERE OK e ORDER OK */
ELSE IF (LEN(RTRIM(ISNULL(@Where, ''))) > 0) AND (LEN(RTRIM(ISNULL(@Order, ''))) > 0)
	EXEC (@SQL + @Campos + ' Processos.IdProcesso  FROM Processos' + ' WHERE ' + @Where + ' ORDER BY ' + @Order)

/* WHERE NO e ORDER OK */
ELSE IF (LEN(RTRIM(ISNULL(@Where, ''))) <= 0) AND (LEN(RTRIM(ISNULL(@Order, ''))) > 0)
	EXEC (@SQL + @Campos + ' Processos.IdProcesso  FROM Processos' + ' ORDER BY ' + @Order)

/* WHERE NO e ORDER NO */
ELSE IF (LEN(RTRIM(ISNULL(@Where, ''))) <= 0) AND (LEN(RTRIM(ISNULL(@Order, ''))) <= 0)
	EXEC (@SQL + @Campos + ' Processos.IdProcesso  FROM Processos')


