

CREATE PROCEDURE sp_ListaContaCorrentePorDebito
	@ListaIdDebito VARCHAR(8000)
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #tblDeb
	(
		IdDebito                       INT,
		IdTipoDebito                   INT,
		AnoReferencia                  INT,
		Conflito                       BIT,
		Ano_OK                         BIT,
		IdContasCorrentes_TiposDeb     INT,
		IdContaCorrente                INT,
		IdConvenio                     INT,
		NomeDebito                     VARCHAR(30),
		IdSituacaoDebito               INT,
		IdBanco                        INT,
		msgErro                        VARCHAR(200)
	)/*DM39939*/
	
	DECLARE @tblDeb TABLE(
	            Id INT IDENTITY(1, 1),
	            IdDebito INT,
	            IdTipoDebito INT,
	            AnoReferencia INT,
	            Conflito BIT,
	            Ano_OK BIT,
	            IdContasCorrentes_TiposDeb INT,
	            IdContaCorrente INT,
	            IdConvenio INT,
	            NomeDebito VARCHAR(30),
	            IdSituacaoDebito INT,
	            IdBanco INT,
	            msgErro VARCHAR(200)
	        )/*DM39939*/
	DECLARE @IdTblDeb                       INT,
	        @idTipoDebito                   INT,
	        @AnoReferencia                  INT,
	        @Conflito                       BIT,
	        @Ano_OK                         BIT,
	        @IdContasCorrentes_TiposDeb     INT,
	        @IdDebito                       INT,
	        @IdContaCorrente                INT,
	        @IdConvenio                     INT,
	        @IdSituacaoDebito               INT,
	        @IdBanco                        INT /*39939*/
	
	
	INSERT INTO #tblDeb
	EXEC (
	         'SELECT DISTINCT IdDebito,
		   Debitos.IdTipoDebito,
		   year(DataReferencia) AnoReferencia,
		   cast(''0'' AS bit),
		   cast(''0'' AS bit),
		   0,
		   0,
		   0, NomeDebito, IdSituacaoAtual,
		   0,cast(''0'' AS Varchar)MsgErro
	FROM   Debitos
	JOIN TiposDebito td ON td.IdTipoDebito = Debitos.IdTipoDebito
	JOIN SituacoesDebito sd on sd.IdSituacaoDebito = Debitos.IdSituacaoAtual
	WHERE  IdDebito IN (' + @ListaIdDebito + ')'
	     )
	
	INSERT INTO @tblDeb
	SELECT *
	FROM   #tblDeb t
	
	DROP TABLE #tblDeb
	
	SELECT @idTblDeb = MIN(id)
	FROM   @tblDeb
	
	
	WHILE @IdTblDeb IS NOT NULL
	BEGIN
	    SELECT @idTipoDebito = IdTipoDebito,
	           @AnoReferencia     = AnoReferencia
	    FROM   @tblDeb
	    WHERE  id                 = @IdTblDeb
	    
	    /* se existe tipo configurado DM39939    */
	    IF EXISTS (
	           SELECT TOP 1 1
	           FROM   ContasCorrentes_TiposDeb cctd
	                  LEFT JOIN ContasCorrentes AS cc
	                       ON  cc.IdContaCorrente = cctd.IdContaCorrente
	                  LEFT JOIN Convenios AS c
	                       ON  c.IdConvenio = cctd.IdConvenio
	           WHERE  cctd.IdTipoDebito = @idTipoDebito
	                  AND ISNULL(cc.SituacaoContaCorrente, 0) = 0
	                  AND ISNULL(c.SituacaoConvenio, 0) = 0
	       )
	    BEGIN
	        /* se existe ano para o tipo DM39939*/
	        IF EXISTS (
	               SELECT TOP 1 1
	               FROM   ContasCorrentes_Anos_TiposDeb ccatd
	                      JOIN ContasCorrentes_TiposDeb cctd
	                           ON  cctd.IdContasCorrentes_TiposDeb = ccatd.IdContasCorrentes_TiposDeb
	               WHERE  cctd.IdTipoDebito = @idTipoDebito
	           )
	        BEGIN
	            /* se o ano do debito é o mesmo configurado DM39939*/
	            IF @AnoReferencia = (
	                   SELECT TOP 1 ISNULL(AnoReferencia, 0)
	                   FROM   ContasCorrentes_Anos_TiposDeb ccatd
	                   WHERE  ccatd.AnoReferencia = @AnoReferencia
	                          AND ccatd.IdContasCorrentes_TiposDeb IN (SELECT 
	                                                                          cctd.IdContasCorrentes_TiposDeb
	                                                                   FROM   
	                                                                          ContasCorrentes_TiposDeb 
	                                                                          cctd
	                                                                   WHERE  
	                                                                          cctd.IdTipoDebito = 
	                                                                          @idTipoDebito)
	               )
	            BEGIN
	                SELECT @Ano_OK = 1            
	                SELECT @IdContasCorrentes_TiposDeb = (
	                           SELECT TOP 1 IdContasCorrentes_TiposDeb
	                           FROM   ContasCorrentes_Anos_TiposDeb ccatd
	                           WHERE  ccatd.AnoReferencia = @AnoReferencia
	                                  AND ccatd.IdContasCorrentes_TiposDeb IN (SELECT 
	                                                                                  cctd.IdContasCorrentes_TiposDeb
	                                                                           FROM   
	                                                                                  ContasCorrentes_TiposDeb 
	                                                                                  cctd
	                                                                           WHERE  
	                                                                                  cctd.IdTipoDebito = 
	                                                                                  @idTipoDebito)
	                       )
	            END
	            ELSE
	            BEGIN
	                SELECT @Ano_OK = 0
	                SELECT @IdContasCorrentes_TiposDeb = 0
	                
	                /* se existe banco padrão DM39939 OC53306 */
	                IF EXISTS (
	                       SELECT TOP 1 1
	                       FROM   ParametrosSiscafw ps
	                       WHERE  ps.IdBancoPadrao IS NOT NULL
	                              AND ps.IdBancoPadrao <> 0
	                   )
	                BEGIN
	                    /* se existe conta padrão DM39939 OC53306*/
	                    IF EXISTS (
	                           SELECT TOP 1 1
	                           FROM   BancosSiscafw bs
	                           WHERE  bs.IdContaCorrentePadrao IS NOT NULL
	                                  AND bs.IdContaCorrentePadrao <> 0
	                                  AND bs.idBancoSiscafw = (
	                                          SELECT IdBancoPadrao
	                                          FROM   ParametrosSiscafw ps
	                                          WHERE  ps.IdBancoPadrao IS NOT 
	                                                 NULL
	                                                 AND ps.IdBancoPadrao <> 0
	                                      )
	                       )
	                    BEGIN
	                        /* se BB pega convenio DM39939 */
	                        IF (
	                               SELECT TOP 1 ps.IdBancoPadrao
	                               FROM   ParametrosSiscafw ps
	                               WHERE  ps.IdBancoPadrao IS NOT NULL
	                           ) = 1
	                        BEGIN
	                            IF EXISTS(
	                                   SELECT cc.IdConvenioPadrao
	                                   FROM   ContasCorrentes cc
	                                   WHERE  cc.IdBancoSiscafw IN (SELECT ps.IdBancoPadrao
	                                                                FROM   
	                                                                       ParametrosSiscafw 
	                                                                       ps
	                                                                WHERE  ps.IdBancoPadrao 
	                                                                       IS 
	                                                                       NOT 
	                                                                       NULL)
	                                          AND cc.IdConvenioPadrao IS NOT 
	                                              NULL
	                               )
	                            BEGIN
	                                UPDATE tmp
	                                SET    IdConvenio = (
	                                           SELECT TOP 1 c.IdConvenio
	                                           FROM   Convenios c
	                                           WHERE  c.IdConvenio IN (SELECT cc.IdConvenioPadrao
	                                                                   FROM   
	                                                                          ContasCorrentes 
	                                                                          cc
	                                                                   WHERE  cc.IdBancoSiscafw IN (SELECT 
	                                                                                                       ps.IdBancoPadrao
	                                                                                                FROM   
	                                                                                                       ParametrosSiscafw 
	                                                                                                       ps
	                                                                                                WHERE  
	                                                                                                       ps.IdBancoPadrao 
	                                                                                                       IS 
	                                                                                                       NOT 
	                                                                                                       NULL))
	                                       ),
	                                       IdContaCorrente = NULL
	                                FROM   @tblDeb tmp
	                                WHERE  id = @IdTblDeb
	                            END
	                            ELSE
	                            BEGIN
	                                UPDATE tmp
	                                SET    IdConvenio = 0,
	                                       IdContaCorrente = NULL
	                                FROM   @tblDeb tmp
	                                WHERE  id = @IdTblDeb
	                            END
	                        END
	                        ELSE
	                        BEGIN
	                            UPDATE tmp
	                            SET    IdContaCorrente = (
	                                       SELECT TOP 1 cc.IdContaCorrente
	                                       FROM   ContasCorrentes cc
	                                       WHERE  cc.IdContaCorrente IN (SELECT 
	                                                                            bs.IdContaCorrentePadrao
	                                                                     FROM   
	                                                                            BancosSiscafw 
	                                                                            bs
	                                                                     WHERE  
	                                                                            bs.IdBancoSiscafw IN (SELECT 
	                                                                                                         ps.IdBancoPadrao
	                                                                                                  FROM   
	                                                                                                         ParametrosSiscafw 
	                                                                                                         ps
	                                                                                                  WHERE  
	                                                                                                         ps.IdBancoPadrao 
	                                                                                                         IS 
	                                                                                                         NOT 
	                                                                                                         NULL))
	                                   ),
	                                   IdConvenio = NULL
	                            FROM   @tblDeb tmp
	                            WHERE  id = @IdTblDeb
	                        END
	                    END
	                    ELSE
	                    BEGIN
	                        UPDATE @tblDeb
	                        SET    Conflito = 1,
	                               IdContaCorrente = 0
	                    END
	                END
	                ELSE
	                BEGIN
	                    UPDATE @tblDeb
	                    SET    Conflito = 1,
	                           IdContaCorrente = 0,
	                           IdConvenio = 0
	                END
	            END 
	            UPDATE @tblDeb
	            SET    Ano_OK     = @Ano_OK,
	                   IdContasCorrentes_TiposDeb = @IdContasCorrentes_TiposDeb
	            WHERE  id         = @IdTblDeb
	        END
	        ELSE
	        BEGIN
	            SELECT @IdContasCorrentes_TiposDeb = (
	                       SELECT TOP 1 cctd.IdContasCorrentes_TiposDeb
	                       FROM   ContasCorrentes_TiposDeb cctd
	                       WHERE  cctd.IdTipoDebito = @idTipoDebito
	                   )
	            
	            UPDATE @tblDeb
	            SET    Ano_OK     = 1,
	                   IdContasCorrentes_TiposDeb = @IdContasCorrentes_TiposDeb
	            WHERE  id         = @IdTblDeb
	        END
	    END
	    ELSE
	        /* tipo de débito não configurado DM39939*/
	    BEGIN
	        /* se existe banco padrão DM39939 OC53306*/
	        IF EXISTS (
	               SELECT TOP 1 1
	               FROM   ParametrosSiscafw ps
	               WHERE  ps.IdBancoPadrao IS NOT NULL
	                      AND ps.IdBancoPadrao <> 0
	           )
	        BEGIN
	            /* se existe conta padrão DM39939 OC53306*/
	            IF EXISTS (
	                   SELECT TOP 1 1
	                   FROM   BancosSiscafw bs
	                   WHERE  bs.IdContaCorrentePadrao IS NOT NULL
	                          AND bs.IdContaCorrentePadrao <> 0
	                          AND bs.idBancoSiscafw = (
	                                  SELECT IdBancoPadrao
	                                  FROM   ParametrosSiscafw ps
	                                  WHERE  ps.IdBancoPadrao IS NOT NULL
	                                         AND ps.IdBancoPadrao <> 0
	                              )
	               )
	            BEGIN
	                /* se BB pega ou CX SIGCB convenio DM39939*/
	                IF (
	                       SELECT TOP 1 ps.IdBancoPadrao
	                       FROM   ParametrosSiscafw ps
	                       WHERE  ps.IdBancoPadrao IS NOT NULL
	                   ) = 1
	                   /*DM39939***********************************************/
	                   OR (
	                          (
	                              (
	                                  SELECT TOP 1 ps.IdBancoPadrao
	                                  FROM   ParametrosSiscafw ps
	                                  WHERE  ps.IdBancoPadrao IS NOT NULL
	                              ) = 2
	                          )
	                          AND (
	                                  SELECT LeiauteCnab
	                                  FROM   ContasCorrentes cc
	                                  WHERE  cc.IdBancoSiscafw = (
	                                             SELECT TOP 1 ps2.IdBancoPadrao
	                                             FROM   ParametrosSiscafw ps2
	                                         )
	                                         AND cc.IdContaCorrente = (
	                                                 SELECT TOP 1 bs.IdContaCorrentePadrao
	                                                 FROM   BancosSiscafw bs
	                                                 WHERE  bs.IdContaCorrentePadrao 
	                                                        IS NOT NULL
	                                             )
	                              ) = 1
	                      ) 
	                      /********************************************************/
	                BEGIN
	                    IF EXISTS(
	                           SELECT cc.IdConvenioPadrao
	                           FROM   ContasCorrentes cc
	                           WHERE  cc.IdBancoSiscafw IN (SELECT ps.IdBancoPadrao
	                                                        FROM   
	                                                               ParametrosSiscafw 
	                                                               ps
	                                                        WHERE  ps.IdBancoPadrao 
	                                                               IS NOT NULL)
	                                  AND cc.IdConvenioPadrao IS NOT NULL
	                       )
	                    BEGIN
	                        UPDATE tmp
	                        SET    IdConvenio = (
	                                   SELECT TOP 1 c.IdConvenio
	                                   FROM   Convenios c
	                                   WHERE  c.IdConvenio IN (SELECT cc.IdConvenioPadrao
	                                                           FROM   
	                                                                  ContasCorrentes 
	                                                                  cc
	                                                           WHERE  cc.IdBancoSiscafw IN (SELECT 
	                                                                                               ps.IdBancoPadrao
	                                                                                        FROM   
	                                                                                               ParametrosSiscafw 
	                                                                                               ps
	                                                                                        WHERE  
	                                                                                               ps.IdBancoPadrao 
	                                                                                               IS 
	                                                                                               NOT 
	                                                                                               NULL))
	                               ),
	                               IdContaCorrente = NULL
	                        FROM   @tblDeb tmp
	                        WHERE  id = @IdTblDeb
	                    END
	                    ELSE
	                    BEGIN
	                        UPDATE tmp
	                        SET    IdConvenio = 0,
	                               IdContaCorrente = NULL,
	                               msgErro = 'Não existe convênio padrão.',
	                               Conflito = 1 /*DM39939*/
	                        FROM   @tblDeb tmp
	                        WHERE  id = @IdTblDeb
	                    END
	                END
	                ELSE
	                BEGIN
	                    UPDATE tmp
	                    SET    IdContaCorrente = (
	                               SELECT TOP 1 cc.IdContaCorrente
	                               FROM   ContasCorrentes cc
	                               WHERE  cc.IdContaCorrente IN (SELECT bs.IdContaCorrentePadrao
	                                                             FROM   
	                                                                    BancosSiscafw 
	                                                                    bs
	                                                             WHERE  bs.IdBancoSiscafw IN (SELECT 
	                                                                                                 ps.IdBancoPadrao
	                                                                                          FROM   
	                                                                                                 ParametrosSiscafw 
	                                                                                                 ps
	                                                                                          WHERE  
	                                                                                                 ps.IdBancoPadrao 
	                                                                                                 IS 
	                                                                                                 NOT 
	                                                                                                 NULL))
	                           ),
	                           IdConvenio = NULL
	                    FROM   @tblDeb tmp
	                    WHERE  id = @IdTblDeb
	                END
	            END
	            ELSE
	            BEGIN
	                UPDATE @tblDeb
	                SET    Conflito     = 1,
	                       IdContaCorrente = 0,
	                       msgErro      = 'Não existe conta padrão.' /*DM39939*/
	            END
	        END
	        ELSE
	        BEGIN
	            UPDATE @tblDeb
	            SET    Conflito            = 1,
	                   IdContaCorrente     = 0,
	                   IdConvenio          = 0,
	                   msgErro             = 'Não existe banco padrão.'/*DM39939*/
	        END
	    END    
	    SELECT @idTblDeb = MIN(id)
	    FROM   @tblDeb
	    WHERE  id > @IdTblDeb
	END
	
	/*DM38289*/
	UPDATE tmp
	SET    IdContaCorrente = cctd.IdContaCorrente,
	       IdConvenio = cctd.IdConvenio
	FROM   @tblDeb tmp
	       JOIN ContasCorrentes_TiposDeb cctd
	            ON  tmp.IdContasCorrentes_TiposDeb = cctd.IdContasCorrentes_TiposDeb
	/********/
	
	UPDATE @tblDeb
	SET    Conflito = 1
	WHERE  (
	           SELECT COUNT(*)
	           FROM   (
	                      SELECT DISTINCT CASE 
	                                           WHEN ISNULL(IdConvenio, 0) > 1 THEN 
	                                                IdConvenio
	                                           ELSE IdContaCorrente
	                                      END AS IdContasCorrentes_TiposDeb /*DM38289*/
	                      FROM   @tblDeb
	                  ) x
	       ) > 1
	
	UPDATE tmp
	SET    Conflito = CASE 
	                       WHEN tmp.IdConvenio <> 0 AND tmp.IdContaCorrente IS 
	                            NULL THEN (
	                                CASE 
	                                     WHEN EXISTS (
	                                              SELECT TOP 1 1
	                                              FROM   
	                                                     ContasCorrentes_SituacoesDeb 
	                                                     ccsd2
	                                              WHERE  ccsd2.IdConvenio = tmp.idConvenio
	                                          ) THEN CASE 
	                                                      WHEN EXISTS (
	                                                               SELECT TOP 1 
	                                                                      1
	                                                               FROM   
	                                                                      ContasCorrentes_SituacoesDeb 
	                                                                      ccsd
	                                                               WHERE  ccsd.IdConvenio = 
	                                                                      tmp.IdConvenio
	                                                                      AND 
	                                                                          ccsd.IdSituacaoDebito = 
	                                                                          tmp.IdSituacaoDebito
	                                                           ) THEN '0'
	                                                      ELSE '1'
	                                                 END
	                                     WHEN NOT EXISTS (
	                                              SELECT TOP 1 1
	                                              FROM   
	                                                     ContasCorrentes_SituacoesDeb 
	                                                     ccsd2
	                                              WHERE  ccsd2.IdConvenio = tmp.IdConvenio
	                                          ) THEN '0'
	                                END
	                            )
	                       WHEN tmp.IdContaCorrente IS NOT NULL THEN (
	                                CASE 
	                                     WHEN EXISTS (
	                                              SELECT TOP 1 1
	                                              FROM   
	                                                     ContasCorrentes_SituacoesDeb 
	                                                     ccsd2
	                                              WHERE  ccsd2.IdContaCorrente = 
	                                                     tmp.IdContaCorrente
	                                          ) THEN CASE 
	                                                      WHEN EXISTS (
	                                                               SELECT TOP 1 
	                                                                      1
	                                                               FROM   
	                                                                      ContasCorrentes_SituacoesDeb 
	                                                                      ccsd
	                                                               WHERE  ccsd.IdContaCorrente = 
	                                                                      tmp.IdContaCorrente
	                                                                      AND 
	                                                                          ccsd.IdSituacaoDebito = 
	                                                                          tmp.IdSituacaoDebito
	                                                           ) THEN '0'
	                                                      ELSE '1'
	                                                 END
	                                     WHEN NOT EXISTS (
	                                              SELECT TOP 1 1
	                                              FROM   
	                                                     ContasCorrentes_SituacoesDeb 
	                                                     ccsd2
	                                              WHERE  ccsd2.IdContaCorrente = 
	                                                     tmp.IdContaCorrente
	                                          ) THEN '0'
	                                END
	                            )
	                  END
	       /*DM39939*************************************************/,
	       tmp.IdBanco = CASE 
	                          WHEN tmp.IdContaCorrente IS NOT NULL THEN (
	                                   SELECT IdBancoSiscafw
	                                   FROM   ContasCorrentes cc
	                                   WHERE  cc.IdContaCorrente = tmp.IdContaCorrente
	                               )
	                          ELSE (
	                                   SELECT IdBancoSiscafw
	                                   FROM   ContasCorrentes cc
	                                   WHERE  cc.IdContaCorrente = (
	                                              SELECT TOP 1 IdContaCorrente
	                                              FROM   Convenios c
	                                              WHERE  c.IdConvenio = tmp.IdConvenio
	                                          )
	                               )
	                     END 
	       /********************************************************/
	FROM   @tblDeb tmp
	WHERE  Conflito <> 1
	
	/** Oc. 79081 *******************************************************/
	IF EXISTS (
	       SELECT TOP 1                 1
	       FROM   Pessoas,
	              ParametrosSiscafW
	       WHERE  E_ConselhoProfissao = 1
	              AND IdPessoa = IdConselhoCorrente
	              AND Pessoas.Sigla     LIKE 'CRTR%'
	   )
	BEGIN
	    UPDATE @tblDeb
	    SET    IdBanco             = 0,
	           IdContaCorrente     = 0,
	           IdConvenio          = 0,
	           Conflito            = 1
	    WHERE  IdBanco NOT IN (1, 2)
	END
	/*********************************************************/
	
	SELECT *
	FROM   @tblDeb
END	
