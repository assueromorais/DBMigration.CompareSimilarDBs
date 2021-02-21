
CREATE FUNCTION dbo.ufn_SplitID
(
	@Texto VARCHAR(MAX)
)
RETURNS @Result TABLE ( ID INT )
BEGIN
	DECLARE @XML AS XML
	
	SET @XML = CAST(('<X>' + REPLACE(@Texto, ',', '</X><X>') + '</X>') AS XML)
		
	INSERT INTO @Result
	SELECT N.value('.', 'INT')  AS ID
	FROM   @XML.nodes('X')      AS T(N)
		
	RETURN
END
