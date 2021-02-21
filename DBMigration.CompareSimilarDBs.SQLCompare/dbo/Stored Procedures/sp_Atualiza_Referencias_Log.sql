/*Oc. 64821 - Victor*/ 
/*Oc. 96268 - Charbel - Inclusão de novos cabeçalhos*/ 
 
CREATE PROCEDURE [dbo].[sp_Atualiza_Referencias_Log] 
as 
 
BEGIN 
 
BEGIN TRAN 
 
SET NOCOUNT ON 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
 
 
/****** Object  Table dbo.Assunto_Log ******/ 
CREATE TABLE #T_Assunto_Log( 
	Id_Assunto smallint NOT NULL, 
	Assunto varchar(50) COLLATE LATIN1_GENERAL_CI_AI NULL, 
	id_AssuntoPai smallint NULL, 
	Nivel smallint NULL 
)  
 
/****** Object  Table dbo.Cabecalho_Tabela_Log  ******/ 
CREATE TABLE #T_Cabecalho_Tabela_Log( 
	Id_Cabecalho smallint NOT NULL, 
	Id_Tabela smallint , 
	Nome_Campo_Cabecalho varchar(50) COLLATE LATIN1_GENERAL_CI_AI NOT NULL, 
	Comando varchar(3000) NULL, 
	Ordem_Apresentacao tinyint NULL, 
	Cabecalho_Exclusao bit NOT NULL 
)  
 
/****** Object Table dbo.Assunto_Tabela_Log ******/ 
CREATE TABLE #T_Assunto_Tabela_Log( 
	Id_Assunto smallint NOT NULL, 
	Tabela varchar(50) 
)  
 
/****** Object Table dbo.Tabela_Dominio_Campo_Log  ******/ 
CREATE TABLE #T_Tabela_Dominio_Campo_Log( 
	Id_campo_Log smallint NULL, 
	Id_Tabela smallint NULL, 
	Nome_Campo varchar(128) NULL, 
	Nome_Campo_Pesquisa varchar(128) COLLATE LATIN1_GENERAL_CI_AI NULL 
)  
 
/****** Object Table dbo.Dominio_Campo_Log   ******/ 
CREATE TABLE #T_Dominio_Campo_Log( 
	Id_Campo_Log smallint  NULL, 
	Valor_Dominio sql_variant  NULL, 
	Descricao varchar(50) COLLATE LATIN1_GENERAL_CI_AI NULL 
)  
 
/****** Object Table dbo.Assunto_Tabela_Log ******/ 
CREATE TABLE #T_Campo_Log( 
	Nome_Campo varchar(128), 
	Tabela varchar(50), 
	Nome_Titulo varchar(200), 
	IdTipoDominio tinyint, 
	ApresentaCampo char(1), 
	ApresentaCampoExclusao char(1) 
)  
 
