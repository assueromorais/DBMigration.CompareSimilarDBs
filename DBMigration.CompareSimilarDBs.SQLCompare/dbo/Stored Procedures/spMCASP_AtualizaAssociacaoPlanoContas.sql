/* Lucimara - 23/08/2011 - SG - Oc. 80431 */

CREATE procedure [dbo].[spMCASP_AtualizaAssociacaoPlanoContas] (
@TipoAtualizacao tinyint, @IdConta int, @IdPlanoContaMCASP VARCHAR(50),
@CodContaMCASP VARCHAR(50), @NomeContaMCASP VARCHAR(100))
as

  /* 
  Tipo Atualização
  1 - Inclusão
  2 - Exclusão
  */
     
  Declare @CodErro tinyint, @MsgErro varchar(60),
  		  @CodContaDefinido VARCHAR(18), @GrupoDefinido INT, @NomeContaDefinido VARCHAR(50)
   
  Set @CodErro = 0
  Set @MsgErro = 'Atualização com Sucesso'
   
  ---------------------  Inicio Validação  -----------------------
  
  IF @TipoAtualizacao NOT IN (1,2)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Tipo de atualização inválida!'
  End

  IF Exists (Select 1 from dbo.AssociacaoPlanoContasMCASP where IdConta = @IdConta) and
     @TipoAtualizacao = 1
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta já associada!'
  End
  

  IF Not Exists (Select 1 from dbo.PlanoContas where IdConta=@IdConta) and
     @TipoAtualizacao = 1
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta informada inválida!'
  END
    
  IF Not Exists (Select 1 from dbo.AssociacaoPlanoContasMCASP where IdConta = @IdConta) and
     @TipoAtualizacao = 2
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta informada não encontrada!'
  End
    

  IF (@IdPlanoContaMCASP is null) and (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Conta MCASP inválida'
  END
  
  IF ((@CodContaMCASP is null) OR (@CodContaMCASP = '')) AND (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Nome da Conta MCASP inválido'
  End  
  
  IF ((@NomeContaMCASP is null) OR (@NomeContaMCASP = '')) AND (@TipoAtualizacao = 1)
  Begin
     Set @CodErro = 1
	 Set @MsgErro = 'Nome da Conta MCASP inválido'
  End
  
  ------------ Início Inclusão /Exclusão --------------
  IF @CodErro = 0
  Begin
    /* Inclusão */
	IF @TipoAtualizacao = 1
	BEGIN	
		/*Verificando os Id´s Conta de exercícios anteriores 
		* para incluir na tabela de associação
		*/
		SELECT @CodContaDefinido = pc.CodConta,
		       @GrupoDefinido = pc.Grupo,
		       @NomeContaDefinido = pc.NomeConta
		FROM   PlanoContas pc
		WHERE  pc.IdConta = @IdConta
		
		
		INSERT INTO dbo.AssociacaoPlanoContasMCASP
		  (
		    IdConta,
		    IdPlanoContaMCASP,
		    NomeContaMCASP,
		    CodContaMCASP
		  )
		SELECT pc2.IdConta,
		       @IdPlanoContaMCASP,
		       @NomeContaMCASP,
		       @CodContaMCASP
		FROM   PlanoContas pc2
		WHERE  pc2.CodConta = @CodContaDefinido
		       AND pc2.NomeConta = @NomeContaDefinido
		       AND pc2.Grupo = @GrupoDefinido
	    
	    /*Insert into dbo.AssociacaoPlanoContasMCASP (IdConta, IdPlanoContaMCASP, CodContaMCASP, NomeContaMCASP)
	              Values (@IdConta, @IdPlanoContaMCASP, @CodContaMCASP, @NomeContaMCASP) */
	                                
		Set @MsgErro = 'Conta incluída com sucesso.'
    End
    
    
    /* Exclusão */
	IF @TipoAtualizacao = 2
	Begin    
		SELECT @CodContaDefinido = pc.CodConta,
		       @GrupoDefinido = pc.Grupo,
		       @NomeContaDefinido = pc.NomeConta
		FROM   PlanoContas pc
		WHERE  pc.IdConta = @IdConta		
		
		DELETE 
		FROM   dbo.AssociacaoPlanoContasMCASP
		WHERE  IdConta IN (SELECT pc2.IdConta
		                   FROM   PlanoContas pc2
		                   WHERE  pc2.CodConta = @CodContaDefinido
		                          AND pc2.NomeConta = @NomeContaDefinido
		                          AND pc2.Grupo = @GrupoDefinido)

		/*Delete From dbo.AssociacaoPlanoContasMCASP Where IdConta=@IdConta*/
		
		Set @MsgErro = 'Conta associada excluída.'
	END				
  End 
--------------------- Retornando o Resultado ---------------------

Select CodErro=@CodErro, MsgErro=@MsgErro 
