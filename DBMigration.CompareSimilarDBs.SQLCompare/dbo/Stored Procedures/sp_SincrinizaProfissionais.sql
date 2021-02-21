CREATE PROCEDURE [dbo].[sp_SincrinizaProfissionais] 
@Nome varchar(40),
@RegistroConselhoAtual varchar(20),
@IdCorecon int,
@IdUnidadeConselho int
AS

Declare @IdSindecon int

Insert Into Profissionais (Nome, IdUnidadeConselho) Values (@Nome, @IdUnidadeConselho)
Set @IdSindecon = SCOPE_IDENTITY()
Insert Into ControleSincronizacao (Nome, RegistroConselho, IdCorecon, IdSindecon) Values (@Nome, @RegistroConselhoAtual, @IdCorecon, @IdSindecon)