/* Esse SQL gera os inserts para a tabela #Assunto_Log 
 
SELECT  
' INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (' + 
convert (varchar(20),Id_Assunto) + ', ' + char(39) + Assunto  + char(39)  + ', '  + isnull (convert (varchar(20),id_AssuntoPai),'null') + ', ' + isnull (convert (varchar(20),Nivel),'null')+ ' )' 
FROM dbo.Assunto_Log T1 
 
*/ 
/****** Object Table dbo.Assunto_Log  ******/ 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (1, 'Sistemas', null, 0 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (2, 'Débitos', 18, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (3, 'SISCAF', 1, 1 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (4, 'Situações PF', 7, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (5, 'Endereços', 3, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (6, 'Dados Básicos PF', 7, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (7, 'Profissionais', 3, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (8, 'Pessoa Jurídica', 3, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (9, 'Dados Básicos PJ', 8, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (12, 'Situações PJ', 8, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (13, 'Categorias PJ', 8, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (14, 'Categorias PF', 7, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (15, 'Experiência Profissional', 7, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (16, 'Formação', 7, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (17, 'Ocorrências', 3, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (18, 'Financeiro', 3, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (20, 'Outras Pessoas', 3, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (21, 'Processos', 3, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (22, 'Dados processo', 21, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (23, 'Tramitações', 21, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (24, 'Ocorrências Proc.', 21, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (26, 'Andamentos', 21, 3 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (27, 'Sisdoc', 1, 1 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (28, 'Manutenção de Documentos', 27, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (30, 'Tramitações SISDOC', 27, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (38, 'Ocorrências SISDOC', 27, 2 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (39, 'Cédulas de Identificação WEB', 1, 1 ) 
 INSERT #T_Assunto_Log (Id_Assunto, Assunto, id_AssuntoPai, Nivel) VALUES (40, 'Pedido de Cédula', 39, 2 ) 
  
 -- 1 ASSUNTO_LOG 
UPDATE ImplantaLog.dbo.Assunto_Log SET 
Assunto=t2.Assunto, 
id_AssuntoPai=t2.id_AssuntoPai, 
Nivel=t2.Nivel 
FROM ImplantaLog.dbo.Assunto_Log t1, 
     #T_Assunto_Log t2 
WHERE t1.Id_Assunto = t2.Id_Assunto 
 
SET IDENTITY_INSERT ImplantaLog.dbo.Assunto_Log ON 
INSERT INTO ImplantaLog.dbo.Assunto_Log (Id_Assunto,Assunto,id_AssuntoPai,Nivel) 
SELECT Id_Assunto,Assunto,id_AssuntoPai,Nivel 
FROM   #T_Assunto_Log 
WHERE  Id_Assunto NOT IN (SELECT ID_ASSUNTO FROM ImplantaLog.dbo.Assunto_Log al) 
 
SET IDENTITY_INSERT ImplantaLog.dbo.Assunto_Log OFF 
 
/* Esse SQL gera os inserts para a tabela ##T_Assunto_Tabela_Log. Todas as vezes que desejar vincular umA 
   nova tabela a um assunto esse SQL deve ser executado e o resultado dele substituirá os inserts abaixo.  
 
SELECT  
'INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (' + 
CONVERT (VARCHAR(10),Id_Assunto) +  ' , ' + 
 CHAR(39) + Tabela  + CHAR(39) +  ') ' 
FROM dbo.Assunto_Tabela_Log T1, 
     dbo.Tabela_Log T2  
WHERE T2.Id_Tabela=T1.Id_Tabela 
 
*/ 
 
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (2 , 'Debitos')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (4 , 'Profissionais_SituacoesPF')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (4 , 'SituacoesPFPJ')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (5 , 'Enderecos')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (6 , 'Profissionais')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (9 , 'PessoasJuridicas')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (12 , 'PessoasJuridicas_SituacoesPFPJ')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (12 , 'SituacoesPFPJ')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (13 , 'PessoasJuridicas_CategoriaPJ')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (13 , 'TiposInscricao')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (14 , 'Profissionais_CategoriasProf')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (14 , 'TiposInscricao')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (15 , 'ExperienciasProfissionais')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (16 , 'CursosEventosRealizado')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (17 , 'OcorrenciasPFPJ')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (17 , 'OcorrenciasPFPJ_SituacoesOcorrencia')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (17 , 'OcorrenciasSiscafw')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (17 , 'SituacoesOcorrencia')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (20 , 'Pessoas')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (21 , 'Etapas')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (21 , 'Processos')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (21 , 'TelasDefinicoes')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (21 , 'TipoProcesso')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (22 , 'Etapas')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (22 , 'Processos')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (22 , 'TipoProcesso')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (23 , 'Tramitacoes')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (24 , 'Ocorrencias')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (26 , 'Fases')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (26 , 'Processo_Fases')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (28 , 'DocumentosSisdoc')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (30 , 'Tramitacoes')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (38 , 'Ocorrencias')  
INSERT INTO #T_Assunto_Tabela_Log (Id_Assunto, Tabela) VALUES (40 , 'PedidosCedulaIdentidadeProfissional')  
 
   
 SELECT t1.Id_Assunto, 
 Id_Tabela=(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log t3 WHERE t3.Tabela COLLATE LATIN1_GENERAL_CI_AI = t1.Tabela COLLATE LATIN1_GENERAL_CI_AI) 
 INTO #T_Assunto_Tabela_Log_final 
 FROM #T_Assunto_Tabela_Log t1 
     
 DELETE FROM  #T_Assunto_Tabela_Log_final 
 WHERE  Id_Tabela IS NULL 
   
 INSERT INTO ImplantaLog.dbo.Assunto_Tabela_Log (Id_Assunto,Id_Tabela)      
 SELECT t1.Id_Assunto,t1.Id_Tabela 
 FROM #T_Assunto_Tabela_Log_final t1 left join ImplantaLog.dbo.Assunto_Tabela_Log t2 on   
      t1.Id_Assunto=t2.Id_Assunto and t1.Id_Tabela=t2.Id_Tabela 
 WHERE t2.Id_Assunto is null 
  
 DELETE ImplantaLog.dbo.Assunto_Tabela_Log     
 FROM #T_Assunto_Tabela_Log_final t1 right join ImplantaLog.dbo.Assunto_Tabela_Log t2 on   
      t1.Id_Assunto=t2.Id_Assunto and t1.Id_Tabela=t2.Id_Tabela 
 WHERE t1.Id_Assunto is null 
 
/* Esse SQL gera os inserts para a tabela #T_Cabecalho_Tabela_Log. Todas as vezes que desejar vincular uma 
   nova tabela a um assunto esse SQL deve ser executado e o resultado dele substituirá os inserts abaixo.    
 
SELECT  
'INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao) ' + 
' SELECT ' +  
' Id_Cabecalho= ' + CONVERT (VARCHAR(20),Id_Cabecalho) + ' , ' + 
' Id_Tabela= ' + '(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = ' + CHAR(39) + (SELECT Tabela FROM dbo.Tabela_Log T2 WHERE T2.Id_Tabela=T1.Id_Tabela) + CHAR(39)  +') ' + ' , ' + 
' Nome_Campo_Cabecalho= ' + CASE WHEN Nome_Campo_Cabecalho IS NULL THEN 'NULL ' ELSE + CHAR(39) + Nome_Campo_Cabecalho + CHAR(39) END + ' , ' + 
' Comando= ' + CHAR(39) + Comando + CHAR(39) + ' , ' + 
' Ordem_Apresentacao= ' + CASE WHEN Ordem_Apresentacao IS NULL THEN ' NULL' ELSE CONVERT (VARCHAR(20),Ordem_Apresentacao) END + ' , ' + 
' Cabecalho_Exclusao= ' + CASE WHEN Cabecalho_Exclusao IS NULL THEN ' NULL' ELSE CONVERT (VARCHAR(20),Cabecalho_Exclusao)  END    
FROM ImplantaLog.dbo.Cabecalho_Tabela_Log T1 
*/  
  
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 1 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT   Nome= CASE    WHEN idprofissional IS NOT NULL THEN (SELECT nome FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional=d.idprofissional)   WHEN IdPessoaJuridica IS NOT NULL THEN '+ 
'(SELECT nome FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p WHERE p.IdPessoaJuridica=d.IdPessoaJuridica)  '+ 
' WHEN IdPessoa IS NOT NULL THEN (SELECT nome FROM @Nome_Banco_Dados.dbo.Pessoas pe WHERE pe.IdPessoa=d.IdPessoa)   END   FROM @Nome_Banco_Dados.dbo.Debitos d      ' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 2 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos')  ,  Nome_Campo_Cabecalho= 'Dt Venc' ,   
Comando= 'SELECT convert (varchar (10), DataVencimento, 103)  FROM @Nome_Banco_Dados.dbo.Debitos' ,  Ordem_Apresentacao= 6 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 3 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos')  ,  Nome_Campo_Cabecalho= 'Tipo Débito' ,   
Comando= 'SELECT SiglaDebito  FROM @Nome_Banco_Dados.dbo.Debitos d    inner join @Nome_Banco_Dados.dbo.TiposDebito td on d.IdTipoDebito = td.IdTipoDebito  ' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 4 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos')  ,  Nome_Campo_Cabecalho= 'Ano Ref' ,   
Comando= 'SELECT year (DataReferencia)   FROM @Nome_Banco_Dados.dbo.Debitos' ,  Ordem_Apresentacao= 3 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 5 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos')  ,  Nome_Campo_Cabecalho= 'Valor Devido' ,  Comando= 'SELECT ValorDevido  FROM @Nome_Banco_Dados.dbo.Debitos' ,  
 Ordem_Apresentacao= 4 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 6 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos')  ,  Nome_Campo_Cabecalho= 'Nº Parcela' ,  Comando= 'SELECT  NumeroParcela  FROM @Nome_Banco_Dados.dbo.Debitos' , 
  Ordem_Apresentacao= 5 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 7 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos')  ,  Nome_Campo_Cabecalho= 'Situação Débito' ,   
Comando= 'SELECT SituacaoDebito  FROM @Nome_Banco_Dados.dbo.Debitos d    inner join @Nome_Banco_Dados.dbo.SituacoesDebito sd on d.IdSituacaoAtual = sd.IdSituacaoDebito ' ,  Ordem_Apresentacao= 7 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 8 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT  RegistroConselhoAtual = CASE   WHEN idprofissional IS NOT NULL THEN (SELECT RegistroConselhoAtual FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional=d.idprofissional)   '+ 
' WHEN IdPessoaJuridica IS NOT NULL THEN (SELECT RegistroConselhoAtual FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p WHERE p.IdPessoaJuridica=d.IdPessoaJuridica)   END  FROM @Nome_Banco_Dados.dbo.Debitos d    ' ,   
Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 9 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT   Nome= CASE    WHEN idprofissional IS NOT NULL THEN (SELECT nome FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional=e.idprofissional)   WHEN IdPessoaJuridica IS NOT NULL THEN '+ 
' (SELECT nome FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p WHERE p.IdPessoaJuridica=e.IdPessoaJuridica)   WHEN '+ 
' IdPessoa IS NOT NULL THEN (SELECT nome FROM @Nome_Banco_Dados.dbo.Pessoas pe WHERE pe.IdPessoa=e.IdPessoa)   END   FROM @Nome_Banco_Dados.dbo.Enderecos e ' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 11 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,  
Comando= 'SELECT   RegistroConselhoAtual= CASE    WHEN idprofissional IS NOT NULL THEN (SELECT RegistroConselhoAtual FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional=e.idprofissional)   WHEN IdPessoaJuridica IS NOT NULL THEN '+ 
' (SELECT RegistroConselhoAtual FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p WHERE p.IdPessoaJuridica=e.IdPessoaJuridica)   END   FROM @Nome_Banco_Dados.dbo.Enderecos e ' ,  Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 13 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos')  ,  Nome_Campo_Cabecalho= 'Endereco' ,   
Comando= 'SELECT Endereco  FROM @Nome_Banco_Dados.dbo.Enderecos' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 20 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT Nome   FROM @Nome_Banco_Dados.dbo.Profissionais p  ' ,  Ordem_Apresentacao=  NULL ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 21 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT RegistroConselhoAtual   FROM @Nome_Banco_Dados.dbo.Profissionais p ' ,  Ordem_Apresentacao=  NULL ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 22 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_CategoriasProf')  ,  Nome_Campo_Cabecalho= 'Nome Profissional' ,   
Comando= 'SELECT p.Nome   FROM @Nome_Banco_Dados.dbo.Profissionais_CategoriasProf pcp   INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = pcp.IdProfissional   ' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 23 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_CategoriasProf')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT RegistroConselhoAtual   FROM @Nome_Banco_Dados.dbo.Profissionais_CategoriasProf pcp   INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = pcp.IdProfissional   ' ,  Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 24 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_CategoriasProf')  ,  Nome_Campo_Cabecalho= 'Categoria' ,   
Comando= 'SELECT NomeCategoriaProf   FROM @Nome_Banco_Dados.dbo.Profissionais_CategoriasProf pcp   INNER JOIN @Nome_Banco_Dados.dbo.CategoriasProf cp ON cp.IdCategoriaProf = pcp.IdCategoriaProf   ' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 25 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_CategoriasProf')  ,  Nome_Campo_Cabecalho= 'Tipo Inscrição' ,   
Comando= 'SELECT TipoInscricao  FROM @Nome_Banco_Dados.dbo.Profissionais_CategoriasProf pcp   INNER JOIN @Nome_Banco_Dados.dbo.TiposInscricao ti ON ti.IdTipoInscricao = pcp.IdTipoInscricao '+ 
' /*  SELECT NomeCategoriaProf   FROM @Nome_Banco_Dados.dbo.Profissionais_CategoriasProf pcp   INNER JOIN @Nome_Banco_Dados.dbo.CategoriasProf cp ON cp.IdCategoriaProf = pcp.IdCategoriaProf     */' ,  Ordem_Apresentacao= 3 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 29 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_SituacoesPF')  ,  Nome_Campo_Cabecalho= 'Situação' ,   
Comando= 'SELECT sp.NomeSituacao   FROM @Nome_Banco_Dados.dbo.Profissionais_SituacoesPF psp   INNER JOIN @Nome_Banco_Dados.dbo.SituacoesPFPJ sp ON sp.IdSituacaoPFPJ = psp.IdSituacaoPFPJ' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 30 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_SituacoesPF')  ,  Nome_Campo_Cabecalho= 'Nome Profissional' ,   
Comando= 'SELECT p.Nome  FROM @Nome_Banco_Dados.dbo.Profissionais_SituacoesPF psp       INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = psp.IdProfissional  ' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 31 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_SituacoesPF')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT p.RegistroConselhoAtual  FROM @Nome_Banco_Dados.dbo.Profissionais_SituacoesPF psp       INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = psp.IdProfissional  ' ,  Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 32 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_SituacoesPF')  ,  Nome_Campo_Cabecalho= 'Data Início' ,   
Comando= 'SELECT convert (varchar (10), DataInicioSituacao, 103)  FROM @Nome_Banco_Dados.dbo.Profissionais_SituacoesPF' ,  Ordem_Apresentacao= 3 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 33 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_SituacoesPF')  ,  Nome_Campo_Cabecalho= 'Data Fim' ,   
Comando= 'SELECT convert (varchar (10), DataFimSituacao, 103)  FROM @Nome_Banco_Dados.dbo.Profissionais_SituacoesPF' ,  Ordem_Apresentacao= 4 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 34 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_CategoriaPJ')  ,  Nome_Campo_Cabecalho= 'Nome Pessoa Jurídica' ,   
Comando= 'SELECT pj.Nome   FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_CategoriaPJ pjcp      INNER JOIN @Nome_Banco_Dados.dbo.PessoasJuridicas pj ON pj.IdPessoaJuridica = pjcp.IdPessoaJuridica  ' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 35 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_CategoriaPJ')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT pj.RegistroConselhoAtual   FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_CategoriaPJ pjcp      INNER JOIN @Nome_Banco_Dados.dbo.PessoasJuridicas pj ON pj.IdPessoaJuridica = pjcp.IdPessoaJuridica' ,   
Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 36 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_CategoriaPJ')  ,  Nome_Campo_Cabecalho= 'Categoria' ,   
Comando= 'SELECT cp.NomeCategoriaPJ  FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_CategoriaPJ pjcp   INNER JOIN @Nome_Banco_Dados.dbo.CategoriasPJ cp ON cp.IdCategoriaPJ = pjcp.IdCategoriaPJ' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 37 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_CategoriaPJ')  ,  Nome_Campo_Cabecalho= 'Tipo Inscrição' ,   
Comando= 'SELECT ti.TipoInscricao  FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_CategoriaPJ pjcp       INNER JOIN @Nome_Banco_Dados.dbo.TiposInscricao ti ON ti.IdTipoInscricao = pjcp.IdTipoInscricao' ,   
Ordem_Apresentacao= 3 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 40 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_SituacoesPFPJ')  ,  Nome_Campo_Cabecalho= 'Nome Pessoa Jurídica' ,   
Comando= 'SELECT pj.nome  FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_SituacoesPFPJ pjsp   INNER JOIN @Nome_Banco_Dados.dbo.PessoasJuridicas pj ON pj.IdPessoaJuridica = pjsp.IdPessoaJuridica' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 41 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_SituacoesPFPJ')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT pj.RegistroConselhoAtual  FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_SituacoesPFPJ pjsp   INNER JOIN @Nome_Banco_Dados.dbo.PessoasJuridicas pj ON pj.IdPessoaJuridica = pjsp.IdPessoaJuridica' ,   
Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 42 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_SituacoesPFPJ')  ,  Nome_Campo_Cabecalho= 'Situação' ,   
Comando= 'SELECT sp.NomeSituacao  FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_SituacoesPFPJ   INNER JOIN @Nome_Banco_Dados.dbo.SituacoesPFPJ sp ON sp.IdSituacaoPFPJ = PessoasJuridicas_SituacoesPFPJ.IdSituacaoPFPJ' ,   
Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 43 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_SituacoesPFPJ')  ,  Nome_Campo_Cabecalho= 'Data Início' ,   
Comando= 'SELECT convert (varchar (10), DataInicioSituacao, 103)  FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_SituacoesPFPJ' ,  Ordem_Apresentacao= 3 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
  SELECT  Id_Cabecalho= 44 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_SituacoesPFPJ')  ,   
  Nome_Campo_Cabecalho= 'Data Fim' ,   
  Comando= 'SELECT convert (varchar (10), DataFimSituacao, 103)  FROM @Nome_Banco_Dados.dbo.PessoasJuridicas_SituacoesPFPJ' ,   
  Ordem_Apresentacao= 4 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 45 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas')  ,   
Nome_Campo_Cabecalho= 'Nome Pessoa Jurídica' ,  Comando= 'SELECT Nome  FROM @Nome_Banco_Dados.dbo.PessoasJuridicas' ,   
Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 46 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas')  ,   
Nome_Campo_Cabecalho= 'Nº Registro' ,  Comando= 'SELECT RegistroConselhoAtual  FROM @Nome_Banco_Dados.dbo.PessoasJurídicas' ,   
Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 47 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais')  ,   
Nome_Campo_Cabecalho= 'Nome Profissional' ,   
Comando= 'SELECT p.nome   FROM @Nome_Banco_Dados.dbo.ExperienciasProfissionais ep   INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = ep.IdProfissional  ' ,   
Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 48 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais')  ,   
Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT p.RegistroConselhoAtual   FROM @Nome_Banco_Dados.dbo.ExperienciasProfissionais ep   INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = ep.IdProfissional' ,   
Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 49 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado')  ,   
Nome_Campo_Cabecalho= 'Nome Profissional' ,   
Comando= 'SELECT p.nome  FROM @Nome_Banco_Dados.dbo.CursosEventosRealizado cur   INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = cur.IdProfissional' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 50 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado')  ,   
Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT p.RegistroConselhoAtual  FROM @Nome_Banco_Dados.dbo.CursosEventosRealizado cur   INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = cur.IdProfissional' ,   
Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 51 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'OcorrenciasPFPJ')  ,   
Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT Nome= CASE WHEN idprofissional IS NOT NULL THEN (SELECT nome FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional=opfpj.idprofissional) WHEN IdPessoaJuridica IS NOT NULL THEN ' +  
' (SELECT nome FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p  WHERE p.IdPessoaJuridica=opfpj.IdPessoaJuridica) END FROM @Nome_Banco_Dados.dbo.OcorrenciasPFPJ opfpj' ,  
 Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 52 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'OcorrenciasPFPJ')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT  RegistroConselhoAtual = CASE   WHEN idprofissional IS NOT NULL THEN (SELECT RegistroConselhoAtual FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional=opfpj.idprofissional)  '+  
' WHEN IdPessoaJuridica IS NOT NULL THEN (SELECT RegistroConselhoAtual FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p WHERE p.IdPessoaJuridica=opfpj.IdPessoaJuridica)   END  FROM @Nome_Banco_Dados.dbo.OcorrenciasPFPJ opfpj' , 
  Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 55 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'OcorrenciasPFPJ')  ,  Nome_Campo_Cabecalho= 'Ocorrência' ,   
Comando= 'SELECT os.Ocorrencia  FROM @Nome_Banco_Dados.dbo.OcorrenciasPFPJ op   INNER JOIN @Nome_Banco_Dados.dbo.OcorrenciasSiscafw os ON os.IdOcorrencia = op.IdOcorrencia' ,   
Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 56 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas')  ,   
Nome_Campo_Cabecalho= 'Nome' ,  Comando= 'SELECT Nome  FROM @Nome_Banco_Dados.dbo.Pessoas' ,  Ordem_Apresentacao=  NULL ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 57 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas')  ,  Nome_Campo_Cabecalho= 'Tipo Pessoa' ,   
Comando= 'SELECT   E_PessoaJuridica = CASE   when case   FROM @Nome_Banco_Dados.dbo.Pessoas' ,  Ordem_Apresentacao=  NULL ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 59 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Acessos')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT   Nome= CASE WHEN idprofissional IS NOT NULL THEN   (SELECT nome FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional=d.idprofissional)    WHEN IdPessoaJuridica IS NOT NULL  THEN '+ 
' (SELECT nome FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p  WHERE p.IdPessoaJuridica=d.IdPessoaJuridica)     WHEN IdPessoa IS NOT NULL THEN(   SELECT nome FROM @Nome_Banco_Dados.dbo.Pessoas pe WHERE pe.IdPessoa=d.IdPessoa) '+ 
' WHEN Pessoa IS NOT NULL  THEN (SELECT Pessoa FROM @Nome_Banco_Dados.dbo.documentossisdoc )END     FROM @Nome_Banco_Dados.dbo.documentossisdoc d        ' ,  Ordem_Apresentacao=  NULL ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 60 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc')  ,   
Nome_Campo_Cabecalho= 'Nº Protocolo' ,  Comando= 'SELECT  NumProtocolo  FROM @Nome_Banco_Dados.dbo.documentossisdoc' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 61 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT   Nome= CASE   WHEN idprofissional IS NOT NULL THEN (SELECT nome FROM @Nome_Banco_Dados.dbo.Profissionais p   WHERE p.IdProfissional=d.idprofissional)      WHEN IdPessoaJuridica IS NOT NULL  THEN '+ 
' (SELECT nome FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p  WHERE p.IdPessoaJuridica=d.IdPessoaJuridica)       WHEN IdPessoa IS NOT NULL THEN (SELECT nome FROM @Nome_Banco_Dados.dbo.Pessoas pe   WHERE pe.IdPessoa=d.IdPessoa) '+ 
'   END       FROM @Nome_Banco_Dados.dbo.documentossisdoc d      ' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 62 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
Comando= 'SELECT   Registro= CASE   WHEN idprofissional IS NOT NULL THEN (SELECT RegistroConselhoAtual FROM @Nome_Banco_Dados.dbo.Profissionais p   WHERE p.IdProfissional=d.idprofissional)      WHEN IdPessoaJuridica IS NOT NULL  '+  
' THEN (SELECT RegistroConselhoAtual FROM @Nome_Banco_Dados.dbo.PessoasJuridicas p  WHERE p.IdPessoaJuridica=d.IdPessoaJuridica)       WHEN IdPessoa IS NOT NULL THEN  '+ 
' (SELECT nome FROM @Nome_Banco_Dados.dbo.Pessoas pe   WHERE pe.IdPessoa=d.IdPessoa)    END       FROM @Nome_Banco_Dados.dbo.documentossisdoc d      ' ,  Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 63 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc')  ,  Nome_Campo_Cabecalho= 'Nº Documento' ,   
Comando= 'SELECT  NumeroDocumento  FROM @Nome_Banco_Dados.dbo.documentossisdoc' ,  Ordem_Apresentacao= 3 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 70 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ComplementoDocEmitido')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT p.nome  FROM @Nome_Banco_Dados.dbo.ComplementoDocEmitido cde   INNER JOIN @Nome_Banco_Dados.dbo.DocumentosSisdoc ds ON ds.IdDocumento = cde.IdDocumento '+ 
' INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = ds.IdProfissional' ,  Ordem_Apresentacao=  NULL ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 75 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Ocorrencias')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT p.nome  FROM @Nome_Banco_Dados.dbo.OCORRENCIAS Tr   INNER JOIN @Nome_Banco_Dados.dbo.DocumentosSisdoc ds ON ds.IdDocumento = Tr.IdPaiOcorrencia '+ 
'  INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = ds.IdProfissional' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 78 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Ocorrencias')  ,  Nome_Campo_Cabecalho= 'Nº Protocolo' ,   
Comando= 'SELECT ds.NumProtocolo  FROM dbo.OCORRENCIAS Tr   INNER JOIN @Nome_Banco_Dados.dbo.DocumentosSisdoc ds ON ds.IdDocumento = Tr.IdPaiOcorrencia   INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = ds.IdProfissional' , 
  Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 82 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes')  ,  Nome_Campo_Cabecalho= 'Registro' ,   
Comando= 'SELECT p.RegistroConselhoAtual  FROM @Nome_Banco_Dados.dbo.Tramitacoes Tr   INNER JOIN @Nome_Banco_Dados.dbo.DocumentosSisdoc ds ON ds.IdDocumento = Tr.IdDocumento '+  
' INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = ds.IdProfissional' ,  Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 83 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT p.Nome  FROM @Nome_Banco_Dados.dbo.Tramitacoes Tr   INNER JOIN @Nome_Banco_Dados.dbo.DocumentosSisdoc ds ON ds.IdDocumento = Tr.IdDocumento '+ 
' INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = ds.IdProfissional' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 85 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes')  ,  Nome_Campo_Cabecalho= 'Nº Protocolo' ,   
Comando= 'SELECT ds.NumProtocolo  FROM @Nome_Banco_Dados.dbo.Tramitacoes Tr   INNER JOIN @Nome_Banco_Dados.dbo.DocumentosSisdoc ds ON ds.IdDocumento = Tr.IdDocumento '+ 
'  INNER JOIN @Nome_Banco_Dados.dbo.Profissionais p ON p.IdProfissional = ds.IdProfissional' ,  Ordem_Apresentacao= 2 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)   
SELECT  Id_Cabecalho= 91 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PedidosCedulaIdentidadeProfissional')  ,  Nome_Campo_Cabecalho= 'Nome' ,   
Comando= 'SELECT   Nome= CASE    WHEN Pe.idprofissional IS NOT NULL THEN   (SELECT nome FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional = Pe.idprofissional)     END '+ 
' FROM @Nome_Banco_Dados.dbo.PedidosCedulaIdentidadeProfissional Pe' ,  Ordem_Apresentacao= 0 ,  Cabecalho_Exclusao= 0 
INSERT INTO #T_Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao)  
 SELECT  Id_Cabecalho= 92 ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PedidosCedulaIdentidadeProfissional')  ,  Nome_Campo_Cabecalho= 'Nº Registro' ,   
 Comando= 'SELECT   RegistroConselhoAtual= CASE    WHEN Pe.idprofissional IS NOT NULL THEN   (SELECT nome FROM @Nome_Banco_Dados.dbo.Profissionais p WHERE p.IdProfissional = Pe.idprofissional)     END '+ 
 ' FROM @Nome_Banco_Dados.dbo.PedidosCedulaIdentidadeProfissional Pe' ,  Ordem_Apresentacao= 1 ,  Cabecalho_Exclusao= 0 
 
DELETE FROM #T_Cabecalho_Tabela_Log WHERE Id_Tabela IS NULL 
 
UPDATE ImplantaLog.dbo.Cabecalho_Tabela_Log SET 
Id_Tabela=t2.Id_Tabela, 
Nome_Campo_Cabecalho=t2.Nome_Campo_Cabecalho, 
Comando=t2.Comando, 
Ordem_Apresentacao=t2.Ordem_Apresentacao, 
Cabecalho_Exclusao=t2.Cabecalho_Exclusao 
FROM #T_Cabecalho_Tabela_Log t1, 
     ImplantaLog.dbo.Cabecalho_Tabela_Log t2 
WHERE t1.Id_Cabecalho=t2.Id_Cabecalho 
 
-- Cabecalho_Tabela_Log OK 
SET IDENTITY_INSERT ImplantaLog.dbo.Cabecalho_Tabela_Log ON  
 
INSERT INTO ImplantaLog.dbo.Cabecalho_Tabela_Log (Id_Cabecalho,Id_Tabela,Nome_Campo_Cabecalho,Comando,Ordem_Apresentacao,Cabecalho_Exclusao) 
SELECT t1.Id_Cabecalho,t1.Id_Tabela,t1.Nome_Campo_Cabecalho,t1.Comando,t1.Ordem_Apresentacao,t1.Cabecalho_Exclusao 
FROM #T_Cabecalho_Tabela_Log t1 left join  ImplantaLog.dbo.Cabecalho_Tabela_Log t2 on t1.Id_Cabecalho=t2.Id_Cabecalho 
WHERE t2.Id_Cabecalho is null 
 
SET IDENTITY_INSERT ImplantaLog.dbo.Cabecalho_Tabela_Log OFF 
 
/* Esse SQL gera os inserts para a tabela #T_Tabela_Dominio_Campo_Log.Todas as vezes que desejar criar ou alterar um  
   novo dominio de campo esse SQL deve ser executado e o resultado dele substituirá os inserts abaixo.    
 
SELECT  
'INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa) ' + 
' SELECT ' +  
' Id_campo_Log= ' + '(SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = ' + CHAR(39) + (SELECT Nome_Campo FROM dbo.Campo_Log T2 WHERE T2.Id_Campo_Log=T1.Id_Campo_Log) + CHAR(39)  + ' AND Id_Tabela = '   
+ '(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = ' + CHAR(39) + (SELECT Tabela FROM ImplantaLog.dbo.Tabela_Log T2 WHERE T2.Id_Tabela= (SELECT Id_Tabela FROM dbo.Campo_Log T5   
                                                                                                                                                          WHERE T5.Id_Campo_Log= T1.Id_campo_Log)) + CHAR(39)  +')) ' + ' , ' + 
' Id_Tabela= ' + '(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = ' + CHAR(39) + (SELECT Tabela FROM dbo.Tabela_Log T2 WHERE T2.Id_Tabela=T1.Id_Tabela) + CHAR(39)  +') ' + ' , ' + 
+ CHAR(39) + ISNULL(Nome_Campo,'') + CHAR(39) + ' , ' + 
+ CHAR(39) + ISNULL(Nome_Campo_Pesquisa,'') + CHAR(39)  
FROM dbo.Tabela_Dominio_Campo_Log T1 
 
*/ 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ComplementoDocEmitido'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc')  , 'NumProtocolo' , 'IdDocumento' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdCursoEvento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventos')  , 'NomeCursoEvento' , 'IdCursoEvento' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdEspecialidade' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Especialidades')  , 'NomeEspecialidade' , 'IdEspecialidade' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdPessoa' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas')  , 'Nome' , 'IdPessoa' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdProfissional' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais')  , 'Nome' , 'IdProfissional' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdSituacaoCurso' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'SituacoesCurso')  , 'SituacaoCurso' , 'IdSituacaoCurso' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdMoeda' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Moedas')  , 'Moeda' , 'IdMoeda' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdPessoa' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas')  , 'Nome' , 'IdPessoa' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdPessoaJuridica' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas')  , 'Nome' , 'IdPessoaJuridica' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdProfissional' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais')  , 'Nome' , 'IdProfissional' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdSituacaoAtual' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'SituacoesDebito')  , 'SituacaoDebito' , 'IdSituacaoDebito' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTipoDebito' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TiposDebito')  , 'NomeDebito' , 'IdTipoDebito' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTipoPagamento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Debitos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TiposPagamentos')  , 'TipoPagamento' , 'IdTipoPagamento' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdMoedaDevida' AND Id_Tabela = 
 (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Moedas')  , 'Moeda' , 'IdMoeda' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDocumento1' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosRelacionados'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc')  , 'NumProtocolo' , 'IdDocumento' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'idFormaEntregaDocumento' AND Id_Tabela = 
 (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'FormaEntregaDocumento')  , 'DescricaoFormaEntregaDocumento' ,  
 'idFormaEntregaDocumento' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdSituacaoDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'SituacoesDocumento')  , 'SituacaoDocumento' , 'IdSituacaoDocumento' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTipoDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TiposDocumentos')  , 'TipoDocumento' , 'IdTipoDocumento' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdPais' AND Id_Tabela = 
 (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Nacionalidades')  , 'Pais' , 'IdNacionalidade' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdAreaAtuacao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'AreasAtuacao')  , 'AreaAtuacao' , 'IdAreaAtuacao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdAtividade' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Atividades')  , 'NomeAtividade' , 'IdAtividade' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdNatureza' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'NaturezasPJ')  , 'NaturezaPJ' , 'IdNaturezaPJ' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdPessoa' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas')  , 'Nome' , 'IdPessoa' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdPessoaJuridica' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas')  , 'Nome' , 'IdPessoaJuridica' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdProfissional' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais')  , 'Nome' , 'IdProfissional' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdSetorAtuacao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'SetoresAtuacao')  , 'SetorAtuacao' , 'IdSetorAtuacao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdVinculo' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ExperienciasProfissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'VinculosEmpregaticio')  , 'VinculoEmpregaticio' ,  
'IdVinculoEmpregaticio' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDetalheOcorrencia' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'OcorrenciasPFPJ'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesOcorrenciasSiscafw')  , 'DetalheOcorrencia' , 'IdDetalheOcorrencia' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdOcorrencia' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'OcorrenciasPFPJ'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'OcorrenciasSiscafw')  , 'Ocorrencia' , 'IdOcorrencia' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdSituacaoOcorrencia' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'OcorrenciasPFPJ_SituacoesOcorrencia'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'SituacoesOcorrencia')  , 'SituacaoOcorrencia' ,  
'IdSituacaoOcorrencia' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdFaixaCapital' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'FaixasCapitalPJ')  , 'NomeFaixa' , 'IdFaixaCapital' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdNatureza' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'NaturezasPJ')  , 'NaturezaPJ' , 'IdNaturezaPJ' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTipoInscricao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TiposInscricao')  , 'TipoInscricao' , 'IdTipoInscricao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdCategoriaPJ' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_CategoriaPJ'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CategoriasPJ')  , 'NomeCategoriaPJ' , 'IdCategoriaPJ' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdMotivoInscricao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_CategoriaPJ'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'MotivoInscricao')  , 'MotivoInscricao' , 'IdMotivoInscricao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTipoInscricao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_CategoriaPJ'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TiposInscricao')  , 'TipoInscricao' , 'IdTipoInscricao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDetalheSituacao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_SituacoesPFPJ'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesSituacao')  , 'Detalhe' , 'IdDetalheSituacao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdSituacaoPFPJ' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas_SituacoesPFPJ'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'SituacoesPFPJ')  , 'NomeSituacao' , 'IdSituacaoPFPJ' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdCidade1' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Cidades')  , 'NomeCidade' , 'IdCidade' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdCidade2' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Cidades')  , 'NomeCidade' , 'IdCidade' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdEtapa' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Etapas')  , 'NomeEtapa' , 'IdEtapa' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela1PJ' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas')  , 'Nome' , 'IdPessoaJuridica' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela1Proc' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ProcessosTabela1')  , 'Descricao' , 'IdTabela1Proc' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela1Prof' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais')  , 'Nome' , 'IdProfissional' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela2PJ' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas')  , 'Nome' , 'IdPessoaJuridica' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela2Proc' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ProcessosTabela2')  , 'Descricao' , 'IdTabela2Proc' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela2Prof' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais')  , 'Nome' , 'IdProfissional' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela3PJ' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas')  , 'Nome' , 'IdPessoaJuridica' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela3Proc' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ProcessosTabela3')  , 'Descricao' , 'IdTabela3Proc' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela3Prof' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais')  , 'Nome' , 'IdProfissional' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela4Proc' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ProcessosTabela4')  , 'Descricao' , 'IdTabela4Proc' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTabela5Proc' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'ProcessosTabela5')  , 'Descricao' , 'IdTabela5Proc' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IDTIPOPROCESSO' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Processos'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TipoProcesso')  , 'ProcessoTipo' , 'IdTipoProcesso' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdPaisEndereco' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Nacionalidades')  , 'Pais' , 'IdNacionalidade' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTipoInscricao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TiposInscricao')  , 'TipoInscricao' , 'IdTipoInscricao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdProfissionalCategoriaProf' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_CategoriasProf'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CategoriasProf')  , 'NomeCategoriaProf' , 'IdCategoriaProf' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTipoInscricao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_CategoriasProf'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TiposInscricao')  , 'TipoInscricao' , 'IdTipoInscricao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDetalheSituacao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_SituacoesPF'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesSituacao')  , 'Detalhe' , 'IdDetalheSituacao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdSituacaoPFPJ' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais_SituacoesPF'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'SituacoesPFPJ')  , 'NomeSituacao' , 'IdSituacaoPFPJ' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdTipoProcesso' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TelasDefinicoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'TipoProcesso')  , 'ProcessoTipo' , 'IdTipoProcesso' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDepartamento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Departamentos')  , 'NomeDepto' , 'IdDepto' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDepartamentoCriacao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Departamentos')  , 'NomeDepto' , 'IdDepto' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDepartamentoRecebeu' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Departamentos')  , 'NomeDepto' , 'IdDepto' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DocumentosSisdoc')  , 'NumeroDocumento' , 'IdDocumento' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdSituacaoTramitacao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'SituacoesTramitacao')  , 'SituacaoTramitacao' , 'IdSituacaoTramitacao' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdUsuario' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Usuarios')  , 'NomeUsuario' , 'IdUsuario' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdUsuarioCriacao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Usuarios')  , 'NomeUsuario' , 'IdUsuario' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'IdUsuarioRecebeu' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Usuarios')  , 'NomeUsuario' , 'IdUsuario' 
INSERT INTO #T_Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'CodigoStatusPedidoAtual' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PedidosCedulaIdentidadeProfissional'))  ,  Id_Tabela= (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PedidosCedulaStatus')  , 'StatusPedido' , 'CodigoStatusPedido' 
 
 DELETE FROM  #T_Tabela_Dominio_Campo_Log 
 WHERE  Id_Tabela IS NULL 
 
