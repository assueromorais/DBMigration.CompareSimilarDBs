
CREATE FUNCTION dbo.RetiraAcento (@Texto varchar(8000))
RETURNS varchar(8000)
AS
BEGIN
	SET @Texto  = Replace(@Texto, 'Ã�', 'A')
	SET @Texto  = Replace(@Texto, 'Ã€', 'A')
	SET @Texto  = Replace(@Texto, 'Ãƒ', 'A')
	SET @Texto  = Replace(@Texto, 'Ã‚', 'A')
	SET @Texto  = Replace(@Texto, 'Ã„', 'A')

	SET @Texto  = Replace(@Texto, 'Ã‰', 'E')
	SET @Texto  = Replace(@Texto, 'Ãˆ', 'E')
	SET @Texto  = Replace(@Texto, 'ÃŠ', 'E')
	SET @Texto  = Replace(@Texto, 'Ã‹', 'E')

	SET @Texto  = Replace(@Texto, 'Ã�', 'I')
	SET @Texto  = Replace(@Texto, 'ÃŒ', 'I')
	SET @Texto  = Replace(@Texto, 'ÃŽ', 'I')
	SET @Texto  = Replace(@Texto, 'Ã�', 'I')

	SET @Texto  = Replace(@Texto, 'Ã“', 'O')
	SET @Texto  = Replace(@Texto, 'Ã’', 'O')
	SET @Texto  = Replace(@Texto, 'Ã•', 'O')
	SET @Texto  = Replace(@Texto, 'Ã”', 'O')
	SET @Texto  = Replace(@Texto, 'Ã–', 'O')

	SET @Texto  = Replace(@Texto, 'Ãš', 'U')
	SET @Texto  = Replace(@Texto, 'Ã™', 'U')
	SET @Texto  = Replace(@Texto, 'Ã›', 'U')
	SET @Texto  = Replace(@Texto, 'Ãœ', 'U')

	SET @Texto  = Replace(@Texto, 'Ã‡', 'C')
	RETURN(@Texto)
END
