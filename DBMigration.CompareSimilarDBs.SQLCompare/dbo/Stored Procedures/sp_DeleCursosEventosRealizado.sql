

/*OC19718-19885*/
CREATE Procedure dbo.sp_DeleCursosEventosRealizado @IdProfissional Int

AS
SET NOCOUNT ON
/* CURSOR PARA DELEÇÃO DOS DOCUMENTOS REGISTRADOS PARA OS CURSOS*/
DECLARE @IdCursoEventoRealizado Int
DECLARE cursor_CursoEvento CURSOR FAST_FORWARD READ_ONLY
FOR SELECT IdCursoEventoRealizado
      FROM CursosEventosRealizado
     WHERE IdProfissional = @IdProfissional AND E_Curso=1
OPEN cursor_CursoEvento
FETCH NEXT FROM cursor_CursoEvento INTO @IdCursoEventoRealizado
WHILE (@@fetch_status <> -1)
BEGIN
  DELETE FROM RegistrosCursos 
   WHERE IdCursoEventoRealizado = @IdCursoEventoRealizado
  FETCH NEXT FROM cursor_CursoEvento INTO @IdCursoEventoRealizado
END
CLOSE cursor_CursoEvento
DEALLOCATE cursor_CursoEvento
/* DELEÇÃO DOS CURSOS E EVENTOS DO PROFISSIONAL*/
DELETE FROM CursosEventosRealizado
      WHERE IdProfissional = @IdProfissional /*AND E_Curso=1 - COMENTADA OC19718*/
/* DELEÇÃO DAS ESPECIALIDADES DO PROFISSIONAL*/
DELETE FROM EspecialidadesProfissional 
      WHERE IdProfissional = @IdProfissional
SET NOCOUNT OFF




