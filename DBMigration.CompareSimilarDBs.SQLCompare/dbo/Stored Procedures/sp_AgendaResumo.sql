CREATE PROCEDURE dbo.sp_AgendaResumo @Data AS DateTime
AS
BEGIN

	SELECT
	Id,
	Texto = CASE WHEN NumTipo = 1 THEN
			CASE WHEN DataPrevisao < @Data THEN sTexto + ' ('+ CONVERT(VARCHAR(10),DataPrevisao,103)+ ' - '+CONVERT(VARCHAR(3),DATEDIFF(day, DataPrevisao, @Data))+' Dia(s) Atraso)' ELSE sTexto END		
		     WHEN NumTipo = 2 THEN
			CASE WHEN DataPrevisao < @Data THEN sTexto + ' ('+ CONVERT(VARCHAR(10),DataPrevisao,103)+ ' - '+CONVERT(VARCHAR(3),DATEDIFF(day, DataPrevisao, @Data))+' Dia(s) Atraso)' ELSE sTexto END
		     WHEN NumTipo = 3 THEN
			CASE WHEN DataPrevisao < @Data THEN sTexto + ' (Débito - '+ CONVERT(VARCHAR(10),DataPrevisao,103)+ ' - '+CONVERT(VARCHAR(3),DATEDIFF(day, DataPrevisao, @Data))+' Dia(s) Atraso)' ELSE sTexto + ' (Débito)' END
		     WHEN NumTipo = 4 THEN
			CASE WHEN DataPrevisao < @Data THEN sTexto + ' (Crédito - '+ CONVERT(VARCHAR(10),DataPrevisao,103)+ ' - '+CONVERT(VARCHAR(3),DATEDIFF(day, DataPrevisao, @Data))+' Dia(s) Atraso)' ELSE sTexto + ' (Crédito)' END
		     WHEN NumTipo = 5 THEN
			CASE WHEN DataPrevisao < @Data THEN sTexto + ' (Resgate - '+ CONVERT(VARCHAR(10),DataPrevisao,103)+ ' - '+CONVERT(VARCHAR(3),DATEDIFF(day, DataPrevisao, @Data))+' Dia(s) Atraso)' ELSE sTexto + ' (Resgate)' END
		     WHEN NumTipo = 6 THEN
			CASE WHEN DataPrevisao < @Data THEN sTexto + ' (Aplicação - '+ CONVERT(VARCHAR(10),DataPrevisao,103)+ ' - '+CONVERT(VARCHAR(3),DATEDIFF(day, DataPrevisao, @Data))+' Dia(s) Atraso)' ELSE sTexto + ' (Aplicação)' END
		END,
	Valor,
	Tipo
	FROM vw_AgendaResumo
	WHERE DataPrevisao <= @Data

END
