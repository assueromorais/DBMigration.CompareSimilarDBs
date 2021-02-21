


























CREATE PROCEDURE dbo.spCa(
                                           @Ordenar                                 sysname = null ,
			   @pktable_name		sysname = null,
			   @pktable_owner		sysname = null,
			   @pktable_qualifier	sysname = null,
			   @fktable_name		sysname = null,
			   @fktable_owner		sysname = null,
			   @fktable_qualifier	sysname = null )
as
	set nocount on
	DECLARE @pktable_id			int
	DECLARE @pkfull_table_name	nvarchar(257) 
	DECLARE @fktable_id			int
	DECLARE @fkfull_table_name	nvarchar(257) 
	declare	@order_by_pk		int


	create table #fkeysall(
			rkeyid int NOT NULL,
			rkey1 int NOT NULL,
				rkey2 int NOT NULL,
				rkey3 int NOT NULL,
				rkey4 int NOT NULL,
				rkey5 int NOT NULL,
				rkey6 int NOT NULL,
				rkey7 int NOT NULL,
				rkey8 int NOT NULL,
				rkey9 int NOT NULL,
				rkey10 int NOT NULL,
				rkey11 int NOT NULL,
				rkey12 int NOT NULL,
				rkey13 int NOT NULL,
				rkey14 int NOT NULL,
				rkey15 int NOT NULL,
				rkey16 int NOT NULL,
			fkeyid int NOT NULL,
			fkey1 int NOT NULL,
				fkey2 int NOT NULL,
				fkey3 int NOT NULL,
				fkey4 int NOT NULL,
				fkey5 int NOT NULL,
				fkey6 int NOT NULL,
				fkey7 int NOT NULL,
				fkey8 int NOT NULL,
				fkey9 int NOT NULL,
				fkey10 int NOT NULL,
				fkey11 int NOT NULL,
				fkey12 int NOT NULL,
				fkey13 int NOT NULL,
				fkey14 int NOT NULL,
				fkey15 int NOT NULL,
				fkey16 int NOT NULL,
			constid int NOT NULL,
			name sysname NOT NULL)

	create table #fkeys(
			pktable_id		int NOT NULL,
			pkcolid 		int NOT NULL,
			fktable_id		int NOT NULL,
			fkcolid 		int NOT NULL,
			KEY_SEQ 		smallint NOT NULL,
			fk_id			int NOT NULL,
			PK_NAME			sysname NOT NULL)

	create table #fkeysout(
			PKTABLE_QUALIFIER sysname NULL,
			PKTABLE_OWNER sysname NULL,
			PKTABLE_NAME sysname NOT NULL,
			PKCOLUMN_NAME sysname NOT NULL,
			FKTABLE_QUALIFIER sysname NULL,
			FKTABLE_OWNER sysname NULL,
			FKTABLE_NAME sysname NOT NULL,
			FKCOLUMN_NAME sysname NOT NULL,
			KEY_SEQ smallint NOT NULL,
			UPDATE_RULE smallint NULL,
			DELETE_RULE smallint NULL,
			FK_NAME sysname NULL,
			PK_NAME sysname NULL,
			DEFERRABILITY smallint null)


    select  @order_by_pk = 0

	if (@pktable_name is null) and (@fktable_name is null)
	begin	
		Print 'Erro Siscafw , procedimento não pode ser concluído por falta de parametros .'
		return
        end
