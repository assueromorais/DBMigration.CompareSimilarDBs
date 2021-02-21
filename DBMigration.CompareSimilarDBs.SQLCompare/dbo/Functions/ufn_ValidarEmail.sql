
CREATE FUNCTION dbo.ufn_ValidarEmail
(
	@email VARCHAR(255)
)
RETURNS BIT
AS
BEGIN
	DECLARE @valid BIT 
	
	SET @valid = 0
	 
	IF @email IS NOT NULL
	    SET @email = RTRIM(LTRIM(LOWER(@email)))
		
	IF @email LIKE '[a-z,0-9,_,--]%@[a-z,0-9,_,--]%.[a-z][a-z]%'
	   AND PATINDEX('%[^a-z,0-9,@,.,--,_]%',@email COLLATE Latin1_General_BIN2) = 0
	   AND @email NOT LIKE '%@%@%'
	   AND CHARINDEX('.@', @email) = 0
	   AND CHARINDEX('..', @email) = 0
	   AND CHARINDEX(',', @email) = 0
	   AND RIGHT(@email, 1) BETWEEN 'a' AND 'z'
	    SET @valid = 1
	
	RETURN @valid
END

