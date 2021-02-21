


























CREATE Procedure dbo.Sp_DelInsUpdWEB 
  @Operacao Int = 0,
  @Tabelas  VarChar(200)  = '',
  @Campos   VarChar(2000) = '', 
  @Where    Bit = 0,
  @Valores  VarChar(2000) = ''
AS

SET NOCOUNT ON

DECLARE @SQL VarChar(1500)

   if @Operacao <> 0
   begin
      if @Tabelas <> '' 
      begin
         /*Deleção*/
         if @Operacao = 1
         begin
            SET @SQL = 'DELETE FROM '+@Tabelas
               if @Where = 1 
                  SET @SQL = @SQL + ' WHERE '+@Campos
         end
         /*Inserção*/
         if @Operacao = 2
         begin
            SET @SQL = 'INSERT '+@Tabelas+' ('+@Campos+') VALUES ('+@Valores+')'
         end
         /*Update*/
         if @Operacao = 3
         begin
            SET @SQL = 'UPDATE '+@Tabelas+' SET '+@Valores
               if @Where = 1 
                  SET @SQL = @SQL + ' WHERE '+@Campos
         end
      Exec(@SQL)
      end
   end

SET NOCOUNT OFF






















