UPDATE ImplantaLog.dbo.Tabela_Dominio_Campo_Log SET 
Id_Tabela=t2.Id_Tabela, 
Nome_Campo=t2.Nome_Campo, 
Nome_Campo_Pesquisa=t2.Nome_Campo_Pesquisa 
FROM #T_Tabela_Dominio_Campo_Log t1, 
     ImplantaLog.dbo.Tabela_Dominio_Campo_Log t2 
WHERE t1.Id_campo_Log=t2.Id_campo_Log  
 
-- Cabecalho_Tabela_Log OK 
 
INSERT INTO ImplantaLog.dbo.Tabela_Dominio_Campo_Log (Id_campo_Log,Id_Tabela,Nome_Campo,Nome_Campo_Pesquisa) 
SELECT DISTINCT t1.Id_campo_Log,t1.Id_Tabela,t1.Nome_Campo,t1.Nome_Campo_Pesquisa 
FROM #T_Tabela_Dominio_Campo_Log t1 left join  ImplantaLog.dbo.Tabela_Dominio_Campo_Log t2 on t1.Id_campo_Log=t2.Id_campo_Log  
WHERE t2.Id_campo_Log is null and t1.Id_campo_Log is not null and t1.Id_Tabela is not null 
 
/* 
   Esse SQL gera os inserts para a tabela #T_Campo_Log.Todas as vezes que desejar alterar as informações  
    dos campo esse SQL deve ser executado e o resultado dele substituirá os inserts abaixo.  
    
SELECT  
'INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES (' + 
CHAR(39) + Nome_Campo + CHAR(39) + ',' + 
CHAR(39) + t2.Tabela + CHAR(39) + ',' +  
CASE WHEN Nome_Titulo IS NULL THEN 'NULL' ELSE CHAR(39) + Nome_Titulo + CHAR(39) END + ',' +  
CASE WHEN IdTipoDominio IS NULL THEN 'NULL' ELSE CONVERT(VARCHAR(10),IdTipoDominio) END + ',' +   
CASE WHEN ApresentaCampo IS NULL THEN 'NULL' ELSE CHAR(39) + ApresentaCampo + CHAR(39) END + ',' +   
CASE WHEN ApresentaCampoExclusao IS NULL THEN 'NULL' ELSE  CHAR(39) + ApresentaCampoExclusao + CHAR(39) END + ')'    
FROM ImplantaLog.dbo.Campo_Log t1, 
     ImplantaLog.dbo.Tabela_Log t2 
WHERE t1.Id_Tabela=t2.Id_Tabela and  
       t2.Tabela IS NOT NULL AND 
       t1. Nome_Campo IS NOT NULL AND 
      (Nome_Titulo IS NOT NULL OR 
      IdTipoDominio IS NOT NULL OR 
      ApresentaCampo IS NOT NULL OR 
      ApresentaCampoExclusao IS NOT NULL) 
*/ 
 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdContaBensImoveis','ConfiguracoesSG','IdContaBensImoveis',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdContaBensMoveis','ConfiguracoesSG','IdContaBensMoveis',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataColacaoGrau','CursosEventosRealizado','Data Colação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataConclusao','CursosEventosRealizado','Data Conclusão',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataExpedicaoDocumento','CursosEventosRealizado','Dt Exp. Diploma',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Duracao','CursosEventosRealizado','Duração',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdCursoEvento','CursosEventosRealizado','Curso',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEspecialidade','CursosEventosRealizado','Especialização',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoa','CursosEventosRealizado','Nome Pessoas',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','CursosEventosRealizado','Nome Profissional',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoCurso','CursosEventosRealizado','Situação Curso',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TipoDocumento','CursosEventosRealizado','Tipo Documento',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Acrescimos','Debitos','Acréscimos',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataAtualizacao','Debitos','Data Atualização',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataCredito','Debitos','Data Crédito',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataDeposito','Debitos','Data Depósito',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataGeracao','Debitos','Data Geração',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataPgto','Debitos','Data Pagamento',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataReferencia','Debitos','Data Referência',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataVencimento','Debitos','Data Vencimento',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Emitido','Debitos','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('GeracaoColetiva','Debitos','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDebito','Debitos','',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdMoeda','Debitos','Moeda',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoa','Debitos','Nome Pessoa',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridica','Debitos','Nome Pessoa Jurídica',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','Debitos','Nome Profissional',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoAtual','Debitos','Situação Débito',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoDebito','Debitos','Tipo Débito',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoPagamento','Debitos','Tipo Pagamento',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumero','Debitos','NossoNumero',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjEmissao','Debitos','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjReneg','Debitos','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjTpDebito','Debitos','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumeroParcela','Debitos','Nº Parcela',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TpCompDespesas','Debitos','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorDevido','Debitos','Valor Devido',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorPago','Debitos','Valor Pago',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataAtualizacaoEncargos','DetalhesEmissao','Dt Atual. Encargos',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataEmissao','DetalhesEmissao','Data Emissão',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataVencimento','DetalhesEmissao','Data Vencimento',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdMoedaDevida','DetalhesEmissao','Moeda',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumero','DetalhesEmissao','Nosso Número',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SeuNumero','DetalhesEmissao','Seu Número',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TipoComposicao','DetalhesEmissao','',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorDespAdv','DetalhesEmissao','Valor Desp. Advocatícias',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorDespBco','DetalhesEmissao','Valor Desp. Bancárias',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorDespPostais','DetalhesEmissao','Valor Desp. Postais',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorEmissao','DetalhesEmissao','Valor Emissão',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumAutoInfracao','DividaAtiva','UtilizadoEmApreciacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Nome','Emissoes','Nome',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RegistroConselho','Emissoes','Nº Registro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Atualizado','Enderecos','Atualizado',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CaixaPostal','Enderecos','Caixa Postal',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CEP','Enderecos','CEP',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Correspondencia','Enderecos','Correspondência',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Exterior','Enderecos','É Exterior',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Residencial','Enderecos','Residencial',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Endereco','Enderecos','Endereço',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEndereco','Enderecos','',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPais','Enderecos','País',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoa','Enderecos','Id Pessoa',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridica','Enderecos','Id Pessoa Jurídica',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','Enderecos','Id Profissional',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MalaDireta','Enderecos','Mala direta',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeBairro','Enderecos','Bairro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeCidade','Enderecos','Cidade',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Numero','Enderecos','Número',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SiglaUf','Enderecos','UF',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CargaHorariaSemanal','ExperienciasProfissionais','Carga Horária',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataAdmissao','ExperienciasProfissionais','Data Admissão',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataAtualizacao','ExperienciasProfissionais','Data Atualização',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataDemissao','ExperienciasProfissionais','Data Demissão',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdAreaAtuacao','ExperienciasProfissionais','Área Atuação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdAtividade','ExperienciasProfissionais','Atividade',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdNatureza','ExperienciasProfissionais','Natureza',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoa','ExperienciasProfissionais','Nome Pessoas',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridica','ExperienciasProfissionais','Nome Pessoa Jurídica',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','ExperienciasProfissionais','Nome Profissional',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSetorAtuacao','ExperienciasProfissionais','Setor Atuação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdVinculo','ExperienciasProfissionais','Vínculo Empr.',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataOcorrencia','Ocorrencias','Data Criação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDepartamentoCriacao','Ocorrencias','Departamento Criação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CPF','OcorrenciasPFPJ','CPF',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataFimOcorrencia','OcorrenciasPFPJ','Data Fim',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataOcorrencia','OcorrenciasPFPJ','Data Ocorrência',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Documento','OcorrenciasPFPJ','Documento',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDetalheOcorrencia','OcorrenciasPFPJ','Detalhe Ocorrência',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdOcorrencia','OcorrenciasPFPJ','Ocorrência',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdOcorrenciaPFPJ','OcorrenciasPFPJ','',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Protocolo','OcorrenciasPFPJ','Protocolo',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataRegistroSituacao','OcorrenciasPFPJ_SituacoesOcorrencia','Data Registro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataSituacao','OcorrenciasPFPJ_SituacoesOcorrencia','Data',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoOcorrencia','OcorrenciasPFPJ_SituacoesOcorrencia','Situação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Ocorrencia','OcorrenciasSiscafw','Ocorrência',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Ativo','Pessoas','Ativo',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataUltimaAtualizacaoEnd','Pessoas','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DeptoUltimaAtualizacaoEnd','Pessoas','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_InstituicaoEnsino','Pessoas','É inst. de ensino',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_PessoaJuridica','Pessoas','Tipo Pessoa',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Email','Pessoas','E-mail',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Email2','Pessoas','E-mail 2',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Endereco','Pessoas','Endereço',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Nome','Pessoas','Nome',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeBairro','Pessoas','Bairro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeCidade','Pessoas','Cidade',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SiglaUF','Pessoas','UF',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UsuarioUltimaAtualizacaoEnd','Pessoas','',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CaixaPostal','PessoasJuridicas','Caixa Postal',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CategoriaAtual','PessoasJuridicas','Categoria Atual',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CEP','PessoasJuridicas','CEP',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CNPJ','PessoasJuridicas','CNPJ',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataFundacao','PessoasJuridicas','Data Fundação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataInscricao','PessoasJuridicas','Data Inscrição',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EMail','PessoasJuridicas','E-mail',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Endereco','PessoasJuridicas','Endereço',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdFaixaCapital','PessoasJuridicas','Faixa Capital',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdNatureza','PessoasJuridicas','Natureza',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoInscricao','PessoasJuridicas','Tipo Inscrição',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NIRE','PessoasJuridicas','NIRE',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Nome','PessoasJuridicas','Nome',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeBairro','PessoasJuridicas','Bairro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeCidade','PessoasJuridicas','Cidade',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeFantasia','PessoasJuridicas','Nome Fantasia',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Processo','PessoasJuridicas','Processo',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RegistroConselhoAtual','PessoasJuridicas','Nº Registro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Sigla','PessoasJuridicas','Sigla',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SiglaUf','PessoasJuridicas','UF',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Site','PessoasJuridicas','Site',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SituacaoAtual','PessoasJuridicas','Situação Atual',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Telefone','PessoasJuridicas','Telefone',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TelefoneCelular','PessoasJuridicas','Tel Celular',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TelefoneOutros','PessoasJuridicas','Tel Outros',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataFim','PessoasJuridicas_CategoriaPJ','Data Fim',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataInicio','PessoasJuridicas_CategoriaPJ','Data Início',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdCategoriaPJ','PessoasJuridicas_CategoriaPJ','Categoria',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdMotivoInscricao','PessoasJuridicas_CategoriaPJ','Motivo Inscrição',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoInscricao','PessoasJuridicas_CategoriaPJ','Tipo Inscrição',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDetalheSituacao','PessoasJuridicas_SituacoesPFPJ','Detalhe Situação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoPFPJ','PessoasJuridicas_SituacoesPFPJ','Situação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataFase','Processo_Fases','Data Fase',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataFim','Processo_Fases','Data Fim',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataInicio','Processo_Fases','Data Inicio',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataRef','Processo_Fases','Data Referência',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MotivoAndamento','Processo_Fases','Motivo Andamento',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumeroPlenaria','Processo_Fases','Nº Plenária',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa10Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa1Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa2Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa3Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa4Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa5Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa6Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa7Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa8Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Alfa9Proc','Processos','Campo dinâmico',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataAutuacao','Processos','Data Autuação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataCadastro','Processos','Data Cadastro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdCidade1','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdCidade2','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDepartamentoCriacao','Processos','Departamento',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEtapa','Processos','Etapa',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela1PJ','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela1Proc','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela1Prof','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela2PJ','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela2Proc','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela2Prof','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela3PJ','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela3Proc','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela3Prof','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela4Proc','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela5Proc','Processos','Campo dinâmico',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IDTIPOPROCESSO','Processos','Tipo Processo',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Volumes','Processos','Volumes',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CategoriaAtual','Profissionais','Categoria',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CEP','Profissionais','CEP',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Classe','Profissionais','Classe',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodigoBarras','Profissionais',NULL,1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CPF','Profissionais','CPF',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CTPS','Profissionais','CTPS',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataInscricaoConselho','Profissionais','Data Inscrição Conselho',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataNascimento','Profissionais','Data Nascimento',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Exterior','Profissionais','Exterior?',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Fiscal','Profissionais','É Fiscal?',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Residencial','Profissionais','É Residencial',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Email2Divulgacao','Profissionais','',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EmailDivulgacao','Profissionais','',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Endereco','Profissionais','Endereço',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EnderecoEMail','Profissionais','E-mail',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EnderecoEMail2','Profissionais','E-mail 2',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EstadoCivil','Profissionais','Estado civil',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPaisEndereco','Profissionais','País',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','Profissionais','Id Profissional',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoInscricao','Profissionais','Tipo Inscrição',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUnidadeConselho','Profissionais',NULL,1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Nome','Profissionais','Nome',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeBairro','Profissionais','Bairro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeCidade','Profissionais','Cidade',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeConjuge','Profissionais','Nome Cônjuge',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeMae','Profissionais','Nome Mãe',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomePai','Profissionais','Nome Pai',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeSocial','Profissionais','Nome Social',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Processo','Profissionais','Processo',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Raca','Profissionais','Raça',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RegistroConselhoAtual','Profissionais','Nº Registro',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RG','Profissionais','RG',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RGDataEmissao','Profissionais','Emissão RG',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RGOrgaoEmissao','Profissionais','Orgão Emissor RG',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RNE','Profissionais','RNE',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Sexo','Profissionais','Sexo',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SiglaUF','Profissionais','UF',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SiglaUFNaturalidade','Profissionais','UF Naturalidade',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Site','Profissionais','Site',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Site2','Profissionais','Site 2',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SituacaoAtual','Profissionais','Situação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TelefoneCelular','Profissionais','Tel Celular',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TelefoneOutros','Profissionais','Tel. Outros',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TelefoneResid','Profissionais','Tel Residencial',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TelefoneTrab','Profissionais','Tel trabalho',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TelefoneTrabCelular','Profissionais','IdTabela6Prof',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissionalCategoriaProf','Profissionais_CategoriasProf','Categoria',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoInscricao','Profissionais_CategoriasProf','Tipo Inscrição',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataFimSituacao','Profissionais_SituacoesPF','Data Fim',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataInicioSituacao','Profissionais_SituacoesPF','Data Início',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataValidade','Profissionais_SituacoesPF','Data Validade',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDetalheSituacao','Profissionais_SituacoesPF','Detalhe Situação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoPFPJ','Profissionais_SituacoesPF','Situação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SituacaoOcorrencia','SituacoesOcorrencia','Situação Ocorr.',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeSituacao','SituacoesPFPJ','Situação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValidadeSituacao','SituacoesPFPJ','Validade Situação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','TelasDefinicoes','',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataEntrada','Tramitacoes','Data Entrada',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataEnvio','Tramitacoes','Data Envio',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataLeitura','Tramitacoes','Data Leitura',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataPrevisao','Tramitacoes','Data Previsão',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataSaida','Tramitacoes','Data Saída',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDepartamento','Tramitacoes','Departamento',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDepartamentoCriacao','Tramitacoes','Depto Criação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDepartamentoRecebeu','Tramitacoes','Depto Recebeu',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoTramitacao','Tramitacoes','Situação Tramitação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuario','Tramitacoes','Usuário',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuarioCriacao','Tramitacoes','Usuário Criação',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuarioRecebeu','Tramitacoes','Usuário Recebimento',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumeProcExterno','Tramitacoes','Nº Processo Externo',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Recebido','Tramitacoes','Recebeu?',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TramitacaoLote','Tramitacoes','Tramitação em Lote?',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataContabilizacaoAL','ConfiguracoesAnuaisSipro','DataContabilizacaoAL',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataContabilizacaoPAT','ConfiguracoesAnuaisSipro','DataContabilizacaoPAT',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdItemAnalisado','Anb_Correcao_Execucao','IdItemAnalisado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdResultadoAnalise','Anb_Correcao_Execucao','IdResultadoAnalise',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdAnexo','Anexos','IdAnexo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEmail_Solicitacao','Anexos','IdEmail_Solicitacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeAnexo','Anexos','NomeAnexo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CEP','ArquivoEmitido','CEP',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Cidade','ArquivoEmitido','Cidade',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Endereco','ArquivoEmitido','Endereco',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdArquivoEmitido','ArquivoEmitido','IdArquivoEmitido',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Moeda','ArquivoEmitido','Moeda',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Nome','ArquivoEmitido','Nome',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumero','ArquivoEmitido','NossoNumero',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Parcela','ArquivoEmitido','Parcela',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Registro','ArquivoEmitido','Registro',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UF','ArquivoEmitido','UF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Valor','ArquivoEmitido','Valor',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Vencimento','ArquivoEmitido','Vencimento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataAtualizacao','AtualizacaoRecobrancaTemp','DataAtualizacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataReferencia','AtualizacaoRecobrancaTemp','DataReferencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdAtualizacaoRecobrancaTemp','AtualizacaoRecobrancaTemp','IdAtualizacaoRecobrancaTemp',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeUsuario','AtualizacaoRecobrancaTemp','NomeUsuario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Serie','AutosInfracao','Serie',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CpfCnpj','Cheques','CpfCnpj',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjComposicao','Cheques','NumConjComposicao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodAgencia','ComposicoesDebito','CodAgencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodBanco','ComposicoesDebito','CodBanco',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodCC_Conv_Ced','ComposicoesDebito','CodCC_Conv_Ced',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodOperacao','ComposicoesDebito','CodOperacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataContabilizacao','ComposicoesDebito','DataContabilizacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataCredito','ComposicoesDebito','DataCredito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataDeposito','ComposicoesDebito','DataDeposito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataMovimento','ComposicoesDebito','DataMovimento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataPgto','ComposicoesDebito','DataPgto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DocumentoPgto','ComposicoesDebito','DocumentoPgto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdArquivoPagamento','ComposicoesDebito','IdArquivoPagamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdComposicaoEmissao','ComposicoesDebito','IdComposicaoEmissao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDebitoOld','ComposicoesDebito','IdDebitoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDebitoOrigemRenOld','ComposicoesDebito','IdDebitoOrigemRenOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEntidadeOld','ComposicoesDebito','IdEntidadeOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdInscricaoOld','ComposicoesDebito','IdInscricaoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoDebito','ComposicoesDebito','IdSituacaoDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoPagamento','ComposicoesDebito','IdTipoPagamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumero','ComposicoesDebito','NossoNumero',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjComposicao','ComposicoesDebito','NumConjComposicao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PercentualRepasse','ComposicoesDebito','PercentualRepasse',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PercentualRepasseOld','ComposicoesDebito','PercentualRepasseOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TipoDividaAtiva','ComposicoesDebito','TipoDividaAtiva',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorDescontoConcedido','ComposicoesDebito','ValorDescontoConcedido',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorLiquido','ComposicoesDebito','ValorLiquido',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorPago','ComposicoesDebito','ValorPago',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AtualizacaoWeb','ComposicoesEmissao','AtualizacaoWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdConfigSituacaoPadrao','ConfigSituacaoPadrao','IdConfigSituacaoPadrao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDepartamento','ConfigSituacaoPadrao','IdDepartamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdConfigSituacaoPadrao','ConfigSituacaoPadraoDepartamento','IdConfigSituacaoPadrao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdConfigSituacaoPadraoDepartamento','ConfigSituacaoPadraoDepartamento','IdConfigSituacaoPadraoDepartamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoDebito','ConfigSituacaoPadraoDepartamento','IdSituacaoDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TravamentoCCustoAnulacao','Configuracoes','TravamentoCCustoAnulacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TravamentoCCustoEmpenho','Configuracoes','TravamentoCCustoEmpenho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TravamentoCCustoPreEmpenho','Configuracoes','TravamentoCCustoPreEmpenho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TravamentoCCustoPrestacaoConta','Configuracoes','TravamentoCCustoPrestacaoConta',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TravamentoCCustoRestosAnulacao','Configuracoes','TravamentoCCustoRestosAnulacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TravamentoCCustoRestosEmpenho','Configuracoes','TravamentoCCustoRestosEmpenho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TravamentoCCustoRestosPagamento','Configuracoes','TravamentoCCustoRestosPagamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Id','ControleAcessoSiscafweb','Id',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuario','ControleAcessoSiscafweb','IdUsuario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgTelaBloqueada','ControleAcessoSiscafweb','MsgTelaBloqueada',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeCampo','ControleAcessoSiscafweb','NomeCampo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeTela','ControleAcessoSiscafweb','NomeTela',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ObrigatorioExistirRegistro','ControleAcessoSiscafweb','ObrigatorioExistirRegistro',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PermissaoCampos','ControleAcessoSiscafweb','PermissaoCampos',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Visivel','ControleAcessoSiscafweb','Visivel',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Id','ControleAcessoSiscafwebbkp','Id',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuario','ControleAcessoSiscafwebbkp','IdUsuario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgTelaBloqueada','ControleAcessoSiscafwebbkp','MsgTelaBloqueada',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeTela','ControleAcessoSiscafwebbkp','NomeTela',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ObrigatorioExistirRegistro','ControleAcessoSiscafwebbkp','ObrigatorioExistirRegistro',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PermissaoCampos','ControleAcessoSiscafwebbkp','PermissaoCampos',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Visivel','ControleAcessoSiscafwebbkp','Visivel',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdCursoEventoOld','CursosEventos','IdCursoEventoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IndCriacaoWeb','CursosEventos','IndCriacaoWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Agencia','DadosArquivo','Agencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ContaCorrente','DadosArquivo','ContaCorrente',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Convenio','DadosArquivo','Convenio',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataCredito','DadosArquivo','DataCredito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataPagamento','DadosArquivo','DataPagamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DvAgencia','DadosArquivo','DvAgencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDadosArquivo','DadosArquivo','IdDadosArquivo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeArquivo','DadosArquivo','NomeArquivo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumero','DadosArquivo','NossoNumero',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumeroAtual','DadosArquivo','NossoNumeroAtual',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TipoPessoa','DadosArquivo','TipoPessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorBruto','DadosArquivo','ValorBruto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorLiquido','DadosArquivo','ValorLiquido',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataHistorico','DadosHistorico','DataHistorico',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Historico','DadosHistorico','Historico',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDadosHistorico','DadosHistorico','IdDadosHistorico',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdRef','DadosHistorico','IdRef',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoHistorico','DadosHistorico','IdTipoHistorico',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuario','DadosHistorico','IdUsuario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idDetalheSituacao','DadosPFPJ','idDetalheSituacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDebito','DEBAVERIFICAR','IdDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumero','DEBAVERIFICAR','NossoNumero',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorDevido','DEBAVERIFICAR','ValorDevido',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorPago','DEBAVERIFICAR','ValorPago',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AtualizacaoWeb','Debitos','AtualizacaoWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDocumento','Debitos','IdDocumento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEntidadeOld','Debitos','IdEntidadeOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdInscricaoOld','Debitos','IdInscricaoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MultEmissao','Debitos','MultEmissao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PercentualRepasseOld','Debitos','PercentualRepasseOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorLiquido','Debitos','ValorLiquido',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AtualizacaoWeb','DetalhesEmissao','AtualizacaoWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('GeraRegistro','DetalhesSituacao','GeraRegistro',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idCategoriaPJ','DetalhesSituacao','idCategoriaPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idCategoriaProf','DetalhesSituacao','idCategoriaProf',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoPFPJ','DetalhesSituacao','IdSituacaoPFPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idTipoInscricao','DetalhesSituacao','idTipoInscricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UtilizadoEmApreciacao','DetalhesSituacao','UtilizadoEmApreciacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Desativado','Diligencias','Desativado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','Diligencias','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDiligencia','Diligencias','IdDiligencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','Diligencias','IdTipoProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdCodigoOld','DividaAtiva','IdCodigoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumProcExterno','DividaAtiva','NumProcExterno',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDocumentoOld','DocumentosSisdoc','IdDocumentoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CampoJoin','DominiosSiscafwProcessos','CampoJoin',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Ativo','Emails_Contas','Ativo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','Emails_Contas','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEmail_Conta','Emails_Contas','IdEmail_Conta',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ImapHost','Emails_Contas','ImapHost',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ImapPassword','Emails_Contas','ImapPassword',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ImapPorta','Emails_Contas','ImapPorta',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ImapUser','Emails_Contas','ImapUser',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SMTP_SSL_TLS','Emails_Contas','SMTP_SSL_TLS',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SMTPHost','Emails_Contas','SMTPHost',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SMTPPassword','Emails_Contas','SMTPPassword',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SMTPPorta','Emails_Contas','SMTPPorta',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SMTPUser','Emails_Contas','SMTPUser',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SSL_TLS','Emails_Contas','SSL_TLS',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Assunto','Emails_Solicitacoes','Assunto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Cc','Emails_Solicitacoes','Cc',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Cco','Emails_Solicitacoes','Cco',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ComputRemetente','Emails_Solicitacoes','ComputRemetente',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Data','Emails_Solicitacoes','Data',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataPrevista','Emails_Solicitacoes','DataPrevista',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Destinatario','Emails_Solicitacoes','Destinatario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Enviado','Emails_Solicitacoes','Enviado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEmail_Conta','Emails_Solicitacoes','IdEmail_Conta',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEmail_Solicitacao','Emails_Solicitacoes','IdEmail_Solicitacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuarioEnvio','Emails_Solicitacoes','IdUsuarioEnvio',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('LerComoHTML','Emails_Solicitacoes','LerComoHTML',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Marcador','Emails_Solicitacoes','Marcador',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Rascunho','Emails_Solicitacoes','Rascunho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Remetente','Emails_Solicitacoes','Remetente',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Titulo','Emails_Solicitacoes','Titulo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('VersaoSistema','Emails_Solicitacoes','VersaoSistema',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEmail_Solicitacao','Emails_Solicitacoes_Processos','IdEmail_Solicitacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEmail_Solicitacao_Processo','Emails_Solicitacoes_Processos','IdEmail_Solicitacao_Processo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcesso','Emails_Solicitacoes_Processos','IdProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','EmailsMarcadores','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEmailMarcador','EmailsMarcadores','IdEmailMarcador',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AtualizacaoWeb','Emissoes','AtualizacaoWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Endereco1','Enderecos','Endereco1',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idTipoEndereco','Enderecos','idTipoEndereco',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SessaoWeb','Enderecos','SessaoWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IndCricacaoWeb','Especialidades','IndCricacaoWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','EtiquetasProcessos','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEtiquetaProcesso','EtiquetasProcessos','IdEtiquetaProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','EtiquetasProcessos','IdTipoProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdExperienciaProfissionalOld','ExperienciasProfissionais','IdExperienciaProfissionalOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UFAreaAtuacao','ExperienciasProfissionais','UFAreaAtuacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BloqueiaFiscalizacao','Fases','BloqueiaFiscalizacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EmiteCorrespondencia','Fases','EmiteCorrespondencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ExigePlenaria','Fases','ExigePlenaria',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('QtdDiasBloqueio','Fases','QtdDiasBloqueio',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataAcesso','HistoricoAcessoUsuarioWeb','DataAcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('HostAcesso','HistoricoAcessoUsuarioWeb','HostAcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdHistoricoAcesso','HistoricoAcessoUsuarioWeb','IdHistoricoAcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridicaWeb','HistoricoAcessoUsuarioWeb','IdPessoaJuridicaWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissionalWeb','HistoricoAcessoUsuarioWeb','IdProfissionalWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdRegional','HistoricoAcessoUsuarioWeb','IdRegional',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuarioWeb','HistoricoAcessoUsuarioWeb','IdUsuarioWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TipoPessoa','HistoricoAcessoUsuarioWeb','TipoPessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UsuarioWeb','HistoricoAcessoUsuarioWeb','UsuarioWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodCC_Conv_Ced','ImportacaoReceitasDespesas','CodCC_Conv_Ced',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataPagamento','ImportacaoReceitasDespesas','DataPagamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoPagamento','ImportacaoReceitasDespesas','IdTipoPagamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataUltimoAcesso','ModelosDocumento','DataUltimoAcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('InstrucaoImpressao','ModelosDocumento','InstrucaoImpressao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IndCriacaoWeb','NaturezasPJ','IndCriacaoWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Composicao','NossoNumeroProblematico','Composicao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Data','NossoNumeroProblematico','Data',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataVencimento','NossoNumeroProblematico','DataVencimento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdNossoNumeroProblematico','NossoNumeroProblematico','IdNossoNumeroProblematico',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Nome','NossoNumeroProblematico','Nome',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeArquivo','NossoNumeroProblematico','NomeArquivo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumero','NossoNumeroProblematico','NossoNumero',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Registro','NossoNumeroProblematico','Registro',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ExibirCadastroPFPJ','Ocorrencias','ExibirCadastroPFPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdOcorrenciaPFPJOld','OcorrenciasPFPJ','IdOcorrenciaPFPJOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Desativado','OcorrenciasSiscafw','Desativado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodAgencia','PagamentosEstornados','CodAgencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodBanco','PagamentosEstornados','CodBanco',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodCC_Conv_Ced','PagamentosEstornados','CodCC_Conv_Ced',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodOperacao','PagamentosEstornados','CodOperacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataCredito','PagamentosEstornados','DataCredito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataDeposito','PagamentosEstornados','DataDeposito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataEstorno','PagamentosEstornados','DataEstorno',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataPgto','PagamentosEstornados','DataPgto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Departamento','PagamentosEstornados','Departamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DocumentoPgto','PagamentosEstornados','DocumentoPgto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdArquivoPagamento','PagamentosEstornados','IdArquivoPagamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDebito','PagamentosEstornados','IdDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdMotivoEstorno','PagamentosEstornados','IdMotivoEstorno',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPagamentoEstornado','PagamentosEstornados','IdPagamentoEstornado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSituacaoDebito','PagamentosEstornados','IdSituacaoDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoPagamento','PagamentosEstornados','IdTipoPagamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NossoNumero','PagamentosEstornados','NossoNumero',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjComposicao','PagamentosEstornados','NumConjComposicao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PercentualRepasse','PagamentosEstornados','PercentualRepasse',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TipoDividaAtiva','PagamentosEstornados','TipoDividaAtiva',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Usuario','PagamentosEstornados','Usuario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorPago','PagamentosEstornados','ValorPago',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Acrescimo','ParametrosSiscafWeb','Acrescimo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AcrescimoVlrBoleto','ParametrosSiscafWeb','AcrescimoVlrBoleto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AplicarDescontoSobreValorDivida','ParametrosSiscafWeb','AplicarDescontoSobreValorDivida',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BBConvenioCobranca','ParametrosSiscafWeb','BBConvenioCobranca',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BBConvenioComercioEletronico','ParametrosSiscafWeb','BBConvenioComercioEletronico',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BBPagamentoEletronico','ParametrosSiscafWeb','BBPagamentoEletronico',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BBRefTran','ParametrosSiscafWeb','BBRefTran',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BloquearRenDA_PF','ParametrosSiscafWeb','BloquearRenDA_PF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BloquearRenDA_PJ','ParametrosSiscafWeb','BloquearRenDA_PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CamposComparacaoLoginPF','ParametrosSiscafWeb','CamposComparacaoLoginPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CamposComparacaoLoginPJ','ParametrosSiscafWeb','CamposComparacaoLoginPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CampoValidacaoLoginPf','ParametrosSiscafWeb','CampoValidacaoLoginPf',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CampoValidacaoLoginPj','ParametrosSiscafWeb','CampoValidacaoLoginPj',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ColunasCriterioPesquisaPF','ParametrosSiscafWeb','ColunasCriterioPesquisaPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ColunasCriterioPesquisaPJ','ParametrosSiscafWeb','ColunasCriterioPesquisaPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ComparaDados_CamposDisponiveis','ParametrosSiscafWeb','ComparaDados_CamposDisponiveis',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ComparaDados_CamposSelecionados','ParametrosSiscafWeb','ComparaDados_CamposSelecionados',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ConfigAtiva','ParametrosSiscafWeb','ConfigAtiva',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DescontoRenegociacao','ParametrosSiscafWeb','DescontoRenegociacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DescontoVlrBoleto','ParametrosSiscafWeb','DescontoVlrBoleto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DespAdv','ParametrosSiscafWeb','DespAdv',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DespBancarias','ParametrosSiscafWeb','DespBancarias',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DesprezarCampoNuloLoginPf','ParametrosSiscafWeb','DesprezarCampoNuloLoginPf',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DesprezarCampoNuloLoginPj','ParametrosSiscafWeb','DesprezarCampoNuloLoginPj',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DesprezarZeroEsquerdaRegPf','ParametrosSiscafWeb','DesprezarZeroEsquerdaRegPf',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DesprezarZeroEsquerdaRegPj','ParametrosSiscafWeb','DesprezarZeroEsquerdaRegPj',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Email','ParametrosSiscafWeb','Email',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ExibirAreaAtuacao','ParametrosSiscafWeb','ExibirAreaAtuacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ExibirCurso_Nivel','ParametrosSiscafWeb','ExibirCurso_Nivel',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ExibirDebitosPagos','ParametrosSiscafWeb','ExibirDebitosPagos',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ExibirEspecialidades','ParametrosSiscafWeb','ExibirEspecialidades',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('FimNossoNumBRB','ParametrosSiscafWeb','FimNossoNumBRB',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdConfigWeb','ParametrosSiscafWeb','IdConfigWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('InicioNossoNumBRB','ParametrosSiscafWeb','InicioNossoNumBRB',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MaxAreaAtuacao','ParametrosSiscafWeb','MaxAreaAtuacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MaxCurso_Nivel','ParametrosSiscafWeb','MaxCurso_Nivel',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MaxEspecialidedes','ParametrosSiscafWeb','MaxEspecialidedes',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgBloqueioRenDA_PF','ParametrosSiscafWeb','MsgBloqueioRenDA_PF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgBloqueioRenDA_PJ','ParametrosSiscafWeb','MsgBloqueioRenDA_PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgCamposComparacaoLoginPF','ParametrosSiscafWeb','MsgCamposComparacaoLoginPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgParaRegistroConselho','ParametrosSiscafWeb','MsgParaRegistroConselho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgParaRegistroConselhoPJ','ParametrosSiscafWeb','MsgParaRegistroConselhoPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgTelaLoginConselho','ParametrosSiscafWeb','MsgTelaLoginConselho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgTelaLoginDireto','ParametrosSiscafWeb','MsgTelaLoginDireto',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgTelaLoginPF','ParametrosSiscafWeb','MsgTelaLoginPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('MsgTelaLoginPJ','ParametrosSiscafWeb','MsgTelaLoginPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeConselho','ParametrosSiscafWeb','NomeConselho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('QtdDiasRenInicio','ParametrosSiscafWeb','QtdDiasRenInicio',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('QuantCampoNuloLoginPf','ParametrosSiscafWeb','QuantCampoNuloLoginPf',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('QuantCampoNuloLoginPj','ParametrosSiscafWeb','QuantCampoNuloLoginPj',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RenegociarAnoCorrente','ParametrosSiscafWeb','RenegociarAnoCorrente',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RenegociarAnoCorrenteMenor','ParametrosSiscafWeb','RenegociarAnoCorrenteMenor',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ResultadoPesquisa_Coluna1_PF','ParametrosSiscafWeb','ResultadoPesquisa_Coluna1_PF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ResultadoPesquisa_Coluna1_PJ','ParametrosSiscafWeb','ResultadoPesquisa_Coluna1_PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ResultadoPesquisa_Coluna2_PF','ParametrosSiscafWeb','ResultadoPesquisa_Coluna2_PF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ResultadoPesquisa_Coluna2_PJ','ParametrosSiscafWeb','ResultadoPesquisa_Coluna2_PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ResultadoPesquisa_Coluna3_PF','ParametrosSiscafWeb','ResultadoPesquisa_Coluna3_PF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ResultadoPesquisa_Coluna3_PJ','ParametrosSiscafWeb','ResultadoPesquisa_Coluna3_PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ResultadoPesquisa_Coluna4_PF','ParametrosSiscafWeb','ResultadoPesquisa_Coluna4_PF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ResultadoPesquisa_Coluna4_PJ','ParametrosSiscafWeb','ResultadoPesquisa_Coluna4_PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SequencialNossoNumeroBRB','ParametrosSiscafWeb','SequencialNossoNumeroBRB',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SequencialNumeroDocumento','ParametrosSiscafWeb','SequencialNumeroDocumento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('siglaConselho','ParametrosSiscafWeb','siglaConselho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TelaInicialPesquisa','ParametrosSiscafWeb','TelaInicialPesquisa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TiposDebitoRenegociacao','ParametrosSiscafWeb','TiposDebitoRenegociacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TpControleAcessoPF','ParametrosSiscafWeb','TpControleAcessoPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TpControleAcessoPJ','ParametrosSiscafWeb','TpControleAcessoPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('txtRodapeTelaResultadoPesquisa_PF','ParametrosSiscafWeb','txtRodapeTelaResultadoPesquisa_PF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('txtRodapeTelaResultadoPesquisa_PJ','ParametrosSiscafWeb','txtRodapeTelaResultadoPesquisa_PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('txtTelaPesquisaCompleta','ParametrosSiscafWeb','txtTelaPesquisaCompleta',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('txtTelaPesquisaPersonalizada','ParametrosSiscafWeb','txtTelaPesquisaPersonalizada',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UtilizarEnderecoTrabalho','ParametrosSiscafWeb','UtilizarEnderecoTrabalho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('visualizarDocumentos','ParametrosSiscafWeb','visualizarDocumentos',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPesquisaOld','Pesquisas','IdPesquisaOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdEntidadeOld','Pessoas','IdEntidadeOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdInscricaoOld','Pessoas','IdInscricaoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AlfaOutros5','PessoasJuridicas','AlfaOutros5',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Divulgacao','PessoasJuridicas','E_Divulgacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Exterior','PessoasJuridicas','E_Exterior',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Residencial','PessoasJuridicas','E_Residencial',3,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EMail2','PessoasJuridicas','EMail2',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridicaOld','PessoasJuridicas','IdPessoaJuridicaOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idTipoEndereco','PessoasJuridicas','idTipoEndereco',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Telefone2','PessoasJuridicas','Telefone2',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Tela','PreferenciasUsuario','Tela',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoa','ProcDepoimentosPartes','IdPessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridica','ProcDepoimentosPartes','IdPessoaJuridica',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcesso','ProcDepoimentosPartes','IdProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoDepoimentoParte','ProcDepoimentosPartes','IdProcessoDepoimentoParte',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','ProcDepoimentosPartes','IdProfissional',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoa','ProcDepoimentosTestemunhas','IdPessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridica','ProcDepoimentosTestemunhas','IdPessoaJuridica',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoDepoimentoParte','ProcDepoimentosTestemunhas','IdProcessoDepoimentoParte',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoDepoimentoTestemunha','ProcDepoimentosTestemunhas','IdProcessoDepoimentoTestemunha',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','ProcDepoimentosTestemunhas','IdProfissional',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataPlenaria','Processo_Fases','Data Plenaria',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('VisualizarNotaWeb','Processo_Fases','VisualizarNotaWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('VisualizarWeb','Processo_Fases','VisualizarWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Depoimentos','Processos','Depoimentos',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Diligencias','Processos','Diligencias',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela6Pessoa','Processos','IdTabela6Pessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela6PJ','Processos','IdTabela6PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela6Prof','Processos','IdTabela6Prof',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela7Pessoa','Processos','IdTabela7Pessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela7PJ','Processos','IdTabela7PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela7Prof','Processos','IdTabela7Prof',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela8Pessoa','Processos','IdTabela8Pessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela8PJ','Processos','IdTabela8PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela8Prof','Processos','IdTabela8Prof',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela9Pessoa','Processos','IdTabela9Pessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela9PJ','Processos','IdTabela9PJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTabela9Prof','Processos','IdTabela9Prof',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ProvaPericial','Processos','ProvaPericial',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ProvaPericialSolicitante','Processos','ProvaPericialSolicitante',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ProvasDocumentais','Processos','ProvasDocumentais',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SequencialFormatado','Processos','SequencialFormatado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SequencialNumero','Processos','SequencialNumero',1,'N','N') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataDiligencia','ProcessosDiligencias','DataDiligencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDiligencia','ProcessosDiligencias','IdDiligencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcesso','ProcessosDiligencias','IdProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoDiligencia','ProcessosDiligencias','IdProcessoDiligencia',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Notas','ProcessosDiligencias','Notas',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Desativado','ProcessosLista2','Desativado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','ProcessosLista2','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoLista2','ProcessosLista2','IdProcessoLista2',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','ProcessosLista2','IdTipoProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Desativado','ProcessosLista3','Desativado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','ProcessosLista3','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoLista3','ProcessosLista3','IdProcessoLista3',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','ProcessosLista3','IdTipoProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Desativado','ProcessosLista4','Desativado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','ProcessosLista4','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoLista4','ProcessosLista4','IdProcessoLista4',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','ProcessosLista4','IdTipoProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Desativado','ProcessosLista5','Desativado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','ProcessosLista5','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoLista5','ProcessosLista5','IdProcessoLista5',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','ProcessosLista5','IdTipoProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcesso','ProcessosProvasDocumentais','IdProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoProvaDocumental','ProcessosProvasDocumentais','IdProcessoProvaDocumental',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProvaDocumental','ProcessosProvasDocumentais','IdProvaDocumental',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('QuemFez','ProcessosProvasDocumentais','QuemFez',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Desativado','ProcessosProvasPericiais','Desativado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','ProcessosProvasPericiais','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoProvaPericial','ProcessosProvasPericiais','IdProcessoProvaPericial',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','ProcessosProvasPericiais','IdTipoProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcesso','ProcessosTiposProvas','IdProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoProvaPericial','ProcessosTiposProvas','IdProcessoProvaPericial',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProcessoTipoProva','ProcessosTiposProvas','IdProcessoTipoProva',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Divulgacao','Profissionais','E_Divulgacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IDEntidadeOld','Profissionais','IDEntidadeOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfOld','Profissionais','IdProfOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('suspenso','Profissionais','suspenso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataExpedicao','ProfissionaisPesquisaWeb','DataExpedicao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','ProfissionaisPesquisaWeb','IdProfissional',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissionalPesquisaWeb','ProfissionaisPesquisaWeb','IdProfissionalPesquisaWeb',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Nome','ProfissionaisPesquisaWeb','Nome',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeMae','ProfissionaisPesquisaWeb','NomeMae',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomePai','ProfissionaisPesquisaWeb','NomePai',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('RG','ProfissionaisPesquisaWeb','RG',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Desativado','ProvasDocumentais','Desativado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','ProvasDocumentais','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProvaDocumental','ProvasDocumentais','IdProvaDocumental',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoProcesso','ProvasDocumentais','IdTipoProcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdQuadroQuestoesOld','QuadrosQuestoes','IdQuadroQuestoesOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdQuestaoOld','Questoes','IdQuestaoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ContagemDevedores','RelatorioDevedoresGeracao','ContagemDevedores',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataGeracao','RelatorioDevedoresGeracao','DataGeracao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdRelatorio','RelatorioDevedoresGeracao','IdRelatorio',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Status','RelatorioDevedoresGeracao','Status',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ValorDevido','RelatorioDevedoresGeracao','ValorDevido',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataUltimoAcesso','Relatorios','DataUltimoAcesso',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DescArtigo','ResolucaoArtigos','DescArtigo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idCategoriaPFPJ','ResolucaoArtigos','idCategoriaPFPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdResolucaoArtigo','ResolucaoArtigos','IdResolucaoArtigo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Layout','ResolucaoArtigos','Layout',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('OrdemImpressao','ResolucaoArtigos','OrdemImpressao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TipoArtigo','ResolucaoArtigos','TipoArtigo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TipoPessoa','ResolucaoArtigos','TipoPessoa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UtilizaAgrupamento','ResolucaoArtigos','UtilizaAgrupamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UtilizaQuebraPorData','ResolucaoArtigos','UtilizaQuebraPorData',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idDetalheSituacao','ResolucaoArtigos_DetalhesSituacao','idDetalheSituacao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdResolucaoArtigo','ResolucaoArtigos_DetalhesSituacao','IdResolucaoArtigo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('OrdemImpressao','ResolucaoArtigos_DetalhesSituacao','OrdemImpressao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('TituloSubGrupo','ResolucaoArtigos_DetalhesSituacao','TituloSubGrupo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdRespostaPFPJOld','RespostasPFPJ','IdRespostaPFPJOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdRespostaPossivelOld','RespostasPossiveis','IdRespostaPossivelOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ExigeDetalhe','SituacoesPFPJ','ExigeDetalhe',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AliasNomeCampo','TelasCamposSiscafWeb','AliasNomeCampo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Id','TelasCamposSiscafWeb','Id',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Indice','TelasCamposSiscafWeb','Indice',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeCampo','TelasCamposSiscafWeb','NomeCampo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeTela','TelasCamposSiscafWeb','NomeTela',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AliasNomeCampo','TelasCamposSiscafWebNova','AliasNomeCampo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Id','TelasCamposSiscafWebNova','Id',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Indice','TelasCamposSiscafWebNova','Indice',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeCampo','TelasCamposSiscafWebNova','NomeCampo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NomeTela','TelasCamposSiscafWebNova','NomeTela',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Descricao','TipoEndereco','Descricao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idModulo','TipoEndereco','idModulo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('idTipoEndereco','TipoEndereco','idTipoEndereco',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SequencialPrefixo','TipoProcesso','SequencialPrefixo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('SequencialSufixo','TipoProcesso','SequencialSufixo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoDebitoOld','TiposDebito','IdTipoDebitoOld',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AceitaParcelamento','TiposPagamentos','AceitaParcelamento',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Cartao','TiposPagamentos','Cartao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('QtdParcelas','TiposPagamentos','QtdParcelas',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Ajustar','tmpDA','Ajustar',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Codigo','tmpDA','Codigo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Contador','tmpDA','Contador',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataBaseCalculo','tmpDA','DataBaseCalculo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataProcessoAdm','tmpDA','DataProcessoAdm',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridica','tmpDA','IdPessoaJuridica',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','tmpDA','IdProfissional',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumeroFormatado','tmpDA','NumeroFormatado',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Contator','tmpDetalhesDA','Contator',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Debito','tmpDetalhesDA','Debito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DividaAtiva','tmpDetalhesDA','DividaAtiva',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDebito','tmpDetalhesDA','IdDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Juros','tmpDetalhesDA','Juros',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Multa','tmpDetalhesDA','Multa',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Principal','tmpDetalhesDA','Principal',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Total','tmpDetalhesDA','Total',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('UnidadeMonetaria','tmpDetalhesDA','UnidadeMonetaria',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Valor','tmpDetalhesDA','Valor',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDebito','tmpDividaAtiva','IdDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','tmpDividaAtiva','IdProfissional',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjReneg','tmpDividaAtiva','NumConjReneg',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PF','tmpDividaAtiva','PF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BrutoNC','tmpResumo','BrutoNC',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BrutoPE','tmpResumo','BrutoPE',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BrutoPF','tmpResumo','BrutoPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('BrutoPJ','tmpResumo','BrutoPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ContaCorrente','tmpResumo','ContaCorrente',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Convenio','tmpResumo','Convenio',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataCredito','tmpResumo','DataCredito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DifeNC','tmpResumo','DifeNC',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DifePE','tmpResumo','DifePE',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DifePF','tmpResumo','DifePF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DifePJ','tmpResumo','DifePJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdResumo','tmpResumo','IdResumo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PagoNC','tmpResumo','PagoNC',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PagoPE','tmpResumo','PagoPE',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PagoPF','tmpResumo','PagoPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('PagoPJ','tmpResumo','PagoPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AcessarSomenteSubSecao','UsuariosSiscafWeb','AcessarSomenteSubSecao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('cpf','UsuariosSiscafWeb','cpf',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Conselho','UsuariosSiscafWeb','E_Conselho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Master','UsuariosSiscafWeb','E_Master',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('FuncoesDisponiveisPF','UsuariosSiscafWeb','FuncoesDisponiveisPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('FuncoesDisponiveisPJ','UsuariosSiscafWeb','FuncoesDisponiveisPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdNovidadeAtual','UsuariosSiscafWeb','IdNovidadeAtual',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSubSecao','UsuariosSiscafWeb','IdSubSecao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuario','UsuariosSiscafWeb','IdUsuario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('AcessarSomenteSubSecao','UsuariosSiscafwebbkp','AcessarSomenteSubSecao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('cpf','UsuariosSiscafwebbkp','cpf',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Conselho','UsuariosSiscafwebbkp','E_Conselho',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('E_Master','UsuariosSiscafwebbkp','E_Master',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('FuncoesDisponiveisPF','UsuariosSiscafwebbkp','FuncoesDisponiveisPF',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('FuncoesDisponiveisPJ','UsuariosSiscafwebbkp','FuncoesDisponiveisPJ',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdNovidadeAtual','UsuariosSiscafwebbkp','IdNovidadeAtual',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridica','UsuariosSiscafwebbkp','IdPessoaJuridica',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','UsuariosSiscafwebbkp','IdProfissional',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdSubSecao','UsuariosSiscafwebbkp','IdSubSecao',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdUsuario','UsuariosSiscafwebbkp','IdUsuario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Senha','UsuariosSiscafwebbkp','Senha',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Usuario','UsuariosSiscafwebbkp','Usuario',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ADMQTD','ValorReceber','ADMQTD',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('ADMValor','ValorReceber','ADMValor',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Ano','ValorReceber','Ano',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EXEQTD','ValorReceber','EXEQTD',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('EXEValor','ValorReceber','EXEValor',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Id','ValorReceber','Id',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdDebito','ValorReceber','IdDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdPessoaJuridica','ValorReceber','IdPessoaJuridica',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdProfissional','ValorReceber','IdProfissional',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('IdTipoDebito','ValorReceber','IdTipoDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NormalQTD','ValorReceber','NormalQTD',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NormalValor','ValorReceber','NormalValor',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjReneg','ValorReceber','NumConjReneg',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumConjTpDebito','ValorReceber','NumConjTpDebito',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumeroParcela','ValorReceber','NumeroParcela',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('Tipo','ValorReceber','Tipo',NULL,NULL,NULL) 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('CodigoStatusPedidoAtual','PedidosCedulaIdentidadeProfissional','Status pedido',2,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataEmissãoNotaFiscal','PedidosCedulaIdentidadeProfissional','Dt Emissão',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataSolicitacao','PedidosCedulaIdentidadeProfissional','Dt solicitação',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('DataStatusPedidoAtual','PedidosCedulaIdentidadeProfissional','Dt Status',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NotaFiscal','PedidosCedulaIdentidadeProfissional','Nota fiscal',1,'S','S') 
INSERT INTO #T_Campo_Log(Nome_Campo,Tabela,Nome_Titulo,IdTipoDominio,ApresentaCampo,ApresentaCampoExclusao) VALUES ('NumeroPedido','PedidosCedulaIdentidadeProfissional','Nº Pedido',1,'S','S') 
 
UPDATE ImplantaLog.dbo.Campo_Log SET 
Nome_Titulo=T2.Nome_Titulo, 
IdTipoDominio=T2.IdTipoDominio, 
ApresentaCampo=T2.ApresentaCampo, 
ApresentaCampoExclusao=T2.ApresentaCampoExclusao 
FROM ImplantaLog.dbo.Campo_Log T1,  
     #T_Campo_Log T2 
WHERE T1.Id_Campo_Log in (SELECT Id_Campo_Log FROM ImplantaLog.dbo.Campo_Log t3 WHERE t3.Nome_Campo collate Latin1_General_CI_AS  =t2.Nome_Campo collate Latin1_General_CI_AS ) and 
      t1.Id_Tabela in (SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log t4 WHERE t4.Tabela collate Latin1_General_CI_AS =t2.Tabela collate Latin1_General_CI_AS ) 
 
/* 
SELECT  
'INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao) ' + 
' SELECT ' +  
' Id_campo_Log= ' + '(SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = ' + CHAR(39) + (SELECT Nome_Campo FROM dbo.Campo_Log T3 WHERE T1.Id_Campo_Log=T3.Id_Campo_Log) + CHAR(39)  + ' 
 AND Id_Tabela = '  + '(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = ' + CHAR(39) + (SELECT Tabela FROM dbo.Tabela_Log T4 WHERE T4.Id_Tabela=T2.Id_Tabela) + CHAR(39)  +')) ' + ' , ' + 
CHAR(39) + ISNULL(Convert (varchar(50),Valor_Dominio),'') + CHAR(39) + ' , ' + 
CHAR(39) + ISNULL(Descricao,'') + CHAR(39)  
FROM Dominio_Campo_Log T1, 
     dbo.Campo_Log T2 
WHERE T1.Id_Campo_Log=T2.Id_Campo_Log 
 
*/ 
 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'C' , 'Certificado' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'D' , 'Diploma' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'L' , 'Declaração' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'O' , 'Outros' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'T' , 'Certidão' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'UnidadeDuracao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'A' , 'Anos' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'UnidadeDuracao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'H' , 'Horas' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'UnidadeDuracao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'M' , 'Meses' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'UnidadeDuracao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'CursosEventosRealizado'))  , 'S' , 'Semestres' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoComposicao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  , '0' , 'Normal' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoComposicao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  , '1' , 'Unificada' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoComposicao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  , '2' , 'Conjunta' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoComposicao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  , '3' , 'Associada' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoComposicao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  , '0' , 'Normal' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoComposicao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  , '1' , 'Unificada' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoComposicao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  , '2' , 'Conjunta' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TipoComposicao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'DetalhesEmissao'))  , '3' , 'Associada' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Atualizado' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Atualizado' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Atualizado' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Atualizado' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Correspondencia' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Correspondencia' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Correspondencia' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Correspondencia' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Enderecos'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Ativo' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Ativo' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Ativo' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Ativo' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_InstituicaoEnsino' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_InstituicaoEnsino' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_InstituicaoEnsino' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_InstituicaoEnsino' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_PessoaJuridica' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '0' , 'Profissional' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_PessoaJuridica' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '1' , 'Pessoa Jurídica' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_PessoaJuridica' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '0' , 'Profissional' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_PessoaJuridica' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Pessoas'))  , '1' , 'Pessoa Jurídica' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'NumDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PrevisoesPagamento'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'NumDocumento' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PrevisoesPagamento'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'AnoPrevisao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PrevisoesPagamentosSG'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'AnoPrevisao' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PrevisoesPagamentosSG'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Fiscal' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Fiscal' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Fiscal' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Fiscal' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'EstadoCivil' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , 'C' , 'Casado' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'EstadoCivil' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , 'D' , 'Divorsiado' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'EstadoCivil' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , 'O' , 'Outros' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'EstadoCivil' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , 'P' , 'Separado' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'EstadoCivil' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , 'S' , 'Solteiro' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'EstadoCivil' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , 'V' , 'Viúvo' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Sexo' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , 'F' , 'Feminino' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Sexo' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Profissionais'))  , 'M' , 'Masculino' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Recebido' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Recebido' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Recebido' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'Recebido' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TramitacaoLote' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TramitacaoLote' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TramitacaoLote' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'TramitacaoLote' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'Tramitacoes'))  , '1' , 'Sim' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Exterior' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas'))  , '1' , 'Sim' 
 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas'))  , '0' , 'Não' 
INSERT INTO #T_Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao)  SELECT  Id_campo_Log= (SELECT Id_campo_Log FROM ImplantaLog.dbo.Campo_Log WHERE  Nome_Campo = 'E_Residencial' AND Id_Tabela =  
(SELECT Id_Tabela FROM ImplantaLog.dbo.Tabela_Log WHERE Tabela = 'PessoasJuridicas'))  , '1' , 'Sim' 
 
DELETE #T_Dominio_Campo_Log FROM #T_Dominio_Campo_Log WHERE  Id_campo_Log IS NULL 
 
UPDATE ImplantaLog.dbo.Dominio_Campo_Log SET 
Descricao=t1.Descricao 
FROM #T_Dominio_Campo_Log t1, 
     ImplantaLog.dbo.Dominio_Campo_Log T2 
WHERE t1.Id_campo_Log=t2.Id_campo_Log and 
      t1.Valor_Dominio=t2.Valor_Dominio 
 
-- Cabecalho_Tabela_Log OK 
 
INSERT INTO ImplantaLog.dbo.Dominio_Campo_Log (Id_campo_Log,Valor_Dominio,Descricao) 
SELECT DISTINCT t1.Id_campo_Log,t1.Valor_Dominio,t1.Descricao 
FROM #T_Dominio_Campo_Log t1 left join  ImplantaLog.dbo.Dominio_Campo_Log t2 on  t1.Id_campo_Log=t2.Id_campo_Log and t1.Valor_Dominio=t2.Valor_Dominio 
WHERE t2.Id_campo_Log is null  
 
COMMIT TRAN 
END 