/*	if @fktable_qualifier is not null
        begin
		if db_name() <> @fktable_qualifier
		begin	
			Print 'Databases diferentes .'  + @fktable_qualifier
			return
		end
        end
	if @pktable_qualifier is not null
        begin
		if db_name() <> @pktable_qualifier
		begin	
			Print 'Databases diferentes'
			return
		end 
        end
*/

	if @pktable_owner is null
	begin	
		SELECT @pkfull_table_name = quotename(@pktable_name)
        end
        else
	begin	
		if @pktable_owner = ''
		begin	
			SELECT @pkfull_table_name = quotename(@pktable_owner)
		end
		else
		begin
			SELECT @pkfull_table_name = quotename(@pktable_owner) +
				'.' + quotename(@pktable_name)
		end
        end

	if @fktable_owner is null
	begin	
		SELECT @fkfull_table_name = quotename(@fktable_name)
        end
        else
	begin
		if @fktable_owner = ''
		begin	
			SELECT @fkfull_table_name = quotename(@fktable_owner)
		end
		else
		begin
			SELECT @fkfull_table_name = quotename(@fktable_owner) +
				'.' + quotename(@fktable_name)
		end
        end

	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	begin tran

	SELECT @pktable_id = object_id(@pkfull_table_name)

	SELECT @fktable_id = object_id(@fkfull_table_name)
	if @fktable_name is not null
	begin
		if @fktable_id is null
			SELECT @fktable_id = 0	
        end

	if @pktable_name is null
	begin 
		select @order_by_pk = 1
	end
	else
	begin
		if @pktable_id is null
		begin
			SELECT @pktable_id = 0	
		end

	end



	insert into #fkeysall

		select
			r.rkeyid,
			r.rkey1, r.rkey2, r.rkey3, r.rkey4,
				r.rkey5, r.rkey6, r.rkey7, r.rkey8,
				r.rkey9, r.rkey10, r.rkey11, r.rkey12,
				r.rkey13, r.rkey14, r.rkey15, r.rkey16,
			r.fkeyid,
			r.fkey1, r.fkey2, r.fkey3, r.fkey4,
				r.fkey5, r.fkey6, r.fkey7, r.fkey8,
				r.fkey9, r.fkey10, r.fkey11, r.fkey12,
				r.fkey13, r.fkey14, r.fkey15, r.fkey16,
			r.constid,
			i.name
		from
			sysreferences r, sysobjects o, sysindexes i
		where	r.constid = o.id
			AND o.xtype = 'F'
			AND r.rkeyindid = i.indid
			AND r.rkeyid = i.id
			AND r.rkeyid between isnull(@pktable_id, 0)
							and isnull(@pktable_id, 0x7fffffff)
			AND r.fkeyid between isnull(@fktable_id, 0)
							and isnull(@fktable_id, 0x7fffffff)

    insert into #fkeys
			select rkeyid, rkey1, fkeyid, fkey1, 1, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey2, fkeyid, fkey2, 2, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey3, fkeyid, fkey3, 3, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey4, fkeyid, fkey4, 4, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey5, fkeyid, fkey5, 5, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey6, fkeyid, fkey6, 6, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey7, fkeyid, fkey7, 7, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey8, fkeyid, fkey8, 8, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey9, fkeyid, fkey9, 9, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey10, fkeyid, fkey10, 10, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey11, fkeyid, fkey11, 11, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey12, fkeyid, fkey12, 12, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey13, fkeyid, fkey13, 13, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey14, fkeyid, fkey14, 14, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey15, fkeyid, fkey15, 15, constid, name
			from #fkeysall
		union all
			select rkeyid, rkey16, fkeyid, fkey16, 16, constid, name
			from #fkeysall

	insert into #fkeysout
		select
			PKTABLE_QUALIFIER = convert(sysname,db_name()),
			PKTABLE_OWNER = convert(sysname,USER_NAME(o1.uid)),
			PKTABLE_NAME = convert(sysname,o1.name),
			PKCOLUMN_NAME = convert(sysname,c1.name),
			FKTABLE_QUALIFIER = convert(sysname,db_name()),
			FKTABLE_OWNER = convert(sysname,USER_NAME(o2.uid)),
			FKTABLE_NAME = convert(sysname,o2.name),
			FKCOLUMN_NAME = convert(sysname,c2.name),
			KEY_SEQ,
			UPDATE_RULE = convert(smallint,1),
			DELETE_RULE = convert(smallint,1),
			FK_NAME = convert(sysname,OBJECT_NAME(fk_id)),
			PK_NAME,
			DEFERRABILITY = 7	/* SQL_NOT_DEFERRABLE */
		from #fkeys f,
			sysobjects o1, sysobjects o2,
			syscolumns c1, syscolumns c2
		where	o1.id = f.pktable_id
			AND o2.id = f.fktable_id
			AND c1.id = f.pktable_id
			AND c2.id = f.fktable_id
			AND c1.colid = f.pkcolid
			AND c2.colid = f.fkcolid
	commit tran
                     if @Ordenar = 1 
		select
			PKTABLE_NAME, PKCOLUMN_NAME,
			FKTABLE_NAME, FKCOLUMN_NAME,
			FK_NAME, DEFERRABILITY
		from #fkeysout
                           ORDER BY FK_NAME
                     else
		select
			PKTABLE_NAME, PKCOLUMN_NAME,
			FKTABLE_NAME, FKCOLUMN_NAME,
			FK_NAME, DEFERRABILITY
		from #fkeysout
                           ORDER BY FK_NAME DESC






















































