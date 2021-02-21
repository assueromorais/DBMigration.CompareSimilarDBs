/*Oc.128274 - Sergio*/ 
CREATE FUNCTION [dbo].[FormataConta](@CodConta Varchar(18), @Grupo INT)
RETURNS VARCHAR(27)
AS
BEGIN
	DECLARE @contaformatada Varchar(27), @i int	
	set @contaformatada= Left(@codconta, 1)
	If @grupo> 2 
	begin
	  set @i= 2
	  while @i <= len(@codconta)
	   begin    
		If @i < 4
				set @contaformatada= @contaformatada + '.'
		Else
		If @i % 2 = 1 
		 set @contaformatada= @contaformatada + '.'
		set @contaformatada= @contaformatada + substring(@codconta,@i,1)
		set @i= (@i + 1)
	   End
	End
	Else
	Begin        
	  set @i= 2
	  while @i <= len(@codconta)
	   begin   
		If @i < 5
				set @contaformatada= @contaformatada + '.'
		Else
		If @i % 2 = 0 
		 set @contaformatada= @contaformatada + '.'
		set @contaformatada= @contaformatada + substring(@codconta,@i,1)
		set @i= @i + 1
	   END
	END  
	
	RETURN(@contaformatada)
END
