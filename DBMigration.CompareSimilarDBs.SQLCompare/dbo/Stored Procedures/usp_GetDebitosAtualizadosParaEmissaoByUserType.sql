
CREATE PROCEDURE dbo.usp_GetDebitosAtualizadosParaEmissaoByUserType ( @EmissaoComDesconto        INT,
                                                                      @TipoPessoa                INT,
                                                                      @DataVencimentoBoleto      DATETIME,
                                                                      @DataAtualizacao           DATETIME,
                                                                      @IdProcedimentoAtraso      INT, 
                                                                      @TipoComposicao            INT,
                                                                      @DataMinimaASerConsiderada DATETIME,
                                                                      @Debitos                   Debitos READONLY )
AS
BEGIN		
	DECLARE @Result TABLE (
		        Agrupador                   INT, 		 
		        IdDebito                    INT,      
                IdProfissional	            INT,
                IdPessoaJuridica            INT,      
                IdPessoa		            INT,      
                IdTipoDebito	            INT,      
                NumConjReneg	            INT,      
                NumConjTpDebito	            INT,      
                SiglaDebito		            VARCHAR(10),  
                NumeroParcela	            INT,      
                DataReferencia	            DATETIME, 
                DataVencimento	            DATETIME, 
                ValorDevido		            MONEY,    
                ValorPrincipal	            MONEY,    
                ValorAtualizacao            MONEY,    
                ValorMulta		            MONEY,    
                ValorJuros		            MONEY,    
                ValorDesconto	            MONEY,    
                IdProcedimento	            INT,     
                IsentoDeEncargosParaEmissao	BIT,                            
                CodErro			            INT
                )      
    /* Ok criançada, vamos agora entender o uso desse tal de Agrupador: de onde vem, o que faz, o que come.
    * Basicamente, cada número diferente em Agrupador significa uma emissão diferente.
    * Esse campo só irá ser utilizado pela stored procedure usp_GerarEmissao, ou seja, quando esta SP for chamada
    * por outro lugar, por exemplo, pela tela de emissão individual (que só utiliza o parâmetro @EmissaoComDesconto
    * com valores 0 ou 1).
    * Esse campo servirá para tratarmos os tipos de emissão quando o parâmtro @EmissaoComDesconto vier com os
    * valores 2 ou 3 que é quando devemos tratar as opções de desconto como uma emissão a parte.
    * Vou tentar desenhar: Imagine que temos uma anuiade 2018 com vencimento para 31/03 e valor de R$ 800,00
    * e duas opções de desconto, sendo: 
    *   1 faixa - Desconto de R$ 80,00 com vencimento para 31/01
    *   2 faixa - Desconto de R$ 40,00 com vencimento para 28/02 
    *  Obs.: para este exemplo, imagine que hoje é dia 10/01. 
    * Se a emissão for feita de forma normal (@EmissaoComDesconto = 0) será feito apenas uma emissão com data 
    * de vencimento para 31/03 no valor de R$ 800,00 e ela terá as opções de desconto mencionadas acima (exceto
    * Banco do Brasil que só aceita uma opção de desconto).
    * Já se a emissão for realizada utilizando o parâmetro de desconto aplicado (@EmissaoComDesconto = 1, usado
    * apenas na emissão individual) será gerada uma emissão com vencimento em 31/01 no valor de R$ 720,00 e
    * NÃO HAVERÁ opções de desconto atribuídas a esta emissão.
    * Até aqui nada de diferente e nada que justifique a utilização do campo Agrupador.
    * Agora é que são elas, vamos analisar os dois últimos tipos do parâmetro @EmissaoComDesconto que é 2 e 3, sendo:
    *   2 -> Emissão em 3 Guias - Específico paraq o CRQ/PR - onde existe um layout de impressão específico. Para esta 
    *        emissão é gerado 3 emissões para o mesmo débito. Seguindo o exemplo mencionado acima, seria realizada a 
    *        emissão normal para a anuidade (Vencimento 31/03 e Valor R$ 800,00) e mais duas opções de desconto (Vencimento
    *        31/03 e Valor R$ 720,00 - Vencimento 28/02 e Valor R$ 760,00). Mesmo que houvesse mais opções de desconto não
    *        seriam consideradas, isso porque no layout desta impressão é aceito até 3 boletos na mesma página, então por isso
    *        é a emissão sem desconto (normal) e duas com desconto (se houver). A emissão normal não será configurada 
    *        com descontos, ou seja, não há a possibilidade de pagar o boleto com valor normal com a aplicação de desconto.
    *   3 -> Considerar cada opção de desconto uma emissão - Disponível para todos os conselhos - Para esta opção
    *        é gerada uma emissão normal sem desconto (e também sem desconto vinculado, ou seja, não vai sair no boleto
    *        nenhuma opção de desconto), e para cada opção de desconto configurada será feita uma emissão. Na versão anterior
    *        estava limitada a 3 opções de desconto, mas com este novo formato se for configurado 100 opções de desconto serão
    *        realizadas 101 emissões para o mesmo débito (1 emissão normal mais 100 opções de desconto). 
    *  
    *  Agora que vocês entenderam como o negócio funciona (assim eu espero), vamos entender a utilidade do Agrupador.
    *  Na usp_GerarEmissao é feito um Loop entre todos os débitos que foram selecionado para realizar a emissão, sendo cada
    *  Loop uma emissão. 
    *  
    *  Quando se opta por fazer a emissão normal (cada débito é uma emissão) o Loop será feito sobre a lista
    *  de débitos selecionados pela CA. Já se o usuário optar por uma emissão unificada, o Loop será feito pelas pessoas, ou seja,
    *  em cada Loop será selecionado todos os débitos de uma pessoa X e emitido uma emissão só contendo todos estes débitos, e em seguida,
    *  passasse para outra pessoa, e assim vai. 
    *  
    *  Acontece que a cada Loop é chamada esta SP aqui que tem a função de retornar os dados de vencimento e valor para que seja gerada
    *  a emissão.
    *  
    *  Mas se for optado pelo parâmetro EmissaoComDesconto = 3 por exemplo, significa que seguindo nosso exemplo acima esta SP irá retornar
    *  3 registros, sendo:
    *
    *      -> ANU 2018 - Valor R$ 800,00 - Vencimento 31/03
    *      -> ANU 2018 - Valor R$ 760,00 - Vencimento 31/01
    *      -> ANU 2018 - Valor R$ 740,00 - Vencimento 28/02            
    *
    *  Não podemos simplesmente pegar estes três registros e juntar em uma mesma emissão como se fossem débitos diferentes em uma emissão
    *  unificada.
    *  
    *  Cada um destes registros deve ser uma emissão diferente, então na usp_GerarEmissao quando receber os dados desta SP aqui ela deve
    *  tratar estes 3 registros como emissões diferentes.
    *  
    *  Para isso na usp_GerarEmissao será feito um Loop dentro do Loop principal para que seja feita uma emissão para cadas registro retornado
    *  por esta SP aqui.
    *  
    *  É por isso que temos o Agrupador, para que ao retornar os valores fique assim:
    *  
    *      -> ANU 2018 - Valor R$ 760,00 - Vencimento 31/01 - Agrupador 001
    *      -> ANU 2018 - Valor R$ 740,00 - Vencimento 28/02 - Agrupador 002
    *      -> ANU 2018 - Valor R$ 800,00 - Vencimento 31/03 - Agrupador 999
    *      
    *      Obs.: A emissão normal recebe o agrupador 999 para que ela fique por último na hora da emissão.          
    *
    *  Mas aí você se pergunta, Pra que o agrupador? basta considerar que cada linha retornada é uma emissão.
    *  
    *  Muito bom! Mas isso não funciona.
    *  
    *  Não funciona porque temos um próximo caso, quando a emissão é unificada.
    *  
    *  Vamos acrescentar um pouco mais de complexidade a nosso exemplo. Vamos imaginar que além da Anuidade 2018 o conselho quer
    *  fazer a emissão de uma TAXA no valor de R$ 120,00 com vencimento para R$ 20/03 e quer que essa TAXA seja emitida
    *  de forma UNIFICADA.
    *  
    *  Não vou explicar aqui como todo o processo de gerar os registros vai funcionar, basta analisar o código abaixo.
    *  
    *  Apenas vou apresentar o resultado:
    *  
    *      -> ANU 2018 - Valor R$ 760,00 - Vencimento 31/01 - Agrupador 001
    *      -> TAX 2018 - Valor R$ 120,00 - Vencimento 20/03 - Agrupador 001
    *      -> ANU 2018 - Valor R$ 740,00 - Vencimento 28/02 - Agrupador 002
	*      -> TAX 2018 - Valor R$ 120,00 - Vencimento 20/03 - Agrupador 002        
    *      -> ANU 2018 - Valor R$ 800,00 - Vencimento 31/03 - Agrupador 999
    *      -> TAX 2018 - Valor R$ 120,00 - Vencimento 20/03 - Agrupador 999
    *  
    *  Bom, então vamos trabalhar mais um pouco nossa imaginação.
    *  Vamos imaginar que estamos fazendo a geração das anuidades 2018 para todos os profissionais.
    *  
    *  Se a data de vencimento do boleto foi fixada então não será realizada emissões extras (para cada opção de desconto).
    *  Isso porque não faria sentido emitir o mesmo débito para o mesmo vencimento com valores distintos.
    *  Seguindo o primeiro exemplo, utilizando a data de vencimento fixa em 25/02 as emissões ficariam assim:
    *  
    *      -> ANU 2018 - Valor R$ 760,00 - Vencimento 25/02 - Agrupador 001
    *      -> ANU 2018 - Valor R$ 740,00 - Vencimento 25/02 - Agrupador 002
    *      -> ANU 2018 - Valor R$ 800,00 - Vencimento 25/02 - Agrupador 999
    *      
    *  O que não faria sentido, primeiro que se existem 3 emissões com o mesmo vencimento porque
    *  a pessoa iria utilizar os boletos com maior valor? E segundo porque cada opção de desconto
    *  foi criada para ser atribuída a uma data específica, não fazendo sentido definir que o 
    *  boleto seja emitido com uma data posterior e o valor com desconto aplicado de uma data anterior.
    *  
    *  Desta forma, caso então a data de vencimento do boleto seja fixada, será acatada somente uma emissão, 
    *  sendo ela com valor normal (cheio - sem desconto) e para a data fixada.
    *  
    *  Ficaria assim:
    *  
    *      -> ANU 2018 - Valor R$ 800,00 - Vencimento 25/02 - Agrupador 999
    *          
    * */            
    
	
	IF EXISTS(SELECT TOP 1 1 FROM @Debitos) 
	BEGIN		
        -----------------------------------------------------------------
		--- 0 -> Emissão normal sem desconto
		--- 2 -> Emissão em 3 Guias -> Uma destas guias é a emissão normal
		--- 3 -> Emissão para cada uma das opções de desconto -> também
		---      é feita a emissão normal
		-----------------------------------------------------------------
		IF @EmissaoComDesconto IN (0, 2, 3) OR @DataVencimentoBoleto IS NOT NULL
		BEGIN
			INSERT INTO @Result
			SELECT	999,
					d.IdDebito,
					d.IdProfissional, 
					d.IdPessoaJuridica,
					d.IdPessoa, 
					d.IdTipoDebito,
					d.NumConjReneg,
					d.NumConjTpDebito,		 
					td.SiglaDebito,
					d.NumeroParcela,
					d.DataReferencia,	
					d.DataVencimento,
					ada.ValorTotal,
					ISNULL(ada.ValorTotal ,0) - ISNULL(ada.Atualizacao,0) - ISNULL(ada.Multa,0) - ISNULL(ada.Juros,0),
					ISNULL(ada.Atualizacao,0), 
					ISNULL(ada.Multa,0), 
					ISNULL(ada.Juros,0),			
					0,
					ada.IdProcedimento,
					td.IsentoDeEncargosParaEmissao,
					ada.CodErro    
			FROM   Debitos d
					JOIN TiposDebito td ON td.IdTipoDebito = d.IdTipoDebito
					OUTER APPLY dbo.AtualizaDebitosAll( d.DataVencimento,
					                                    COALESCE(@DataAtualizacao, d.DataVencimento),
														d.ValorDevido,
														@TipoPessoa,
														d.IdTipoDebito,
														d.IdMoeda,
														@IdProcedimentoAtraso,
														d.IdDebito,
														d.IdSituacaoAtual ) ada
			WHERE d.IdDebito IN (SELECT IdDebito FROM @Debitos)
			  AND d.IdSituacaoAtual IN ( 1 ,3 ,10 ,15 )
			  AND ISNULL(ada.ValorTotal, 0) > 0	
		END
		
        -----------------------------------------------------------------
		--- 1 -> Emissão com desconto aplicado
		-----------------------------------------------------------------			
		IF @EmissaoComDesconto = 1 AND @DataVencimentoBoleto IS NULL
		BEGIN
			INSERT INTO @Result
			SELECT	0,
					d.IdDebito,
					d.IdProfissional, 
					d.IdPessoaJuridica,
					d.IdPessoa, 
					d.IdTipoDebito,
					d.NumConjReneg,
					d.NumConjTpDebito,		 
					td.SiglaDebito,
					d.NumeroParcela,
					d.DataReferencia,	
					CASE WHEN gd.DataDesconto IS NULL THEN d.DataVencimento ELSE gd.DataDesconto END,     	 
					ada.ValorTotal - ISNULL(CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
								                                                            ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         			                                                            		 ISNULL(ada.Atualizacao,0) - 
			         			                                                            		 ISNULL(ada.Multa      ,0) - 
			         			                                                            		 ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                                           END					 
					END, 0),					        
					( ISNULL(ada.ValorTotal ,0) - 
					  ISNULL(ada.Atualizacao,0) - 
					  ISNULL(ada.Multa      ,0) - 
					  ISNULL(ada.Juros      ,0) ) - ISNULL(CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
								                                                                           ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         			                                 		                                          ISNULL(ada.Atualizacao,0) - 
			         			                                 		                                          ISNULL(ada.Multa      ,0) - 
			         			                                 		                                          ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                                                          END						 
					                                       END, 0),
					ISNULL(ada.Atualizacao,0), 
					ISNULL(ada.Multa,0), 
					ISNULL(ada.Juros,0),			
					ISNULL(CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
							                                         ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         		                                                ISNULL(ada.Atualizacao,0) - 
			         		                                          		ISNULL(ada.Multa      ,0) - 
			         		                                          		ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                    END
					       END, 0),
					ada.IdProcedimento,
					td.IsentoDeEncargosParaEmissao,
					ada.CodErro    
			FROM   Debitos d
					JOIN TiposDebito td ON td.IdTipoDebito = d.IdTipoDebito
					OUTER APPLY dbo.ufn_GetDescontos( d.IdDebito, @DataMinimaASerConsiderada ) gd
					OUTER APPLY dbo.AtualizaDebitosAll( d.DataVencimento,
					                                    COALESCE(@DataAtualizacao, d.DataVencimento),
														d.ValorDevido,
														@TipoPessoa,
														d.IdTipoDebito,
														d.IdMoeda,
														@IdProcedimentoAtraso,
														d.IdDebito,
														d.IdSituacaoAtual ) ada
			WHERE d.IdDebito IN (SELECT IdDebito FROM @Debitos)
			  AND d.IdSituacaoAtual IN ( 1 ,3 ,10 ,15 )
			  AND ISNULL(ada.ValorTotal, 0) > 0
			  AND ISNULL(gd.Ordem, 1) = 1 --> somente o primeiro desconto		
		END
		
        -----------------------------------------------------------------
		--- 2 -> Emissão normal e para cada uma das DUAS PRIMEIRAS opções 
		--       de desconto será criada uma emissão
		-- Se a data de vencimento do boleto foi fixada então não será
		-- realizada emissões extras (para cada opção de desconto).
		-----------------------------------------------------------------			
		IF @EmissaoComDesconto = 2 AND @DataVencimentoBoleto IS NULL
		BEGIN		
			INSERT INTO @Result
			SELECT	gd.Ordem,
					d.IdDebito,
					d.IdProfissional, 
					d.IdPessoaJuridica,
					d.IdPessoa, 
					d.IdTipoDebito,
					d.NumConjReneg,
					d.NumConjTpDebito,		 
					td.SiglaDebito,
					d.NumeroParcela,
					d.DataReferencia,	
					CASE WHEN gd.DataDesconto IS NULL THEN d.DataVencimento ELSE gd.DataDesconto END,     	 
					ada.ValorTotal - CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
								                                                      ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         			                                                      		 ISNULL(ada.Atualizacao,0) - 
			         			                                                      		 ISNULL(ada.Multa      ,0) - 
			         			                                                      		 ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                                     END						 
					END,
					( ISNULL(ada.ValorTotal ,0) - 
					  ISNULL(ada.Atualizacao,0) - 
					  ISNULL(ada.Multa      ,0) - 
					  ISNULL(ada.Juros      ,0) ) - CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
								                                                                     ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         			                                 		                                    ISNULL(ada.Atualizacao,0) - 
			         			                                 		                                    ISNULL(ada.Multa      ,0) - 
			         			                                 		                                    ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                                                    END						 
					END,
					ISNULL(ada.Atualizacao,0), 
					ISNULL(ada.Multa,0), 
					ISNULL(ada.Juros,0),			
					CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
							                                         ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         		                                                ISNULL(ada.Atualizacao,0) - 
			         		                                          		ISNULL(ada.Multa      ,0) - 
			         		                                          		ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                    END
					END,
					ada.IdProcedimento,
					td.IsentoDeEncargosParaEmissao,
					ada.CodErro    
			FROM   Debitos d
					JOIN TiposDebito td ON td.IdTipoDebito = d.IdTipoDebito
					CROSS APPLY dbo.ufn_GetDescontos( d.IdDebito, @DataMinimaASerConsiderada ) gd
					OUTER APPLY dbo.AtualizaDebitosAll( d.DataVencimento,
					                                    COALESCE(@DataAtualizacao, d.DataVencimento),
														d.ValorDevido,
														@TipoPessoa,
														d.IdTipoDebito,
														d.IdMoeda,
														@IdProcedimentoAtraso,
														d.IdDebito,
														d.IdSituacaoAtual ) ada
			WHERE d.IdDebito IN (SELECT IdDebito FROM @Debitos)
			  AND d.IdSituacaoAtual IN ( 1 ,3 ,10 ,15 )
			  AND ISNULL(ada.ValorTotal, 0) > 0
			  AND gd.Ordem IN (1,2) --> Só os dois primeiros descontos, porque somando com a emissão normal dá as 3 guais
			  AND gd.DataDesconto <= ISNULL(@DataVencimentoBoleto, gd.DataDesconto) 
		END
		
        -----------------------------------------------------------------
		--- 3 -> Emissão normal e para cada uma das opções de desconto 
		--       será criada uma emissão
		-- Se a data de vencimento do boleto foi fixada então não será
		-- realizada emissões extras (para cada opção de desconto).		
		-----------------------------------------------------------------			
		IF @EmissaoComDesconto = 3 AND @DataVencimentoBoleto IS NULL
		BEGIN
			INSERT INTO @Result
			SELECT	gd.Ordem,
					d.IdDebito,
					d.IdProfissional, 
					d.IdPessoaJuridica,
					d.IdPessoa, 
					d.IdTipoDebito,
					d.NumConjReneg,
					d.NumConjTpDebito,		 
					td.SiglaDebito,
					d.NumeroParcela,
					d.DataReferencia,	
					CASE WHEN gd.DataDesconto IS NULL THEN d.DataVencimento ELSE gd.DataDesconto END,     	 
					ada.ValorTotal - CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
								                                                      ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         			                                                      		 ISNULL(ada.Atualizacao,0) - 
			         			                                                      		 ISNULL(ada.Multa      ,0) - 
			         			                                                      		 ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                                     END						 
					END,
					( ISNULL(ada.ValorTotal ,0) - 
					  ISNULL(ada.Atualizacao,0) - 
					  ISNULL(ada.Multa      ,0) - 
					  ISNULL(ada.Juros      ,0) ) - CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
								                                                                     ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         			                                 		                                    ISNULL(ada.Atualizacao,0) - 
			         			                                 		                                    ISNULL(ada.Multa      ,0) - 
			         			                                 		                                    ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                                                    END						 
					END,
					ISNULL(ada.Atualizacao,0), 
					ISNULL(ada.Multa,0), 
					ISNULL(ada.Juros,0),			
					CASE WHEN gd.DataDesconto IS NOT NULL THEN CASE WHEN gd.E_Percentual = 0 THEN gd.ValorDesconto
							                                         ELSE ( ISNULL(ada.ValorTotal ,0) - 
			         		                                                ISNULL(ada.Atualizacao,0) - 
			         		                                          		ISNULL(ada.Multa      ,0) - 
			         		                                          		ISNULL(ada.Juros      ,0) ) * (gd.ValorDesconto / 100)
							                                    END
					END,
					ada.IdProcedimento,
					td.IsentoDeEncargosParaEmissao,
					ada.CodErro    
			FROM   Debitos d
					JOIN TiposDebito td ON td.IdTipoDebito = d.IdTipoDebito
					CROSS APPLY dbo.ufn_GetDescontos( d.IdDebito, @DataMinimaASerConsiderada ) gd
					OUTER APPLY dbo.AtualizaDebitosAll( d.DataVencimento,
					                                    COALESCE(@DataAtualizacao, d.DataVencimento),
														d.ValorDevido,
														@TipoPessoa,
														d.IdTipoDebito,
														d.IdMoeda,
														@IdProcedimentoAtraso,
														d.IdDebito,
														d.IdSituacaoAtual ) ada
			WHERE d.IdDebito IN (SELECT IdDebito FROM @Debitos)
			  AND d.IdSituacaoAtual IN ( 1 ,3 ,10 ,15 )
			  AND ISNULL(ada.ValorTotal, 0) > 0		
			  AND gd.DataDesconto <= ISNULL(@DataVencimentoBoleto, gd.DataDesconto) 
		END
		
		/*
		* Esse código foi a solução que eu achei para atribuir a todos os débitos que serão emitidos juntos
		* a mesma data de vencimento (isso para a emissão normal, porque para as emissões com desconto aplicado
		* já existe uma solução no Insert logo abaixo).
		* Não sei se ficou a melhor das soluções, mas o que ficou é que a emissão assumirá o vencimento do débito
		* que possui desconto, o que tecnicamente quer dizer que será (praticamente sempre) o vencimento 
		* da anuidade.
		* Se o usuário definiu uma data para o vencimento (@DataVencimentoBoleto) devemos assumir esta data como a data 
		* de vencimento da emissão. 
		* Isso quando a data definida pelo usuário for menor que a data de vencimento do débito (calculada). No entanto
		* se for uma emissão unificada, a data da emissão será a data informada pelo usuário.
		* */
		
		UPDATE @Result         
		SET DataVencimento = CASE WHEN @DataVencimentoBoleto IS NOT NULL 
		                           AND @DataVencimentoBoleto > ISNULL((SELECT TOP 1 r1.DataVencimento
		                                                                    FROM   @Result r1
		                                                                            JOIN @Result r2 ON r2.IdDebito = r1.IdDebito
		                                                                    WHERE  r1.Agrupador = 999
		                                                                    AND  r2.Agrupador <> 999), DataVencimento) THEN @DataVencimentoBoleto 
		                          WHEN @DataVencimentoBoleto IS NOT NULL 
		                           AND @TipoComposicao = 1 THEN @DataVencimentoBoleto
								  ELSE ISNULL((SELECT TOP 1 r1.DataVencimento
		                                       FROM   @Result r1
		                                              JOIN @Result r2 ON r2.IdDebito = r1.IdDebito
		                                       WHERE  r1.Agrupador = 999
		                                         AND  r2.Agrupador <> 999), DataVencimento)
		                     END
		WHERE  Agrupador = 999
			
		/*
		* Esse insert serve para inserir nos grupos de emissões com desconto os débitos que não possuem desconto. 
		* Exemplo: Imagine uma anuidade 2018 com duas faixas de desconto, outro débito tipo Taxa sem faixa de
		* desconto e uma essa SP sendo chamada com o parâmetro @EmissaoComDesconto = 3.
		* Neste exemplo, no primeiro momento será inserido na tabela @Result com o agrupador 999
		* os débitos Anuidade 2018 e a Taxa, ou seja teremos:
		*     999 - ANU 2018 - R$ 800,00
		*     999 - TX  2018 - R$ 100,00
		* Quando a SP fizer o insert referente as faixas de desconto ficará assim a tabela @Result:
		*     999 - ANU 2018 - R$ 800,00
		*     999 - TX  2018 - R$ 100,00
		*     001 - ANU 2018 - R$ 720,00 (Primeira faixa de desconto)
		*     002 - ANU 2018 - R$ 760,00 (Segunda faixa de desconto)
		* Como você já deve ter lido lá em cima a respeito desse tal de agrupador (Agrupador), ele
		* é responsável por agrupar os débitos que farão parte de cada emissão.
		* Então, desta forma, percebemos que teremos uma emissão contendo os dois débitos (agrupador 999),
		* mas as duas outras emissões (agrupador 1 e 2) só possuem o débito Anuidade.
		* Só para lembrar que quando esta SP é chamada pela usp_GerarEmissao e é passado
		* mais de um débito significa que a emissão é unificada. 
		* Diferente da tela de emissão individual que utiliza esta SP para listar os débitos a serem 
		* emitidos (mas neste caso o parâmetro @EmissaoComDesconto só virá com os valores 0 ou 1).
		* Voltando ao assunto, como os agrupadores 1 e 2 só possuem o débito anuidade e por se tratar
		* de uma emissão unificada, devem possuir todos os débitos que foram passados por parâmetro
		* é feito o insert abaixo, ficando assim:
		*     999 - ANU 2018 - R$ 800,00
		*     999 - TX  2018 - R$ 100,00
		*     001 - ANU 2018 - R$ 720,00 (Primeira faixa de desconto)
		*     001 - TX  2018 - R$ 100,00     
		*     002 - ANU 2018 - R$ 760,00 (Segunda faixa de desconto)
		*     002 - TX  2018 - R$ 100,00      
		* */
		INSERT INTO @Result
		  (
		    Agrupador,
		    IdDebito,
		    IdProfissional,
		    IdPessoaJuridica,
		    IdPessoa,
		    IdTipoDebito,
		    NumConjReneg,
		    NumConjTpDebito,
		    SiglaDebito,
		    NumeroParcela,
		    DataReferencia,
		    DataVencimento,
		    ValorDevido,
		    ValorPrincipal,
		    ValorAtualizacao,
		    ValorMulta,
		    ValorJuros,
		    ValorDesconto,
		    IdProcedimento,
		    IsentoDeEncargosParaEmissao,
		    CodErro
		  )
		SELECT DISTINCT 
		       r2.Agrupador,
		       r1.IdDebito,
		       r1.IdProfissional,
		       r1.IdPessoaJuridica,
		       r1.IdPessoa,
		       r1.IdTipoDebito,
		       r1.NumConjReneg,
		       r1.NumConjTpDebito,
		       r1.SiglaDebito,
		       r1.NumeroParcela,
		       r1.DataReferencia,
		       r2.DataVencimento,
		       r1.ValorDevido,
		       r1.ValorPrincipal,
		       r1.ValorAtualizacao,
		       r1.ValorMulta,
		       r1.ValorJuros,
		       r1.ValorDesconto,
		       r1.IdProcedimento,
		       r1.IsentoDeEncargosParaEmissao,
		       r1.CodErro
		FROM   @Result r1,
		       @Result r2
		WHERE  r1.Agrupador = 999
		       AND r2.Agrupador <> 999
		       AND r1.IdDebito NOT IN (SELECT IdDebito
		                               FROM   @Result
		                               WHERE  Agrupador <> 999)
		
	END
		
	SELECT * FROM @Result ORDER BY Agrupador, YEAR(DataReferencia) DESC, NumConjTpDebito, NumConjReneg, NumeroParcela		
END	

