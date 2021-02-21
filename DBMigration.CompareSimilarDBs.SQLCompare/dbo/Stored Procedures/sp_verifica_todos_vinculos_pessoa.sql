/*
  Arquivo. SISCAF_Verifica_Vinculos_Pessoa.sql
  Autor. Jose Mario
  Data. 12/08/2011
  Objetivo. Recuperar tabelas Vinculadas com cadastro de outras pessoas.
  Ocorr. 80438
  Historico. 
 	
 	(17/08/2011) Nelson Castro. Adicao do parametro de entrada IdPessoa.
 	(14/08/2011) Nelson Castro. Tratamento do campo nome com apostrofo.
  */
  
CREATE PROCEDURE [dbo].[sp_verifica_todos_vinculos_pessoa]
	@P_IN_IDPESSOA INT
AS

	DECLARE @IdPessoa    INT,
	        @Nome        VARCHAR(120),
	        @NomeTabela  VARCHAR(120),
	        @NomeCampo   VARCHAR(120),
	        @comando     VARCHAR(300)
	
	CREATE TABLE #tabtemp1
	(
		Nome        VARCHAR(120),
		NomeTabela  VARCHAR(120),
		NomeCampo   VARCHAR(120)
	)
	
	CREATE TABLE #tabtemp2
	(
		NomeTabela  VARCHAR(120),
		NomeCampo   VARCHAR(120)
	)
	INSERT INTO #tabtemp2
	  (
	    NomeTabela,
	    NomeCampo
	  )
	SELECT t1.name,
	       t2.name
	  FROM sys.objects t1,
	       sys.columns t2
	 WHERE t1.object_id = t2.object_id
	       AND t2.name LIKE 'IdPessoa'
	       AND SUBSTRING(t1.name, 1, 2) <> 'VW'
	       AND t1.name <> 'pessoas'
	
	INSERT INTO #tabtemp2
	  (
	    NomeTabela,
	    NomeCampo
	  )
	SELECT t2.name,
	       t4.name
	  FROM sysreferences t1,
	       sysobjects t2,
	       sysforeignkeys t3,
	       syscolumns t4
	 WHERE t1.rkeyid IN (SELECT id
	                       FROM sysobjects
	                      WHERE NAME = 'pessoas')
	       AND t1.fkeyid = t2.id
	       AND t1.constid = t3.constid
	       AND t3.fkeyid = t4.id
	       AND t3.fkey = t4.colid
	ORDER BY
	       t2.name
	
	
	-- Inicio da Análise da Base
	DECLARE Cur_Pessoa  CURSOR READ_ONLY 
	FOR
	    SELECT DISTINCT IdPessoa,
	           Replace(Nome,'''', '''''') AS NOME      
	      FROM dbo.Pessoas
	     WHERE IDPESSOA = @P_IN_IDPESSOA
	    ORDER BY
	           Nome
	
	OPEN Cur_Pessoa 
	
	FETCH NEXT FROM Cur_Pessoa INTO @IdPessoa, @Nome                                                                                                                                                                                     
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    -- Inicio da Análise de Vinculo
	    DECLARE Cur_Vinculo   CURSOR READ_ONLY 
	    FOR
	        SELECT DISTINCT NomeTabela,
	               NomeCampo  
	          FROM #tabtemp2
	        ORDER BY
	               NomeTabela
	    
	    OPEN Cur_Vinculo 
	    
	    FETCH NEXT FROM Cur_Vinculo INTO @NomeTabela, @NomeCampo                                                                                                                                                                                                                         
	    
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        SET @comando = 'Select ''' + @Nome + ''',''' + @NomeTabela + ''',''' 
	            + @NomeCampo + ''' from ' + @NomeTabela + ' where ' + @NomeCampo 
	            + '=' + CONVERT(VARCHAR(20), @IdPessoa)
	        PRINT @comando
	        EXEC ('Insert into #tabtemp1 ' + @comando)
	        FETCH NEXT FROM Cur_Vinculo INTO @NomeTabela, @NomeCampo
	    END 
	    
	    CLOSE Cur_Vinculo 
	    DEALLOCATE Cur_Vinculo 
	    
	    FETCH NEXT FROM Cur_Pessoa INTO @IdPessoa, @Nome
	END 
	
	CLOSE Cur_Pessoa 
	DEALLOCATE Cur_Pessoa  
	
	SELECT DISTINCT *,
		CASE NomeTabela

			WHEN 'Acessos' THEN
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Permissões de acesso ao sistemas Implanta'
					ELSE 'Não Catalogado'
				END

			WHEN 'AcomodacoesHoteis' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Acomodações do hotel'
					ELSE 'Não Catalogado'
				END

			WHEN 'Aeroportos' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Complemento do cadastro de aeroportos'
					ELSE 'Não Catalogado'
				END

			WHEN 'AlertaEmpenho' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Utilizada para associar a pessoa viagem com a despesa solicitada e com o cadastro de pessoas'
					ELSE 'Não Catalogado'
				END

			WHEN 'AlertaEmpenhoSG' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Utilizada para associar a pessoa da Ordem de Compra com o Empenho'
					ELSE 'Não Catalogado'
				END

			WHEN 'Alugueis' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa'	THEN 'Cadastro de aluguéis da pesssoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'AreasAtuacao_Pessoas' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Cadastro de áreas de atuação da pessoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'AtendimentosOrdens' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Cadastro de acompanhamento de ordem de compra'
					ELSE 'Não Catalogado'
				END

			WHEN 'AtendimentosPedidosRegPreco' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Relaciona os itens utilizados na modalidade Registro de Preço com a pessoa do fornecedor'
					ELSE 'Não Catalogado'
				END

			WHEN 'AutosInfracao' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Cadastro de infrações cometidas pelo fiscalizado'
					ELSE 'Não Catalogado'
				END

			WHEN 'Bancos' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Complemento do cadastro de bancos'
					ELSE 'Não Catalogado'
				END

			WHEN 'Certificacoes' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Cadastro responsável por associar certificados de regularidade à pessoas físicas ou jurídicas'
					ELSE 'Não Catalogado'
				END

			WHEN 'Cidades' THEN 
				CASE NomeCampo 
					WHEN 'IdSubregiao' THEN 'A pessoa está relacionada ao Cadastro de Cidades'
					ELSE 'Não Catalogado'
				END

			WHEN 'Companhias' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Companhias aéreas'
					ELSE 'Não Catalogado'
				END

			WHEN 'ComplementosProfissional' THEN 
				CASE NomeCampo 
					WHEN 'IdUnidadeConselho' THEN 'Utilizada no cadastro de profissionais'
					ELSE 'Não Catalogado'
				END

			WHEN 'ComplementosRemetente' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Utilizada como complemento do remetente no SISDOC'
					ELSE 'Não Catalogado'
				END

			WHEN 'Configuracoes' THEN 
				CASE NomeCampo
					WHEN 'IdPessoaFavorecidoRecRealiz' THEN 'Utilizada nas configurações dos sistemas financeiros/contábeis'
					WHEN 'IdPessoaRecRealizar' THEN 'Utilizada nas configurações dos sistemas financeiros/contábeis'
					ELSE 'Não Catalogado'
				END

			WHEN 'ConfiguracoesSispad' THEN 
				CASE NomeCampo
					WHEN 'IdPessoaAdiantamento' THEN 'Utilizada nas configurações do SISPAD'
					ELSE 'Não Catalogado'
				END

			WHEN 'Consorcios' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Utilizada para vincular a pessoa do processo, contrato e da licitação com a pessoa do consórcio'
					ELSE 'Não Catalogado'
				END

			WHEN 'Contratos' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vinculada ao Cadastro de contratos'
					ELSE 'Não Catalogado'
				END

			WHEN 'ContratosPessoas' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vinculada ao Cadastro de contratos'
					ELSE 'Não Catalogado'
				END

			WHEN 'Correspondencias' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vinculada ao Cadastro de correspondências'
					ELSE 'Não Catalogado'
				END

			WHEN 'Cotacoes' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Cadastro de cotações'
					ELSE 'Não Catalogado'
				END

			WHEN 'Credenciados' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Instituições credenciavéis'
					ELSE 'Não Catalogado'
				END

			WHEN 'CursosEventos' THEN
				CASE NomeCampo
					WHEN 'IdPessoaCampus' 	   THEN 'Vinculada a cursos/eventos do cadastro de profissionais (Campus)'
					WHEN 'IdPessoaEntidade'	   THEN	'Vinculada a cursos/eventos do cadastro de profissionais (Entidade/Local)'
					WHEN 'IdPessoaMinistrante' THEN	'Vinculada a cursos/eventos do cadastro de profissionais (Ministrante)'
					ELSE 'Não Catalogado'
				END

			WHEN 'CursosEventosOferecidos' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vinculada a Curso/Eventos Oferecidos'
					ELSE 'Não Catalogado'
				END

			WHEN 'CursosEventosRealizado' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' 	  THEN 'Vinculada a Curso/Eventos Realizados'
					WHEN 'IdPessoaCampus' THEN 'Campus em  que o evento foi realizado'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'CursosEventosRealizadoPessoas' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Cursos e eventos que a pessoa participou'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'Debitos' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Débitos da pessoa junto ao conselho'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'DespachosExpediente' THEN
				CASE NomeCampo
					WHEN 'IdResponsavel' THEN '?'
					ELSE 'Não Catalogado'
				END

			WHEN 'DespesasReceita' THEN
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Associa o custo da receita com um favorecido padrão para pagamento dessa despesa'
					ELSE 'Não Catalogado'
				END

			WHEN 'DetalhesGrade' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Cadastro de pessoas vinculaveis ao modulo de processo'
					ELSE 'Não Catalogado'
				END

			WHEN 'DetalhesGrade1' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Cadastro de pessoas vinculaveis ao modulo de processo'
					ELSE 'Não Catalogado'
				END

			WHEN 'DevolucoesReceita' THEN				
				CASE NomeCampo
					WHEN 'IdProfissional' THEN 'Vincula IdProfissional com IdPessoa da tabela de Pessoas'
					WHEN 'IdSolicitante'  THEN 'Vincula IdSolicitante com IdPessoa da tabela de Pessoas'
					ELSE 'Não Catalogado'
				END

			WHEN 'DigitalizacoesPessoas' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Documentos digitalizados de pessoas cadastradas'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'DigitalizacoesPreCadastro' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Documentos digitalizados de pessoas pré-cadastradas'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'DividaAtiva' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Lançamento de débitos em dívida ativa'
					ELSE 'Não Catalogado'
				END

			WHEN 'DocumentosSisdoc' THEN
				CASE NomeCampo
					WHEN 'IdPessoa'          THEN 'Documentos relacionados a pessoa no SISDOC'
					WHEN 'IdPessoaRequerido' THEN 'Documentos relacionados a pessoa no SISDOC'
					ELSE 'Não Catalogado'
				END

			WHEN 'Emissoes' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Emissões de boleto relacionados a pessoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'Empenhos' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vincula o favorecido do Empenho com a tabela de Pessoas'
					ELSE 'Não Catalogado'
				END

			WHEN 'EmprestimoBens' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vincula um item móvel do patrimônio a uma Pessoa que receberá o empréstimo'
					ELSE 'Não Catalogado'
				END

			WHEN 'Enderecos' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Endereços da pessoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'EnderecosProcesso' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Endereços da pessoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'ExperienciasProfissionais' THEN
				CASE NomeCampo
					WHEN 'IdEntidadeClasse' THEN 'Entidade da experiência profissional'
					WHEN 'IdPessoa'         THEN 'Experiência profissional da pessoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'Fiscalizacoes' THEN
				CASE NomeCampo
					WHEN 'IdPessoa_Denunciante'	THEN 'Fiscalizações relacionadas a pessoa'
					WHEN 'IdTabela1Pessoa'		THEN 'Fiscalizações relacionadas a pessoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'Fiscalizacoes_Prof_PJ' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Fiscalizações relacionadas a pessoa'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'Fiscalizacoes_Prof_PJ2' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Fiscalizações relacionadas a pessoa'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'FormasPagamento' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Vincula o favorecido do Pagamento à Pessoa do Favorecido'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'FormasPagamentoAssinatura' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Vincula a Pessoa do Responsável por Assinaturas aos pagamentos'
					ELSE 'Não Catalogado'
				END
					
			WHEN 'GruposMalaDiretaProfPJPessoas' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Malas diretas em lote'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'HistoricoPeriodoInativo' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Histórico do período de inatividade'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'HistoricoSituacaoSolicitacoes' THEN 
				CASE NomeCampo
					WHEN 'IdPessoaPassageiro' THEN '?'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'InscricaoExameOrdem' THEN 
				CASE NomeCampo 	
					WHEN 'IdPessoa' THEN 'Cadastro de Inscrições exame da ordem'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'Itens' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vincula o item de almoxarifado ao contratado no processo de Registro de Preços'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'ItensImoveis' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Vincula o Bem Imóvel à Pessoa do Propríetário Anterior'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'ItensMoveis' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vincula do Bem Móvel com a Pessoa do Fornecedor do bem'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'LancamentosFinanceiros' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Relaciona os Lançamentos Financeiros da Agenda à Pessoa envolvida na transação'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'ListaProcessos' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Vincula a Pessoa do Fornecedor dos itens de compras com o Processo de Compras / Serviços'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'Locadoras' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Complemento de cadastro para locadoras'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'LocaisExameOrdem' THEN
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Complemento do cadastro de exame da ordem'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'MalaDiretaEnvio' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Malas diretas enviadas'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'Obras' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Cadastro de obras realizadas'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'OcorrenciasPessoa' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Eventos ou fatos ocorridos com a pessoa'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'Ordens' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Cadastro de ordens de compra'
					ELSE 'Não Catalogado'
				END
			
			WHEN 'OutrasDespesasHoteis'	THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Outras despesas hotel'
					ELSE 'Não Catalogado'
				END

			WHEN 'OutrasResponsabilidades' THEN
				CASE NomeCampo
					WHEN 'IdPessoaPF' THEN 'Cadastro de outras responsabilidades da pessoa'
					WHEN 'IdPessoaPJ' THEN 'Cadastro de outras responsabilidades da pessoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'ParametrosSiscafw' THEN
				CASE NomeCampo
					WHEN 'IdConselhoCorrente' THEN 'Parâmetros do conselho no SISCAF'
					WHEN 'IdPessoaPadrao'	  THEN '?'
					ELSE 'Não Catalogado'
				END

			WHEN 'ParametrosSiscafWeb' THEN 
				CASE NomeCampo
					WHEN 'IdConselhoProprietario' THEN 'Conselho configurado'
					ELSE 'Não Catalogado'
				END

			WHEN 'Pessoas' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' 		 THEN 'Chave primária da tabela'
					WHEN 'IdPessoaPrincipal' THEN 'Vincula o IdPessoa de uma pessoa principal (Cons Federal, por ex) ao IdPessoaPrincipal de uma pessoa acessória (Cons Regional, por ex)'
					ELSE 'Não Catalogado'
				END

			WHEN 'PessoasIsentasTributo' THEN
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Cria uma restrição para o IdPessoa, no sentido de isentá-la de qualquer tributação'
					ELSE 'Não Catalogado'
				END

			WHEN 'PessoasJuridicas' THEN
				CASE NomeCampo
					WHEN 'IdDelegaciaCriacao' THEN 'Cadastro de Delegacias'
					WHEN 'IdSubRegiao' 		  THEN 'Cadastro de SubRegiões'
					WHEN 'IdUnidadeConselho'  THEN 'Cadastro de Conselhos'
					ELSE 'Não Catalogado'
				END

			WHEN 'PessoasProfissoes' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Profissões exercidas pela pessoa'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'PessoasSispad' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Associa a PessoaSispad ao cadastro de Pessoas'
					ELSE 'Não Catalogado'
				END

			WHEN 'PessoasTributos' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Vincula as pessoas físicas ou jurídicas aos seus respectivos tributos e ramos de atividade'
					ELSE 'Não Catalogado'
				END

			WHEN 'Processo_Fases' THEN	
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Pessoa vínculada a fase do processo'
					WHEN 'IdRespCorrespPessoa' THEN 'Pessoa responsável pelas respostas de correspondencias'
					ELSE 'Não Catalogado'
				END

			WHEN 'Processos' THEN
				CASE NomeCampo
					WHEN 'IdTabela1Pessoa' THEN	'A pessoa está relacionada a processos'
					WHEN 'IdTabela2Pessoa' THEN	'A pessoa está relacionada a processos'
					WHEN 'IdTabela3Pessoa' THEN	'A pessoa está relacionada a processos'
					WHEN 'IdTabela4Pessoa' THEN	'A pessoa está relacionada a processos'
					WHEN 'IdTabela5Pessoa' THEN	'A pessoa está relacionada a processos'
					ELSE 'Não Catalogado'
				END

			WHEN 'Processos_Prof_PJ' THEN
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'A pessoa está relacionada a processos'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'Processos_Prof_PJ_Pessoas1' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'A pessoa está relacionada a processos'
					ELSE 'Não Catalogado'
				END

			WHEN 'Profissionais' THEN
				CASE NomeCampo
					WHEN 'IdDelegaciaCriacao' THEN 'A pessoa está relacionada ao Cadastro de Profissionais'
					WHEN 'IdSubRegiao'		  THEN 'A pessoa está relacionada ao Cadastro de Profissionais'
					WHEN 'IdUnidadeConselho'  THEN 'A pessoa está relacionada ao Cadastro de Profissionais'
					ELSE 'Não Catalogado'
				END

			WHEN 'Profissionais_Dependentes' THEN 
				CASE NomeCampo
					WHEN 'IdPessoaDependente' THEN 'A pessoa está relacionada ao Cadastro de Dependentes de Profissionais'
					ELSE 'Não Catalogado'
				END

			WHEN 'ProfissionaisCarteira' THEN 
				CASE NomeCampo
					WHEN 'IdSubregiao' THEN 'A pessoa está relacionada  a carteiras emitadas para profissionais'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'Propostas' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Vincula a Pessoa responsável pela proposta à licitação'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'RadioTaxi' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Cadastro complementar de radio tâxi'
					ELSE 'Não Catalogado'
				END

			WHEN 'RegioesAdministrativas' THEN 
				CASE NomeCampo
					WHEN 'IdPessoaDelegacia' THEN 'A pessoa está relacionada a Regiões Administrativas'
					ELSE 'Não Catalogado'
				END

			WHEN 'RegistrosCursos' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Registro de cursos'
					ELSE 'Não Catalogado'
				END

			WHEN 'ReservaHotel' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Cadastro de reservas de hotel'
					ELSE 'Não Catalogado'
				END

			WHEN 'RespostasPFPJ' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa' THEN '?'
					ELSE 'Não Catalogado'
				END

			WHEN 'RestosEmpenho' THEN 
				CASE NomeCampo
					WHEN 'IdPessoa'	THEN 'Associa o Restos Empenho à Pessoa do favorecido do Empenho original'
					ELSE 'Não Catalogado'
				END

			WHEN 'Seguros' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Complemento do cadastro de seguros'
					ELSE 'Não Catalogado'
				END

			WHEN 'SetoresAtuacao_Pessoas' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Setores de atuação da pessoa'
					ELSE 'Não Catalogado'
				END

			WHEN 'Suspensoes' THEN
				CASE NomeCampo
					WHEN 'IdRepresentadoPessoa' THEN 'A pessoa está relacionada ao Cadastro de Suspensões'
					WHEN 'IdSeccionalOrigem'	THEN 'A pessoa está relacionada ao Cadastro de Suspensões'
					ELSE 'Não Catalogado'
				END

			WHEN 'TelefonesPessoa' THEN
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Telefones da pessoa'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'TiposPessoa_Pessoas' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Tipos de pessoa associados com o cadastro de pessoa'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'TiposRateioAssociacoes' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Vincula uma determinada Pessoa Jurídica a um tipo de rateio de pagamento para associação'
					ELSE 'Não Catalogado'
				END

			WHEN 'Tributos' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Associa o cadastro de tributos com a Pessoa Jurídica responsável pelo recolhimento do tributo'
					ELSE 'Não Catalogado'
				END

			WHEN 'TributosPagamento' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoaTributo' THEN 'Associação feita entre pessoa do pagamento com o tributo retido'
					ELSE 'Não Catalogado'
				END

			WHEN 'TributosRestosPagamento' THEN 
				CASE NomeCampo 
					WHEN 'IdPessoaTributo' THEN 'Associação feita entre pessoa do pagamento de restos a pagar com o tributo retido'
					ELSE 'Não Catalogado'
				END 

			WHEN 'Usuarios' THEN
				CASE NomeCampo
					WHEN 'IdPessoa' 	THEN 'Cadastro de usuário do sistema'
					WHEN 'IdPessoaNome'	THEN 'Vinculo feito pelo logon entre o seu usuário e o cadastro de Pessoas'
					ELSE 'Não Catalogado'
				END
				
			WHEN 'Web_CursosEventosRealizado' THEN	
				CASE NomeCampo
					WHEN 'IdPessoa' THEN 'Cadastro de cursos e eventos disponibilizados na WEB'
					ELSE 'Não Catalogado'
				END
					
			WHEN 'Web_Despesas' THEN
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Vincula as despesas criadas pelo PCS às respectivas Pessoas favorecidas'
					ELSE 'Não Catalogado'
				END

			WHEN 'Web_ExperienciasProfissionais' THEN
				CASE NomeCampo 
					WHEN 'IdPessoa' THEN 'Experiência profissional da pessoa disponibilizada na WEB'
					ELSE 'Não Catalogado'
				END
				
			ELSE 'Não Catalogado'
		END AS 'Descricao'
				FROM #tabtemp1
			ORDER BY
						 Nome,
						 NomeTabela
