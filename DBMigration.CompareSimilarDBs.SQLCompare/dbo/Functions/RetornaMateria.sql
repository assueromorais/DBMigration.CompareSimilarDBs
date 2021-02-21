
CREATE FUNCTION [dbo].[RetornaMateria] (@Id int)

	RETURNS VARCHAR(400)
	AS
BEGIN
	DECLARE @Retorno VARCHAR(1000)
	DECLARE @Resultado VARCHAR(1000)
	SET @Resultado = ''
	SET @Retorno = ''
	DECLARE cur
	CURSOR FAST_FORWARD FOR
		 
		SELECT 
			(SELECT IsNull(Descricao,'-') FROM ProcessosLista1
				PL,Processos_ProcessosLista1 PPL 
				WHERE      
				PL.IdProcessoLista1 = PPL.IdProcessoLista1      
				AND PPL.IdProcesso = Suspensoes.IdProcesso
				AND PPL.IdProcessoLista1 = Processos_ProcessosLista1.IdProcessoLista1
				
				)
   
				FROM Profissionais	
				inner join Processos_Prof_PJ on Processos_Prof_PJ.IdProfissional = Profissionais.IdProfissional
				inner join Processos on Processos_Prof_PJ.IdProcesso = Processos.IdProcesso 
				inner join suspensoes on suspensoes.IdProcesso = processos.IdProcesso 
				inner join Processos_ProcessosLista1 on Processos.IdProcesso = Processos_ProcessosLista1.IdProcesso
				inner join ProcessosLista1 on Processos_ProcessosLista1.IdProcessoLista1 = ProcessosLista1.IdProcessoLista1
				WHERE Processos.IdProcesso = @id
		
		OPEN cur	
		FETCH NEXT FROM cur
		INTO @Retorno
		WHILE @@FETCH_STATUS = 0  
		BEGIN		
			if @Resultado = ''
				SET @Resultado = @Retorno
			else
			    SET @Resultado	= @Resultado + ' - ' + @Retorno	

			
			FETCH NEXT FROM cur
			INTO @Retorno
		END
		CLOSE cur
		DEALLOCATE cur


		RETURN(@Resultado)
END
