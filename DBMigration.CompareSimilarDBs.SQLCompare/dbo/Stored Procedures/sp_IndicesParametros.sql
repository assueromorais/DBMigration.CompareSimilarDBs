


create proc dbo.sp_IndicesParametros
	@objname nvarchar(776)	,	-- the table to check for indexes
        @DBNAME  nvarchar(776)
as
	-- PRELIM
	set nocount on

	declare @objid int,			-- the object id of the table
			@indid smallint,	-- the index id of an index
			@groupid smallint,  -- the filegroup id of an index
			@indname sysname,
			@groupname sysname,
			@status int,
			@keys nvarchar(2126)/*,	--Length (16*max_identifierLength)+(15*2)+(16*3)
			@dbname	sysname*/

	-- Check to see that the object names are local to the current database.


	select @objid = object_id(@objname)
/*	if @objid is NULL
	begin
		select @dbname
		raiserror(15009,-1,-1,@objname,@dbname)
		return (1)
	end
*/
	declare ms_crs_ind cursor local static for
		select indid, groupid, name, status from sysindexes
			where id = @objid and indid > 0 and indid < 255 and (status & 64)=0 order by indid
	open ms_crs_ind
	fetch ms_crs_ind into @indid, @groupid, @indname, @status

/*	if @@fetch_status < 0
	begin
		deallocate ms_crs_ind
		raiserror(15472,-1,-1) --'Object does not have any indexes.'
		return (0)
	end
*/
	create table #spindtab
	(
		index_name			sysname	NOT NULL,
		stats				int,
		groupname			sysname NOT NULL,
		index_keys			nvarchar(2126) COLLATE database_default	NOT NULL -- see @keys above for length descr
	)

	while @@fetch_status >= 0
	begin
		declare @i int, @thiskey nvarchar(131) 

		select @keys = index_col(@objname, @indid, 1), @i = 2 
		if (indexkey_property(@objid, @indid, 1, 'isdescending') = 1)
			select @keys = @keys  + '(-)'

                set @keys = '['+@keys+']'

		select @thiskey =index_col(@objname, @indid, @i)
		if ((@thiskey is not null) and (indexkey_property(@objid, @indid, @i, 'isdescending') = 1))
			select @thiskey = @thiskey + '(-)'
                set @thisKey = '['+@thiskey+']'
/*                print @keys +'a'
                print @thiskey +' B'*/
		while (@thiskey is not null )
		begin
			select @keys = @keys + ',' + @thiskey, @i = @i + 1
			select @thiskey = index_col(@objname, @indid, @i)
			if ((@thiskey is not null) and (indexkey_property(@objid, @indid, @i, 'isdescending') = 1))
				select @thiskey = @thiskey + '(-)'
                        set @thiskey = '['+@thiskey+']'
		end

		select @groupname = groupname from sysfilegroups where groupid = @groupid

		insert into #spindtab values (@indname, @status, @groupname, @keys)

		fetch ms_crs_ind into @indid, @groupid, @indname, @status
	end
	deallocate ms_crs_ind

	declare @empty varchar(1) select @empty = ''
	declare @des1			varchar(35),	-- 35 matches spt_values
			@des2			varchar(35),
			@des4			varchar(35),
			@des32			varchar(35),
			@des64			varchar(35),
			@des2048		varchar(35),
			@des4096		varchar(35),
			@des8388608		varchar(35),
			@des16777216	varchar(35)
	select @des1 = name from master.dbo.spt_values where type = 'I' and number = 1
	select @des2 = name from master.dbo.spt_values where type = 'I' and number = 2
	select @des4 = name from master.dbo.spt_values where type = 'I' and number = 4
	select @des32 = name from master.dbo.spt_values where type = 'I' and number = 32
	select @des64 = name from master.dbo.spt_values where type = 'I' and number = 64
	select @des2048 = name from master.dbo.spt_values where type = 'I' and number = 2048
	select @des4096 = name from master.dbo.spt_values where type = 'I' and number = 4096
	select @des8388608 = name from master.dbo.spt_values where type = 'I' and number = 8388608
	select @des16777216 = name from master.dbo.spt_values where type = 'I' and number = 16777216

	select
		'index_name' = index_name,
		'index_description' = convert(varchar(210), --bits 16 off, 1, 2, 16777216 on, located on group
				case when (stats & 16)<>0 then 'clustered' else 'nonclustered' end
				+ case when (stats & 1)<>0 then ', '+@des1 else @empty end
				+ case when (stats & 2)<>0 then ', '+@des2 else @empty end
				+ case when (stats & 4)<>0 then ', '+@des4 else @empty end
				+ case when (stats & 64)<>0 then ', '+@des64 else case when (stats & 32)<>0 then ', '+@des32 else @empty end end
				+ case when (stats & 2048)<>0 then ', '+@des2048 else @empty end
				+ case when (stats & 4096)<>0 then ', '+@des4096 else @empty end
				+ case when (stats & 8388608)<>0 then ', '+@des8388608 else @empty end
				+ case when (stats & 16777216)<>0 then ', '+@des16777216 else @empty end
				+ ' located on ' + groupname),
		'index_keys' = index_keys
	from #spindtab
	order by index_name

	return (0) 




