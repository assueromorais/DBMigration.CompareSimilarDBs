CREATE TABLE [dbo].[Profissionais_CategoriasProf] (
    [IdProfissionalCategoriaProf]         INT          IDENTITY (1, 1) NOT NULL,
    [IdCategoriaProf]                     INT          NULL,
    [IdTipoInscricao]                     INT          NULL,
    [IdProfissional]                      INT          NOT NULL,
    [RegistroConselho]                    VARCHAR (20) NULL,
    [DataInicio]                          DATETIME     NULL,
    [DataFim]                             DATETIME     NULL,
    [IdMotivoInscricao]                   INT          NULL,
    [DataUltimaAtualizacao]               DATETIME     NULL,
    [UsuarioUltimaAtualizacao]            VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao]       VARCHAR (60) NULL,
    [DataDeferimento]                     DATETIME     NULL,
    [IdProcesso]                          INT          NULL,
    [Livro]                               VARCHAR (10) NULL,
    [Folha]                               VARCHAR (10) NULL,
    [IdProfissionalCategoriaProfmigracao] INT          NULL,
    CONSTRAINT [PK_Profissionais_CategoriasProf] PRIMARY KEY NONCLUSTERED ([IdProfissionalCategoriaProf] ASC),
    CONSTRAINT [FK_Profissionais_CategoriasProf_CategoriasProf] FOREIGN KEY ([IdCategoriaProf]) REFERENCES [dbo].[CategoriasProf] ([IdCategoriaProf]),
    CONSTRAINT [FK_Profissionais_CategoriasProf_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_Profissionais_CategoriasProf_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Profissionais_CategoriasProf_TiposInscricao] FOREIGN KEY ([IdTipoInscricao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ProfissionaisCategoria_MotivoInscricao] FOREIGN KEY ([IdMotivoInscricao]) REFERENCES [dbo].[MotivoInscricao] ([IdMotivoInscricao])
);


GO
/* 
*  Autor: Ana Karla Messias / Wesley
*  OC. 223120
*  Cliente: CRP-BA
*  Data: 24-05-2019
*  Descrição: Trigger criada para impedir a alteração do número do registro para outro número caso esteja marcado a configuração de registro automático
*/
 
CREATE TRIGGER [dbo].[Trg_RegistroConselho]
ON [dbo].[Profissionais_CategoriasProf] 
   INSTEAD OF INSERT, UPDATE
AS
    DECLARE @IdProfissionalCategoriaProf INT, @RegistroConselho VARCHAR(20), @IdProfissional INT
    
    
    
    SELECT @IdProfissionalCategoriaProf = IdProfissionalCategoriaProf , 
           @RegistroConselho            = RegistroConselho,
           @IdProfissional              = IdProfissional
    FROM   INSERTED 
    
    
    --==============================================================================
    --UPDATE
    --==============================================================================
    IF (SELECT COUNT(*) FROM INSERTED )>=1 AND (SELECT COUNT(*) FROM DELETED)>=1 
    BEGIN
        BEGIN TRAN 
        IF  (SELECT dbo.RegistroConselho_IsValido(@RegistroConselho, @IdProfissional)) = 0
        BEGIN
            RAISERROR (
                'REGISTRO CONSELHO NÃO PODE SER ALTERADO PARA OUTRA NUMERAÇÃO'
               ,16
               ,1
            );
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        ELSE
        BEGIN
            UPDATE Profissionais_CategoriasProf
            SET    IdCategoriaProf = i.IdCategoriaProf
                  ,IdTipoInscricao = i.IdTipoInscricao
                  ,IdProfissional = i.IdProfissional
                  ,RegistroConselho = i.RegistroConselho
                  ,DataInicio = i.DataInicio
                  ,DataFim = i.DataFim
                  ,IdMotivoInscricao = i.IdMotivoInscricao
                  ,DataUltimaAtualizacao = i.DataUltimaAtualizacao
                  ,UsuarioUltimaAtualizacao = i.UsuarioUltimaAtualizacao
                  ,DepartamentoUltimaAtualizacao = i.DepartamentoUltimaAtualizacao
                  ,DataDeferimento = i.DataDeferimento
                  ,IdProcesso = i.IdProcesso
                  ,Livro = i.Livro
                  ,Folha = i.Folha
                  ,IdProfissionalCategoriaProfmigracao = I.IdProfissionalCategoriaProfmigracao
            FROM   Profissionais_CategoriasProf AS pcp
                   JOIN INSERTED AS I
                        ON  PCP.IdProfissionalCategoriaProf = I.IdProfissionalCategoriaProf
            WHERE  i.IdProfissionalCategoriaProf = @IdProfissionalCategoriaProf 
        
            COMMIT TRANSACTION
        END;
    END;
    
    
    --==============================================================================
    --INSERT
    --==============================================================================
    ELSE IF (SELECT COUNT(*) FROM INSERTED)>=1 AND (SELECT COUNT(*) FROM DELETED)=0 
    BEGIN
        BEGIN TRAN 
        IF  (SELECT dbo.RegistroConselho_IsValido(@RegistroConselho, @IdProfissional)) = 0
        BEGIN
            RAISERROR (
                'REGISTRO CONSELHO NÃO PODE SER INSERIDO COM OUTRA NUMERAÇÃO'
               ,16
               ,1
            );
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        ELSE
        BEGIN
            INSERT INTO Profissionais_CategoriasProf (IdCategoriaProf,IdTipoInscricao,IdProfissional,RegistroConselho,DataInicio,DataFim,IdMotivoInscricao,DataUltimaAtualizacao,UsuarioUltimaAtualizacao
            ,DepartamentoUltimaAtualizacao,DataDeferimento,IdProcesso,Livro,Folha,IdProfissionalCategoriaProfmigracao)
            SELECT I.IdCategoriaProf
                  ,I.IdTipoInscricao
                  ,I.IdProfissional
                  ,I.RegistroConselho
                  ,I.DataInicio
                  ,I.DataFim
                  ,I.IdMotivoInscricao
                  ,I.DataUltimaAtualizacao
                  ,I.UsuarioUltimaAtualizacao
                  ,I.DepartamentoUltimaAtualizacao
                  ,I.DataDeferimento
                  ,I.IdProcesso
                  ,I.Livro
                  ,I.Folha
                  ,i.IdProfissionalCategoriaProfmigracao
            FROM   INSERTED AS I
            WHERE  i.IdProfissionalCategoriaProf = @IdProfissionalCategoriaProf
            
        
            COMMIT TRANSACTION
        END;
    END



GO
create trigger Trg_Profissionais_CategoriasProf_Usuario on Profissionais_CategoriasProf for insert, update
   as
   declare @IdProfissionalCategoriaProf integer
   declare @Depto    varchar(60)
   select @IdProfissionalCategoriaProf = IdProfissionalCategoriaProf from inserted
   if @IdProfissionalCategoriaProf > 0
	begin
		select @Depto = NomeDepto from Departamentos inner join Usuarios on
			Departamentos.IdDepto = Usuarios.IdDepartamento where NomeUsuario = host_name()
		update Profissionais_CategoriasProf set DataUltimaAtualizacao = getdate(), UsuarioUltimaAtualizacao = host_name(), DepartamentoUltimaAtualizacao = @Depto
		where IdProfissionalCategoriaProf = @IdProfissionalCategoriaProf
        end 





