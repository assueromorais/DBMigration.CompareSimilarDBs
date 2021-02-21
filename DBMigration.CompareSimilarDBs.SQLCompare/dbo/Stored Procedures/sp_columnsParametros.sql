


CREATE PROCEDURE dbo.sp_columnsParametros (
				 @table_name		nvarchar(384)
)
AS
	DECLARE @full_table_name	nvarchar(769)
	DECLARE @table_id int


	SELECT @full_table_name = quotename(@table_name)

	/*	Get Object ID */
	SELECT @table_id = object_id(@full_table_name)
		/* this block is for the case where there IS pattern
			matching done on the table name */


	SELECT
			TABLE_QUALIFIER = convert(sysname,DB_NAME()),
			TABLE_OWNER = convert(sysname,USER_NAME(o.uid)),
			TABLE_NAME = convert(sysname,o.name),
			COLUMN_NAME = convert(sysname,c.name),
			d.DATA_TYPE,
			t.name TYPE_NAME,
			convert(int,case
				when d.DATA_TYPE in (6,7) then d.data_precision 		/* FLOAT/REAL */
				else OdbcPrec(c.xtype,c.length,c.xprec)
			end) "PRECISION",
			convert(int,case
				when type_name(d.ss_dtype) IN ('numeric','decimal') then	/* decimal/numeric types */
					OdbcPrec(c.xtype,c.length,c.xprec)+2
				else
					isnull(d.length, c.length)
			end) LENGTH,
			SCALE = convert(smallint, OdbcScale(c.xtype,c.xscale)),
			d.RADIX,
			NULLABLE = convert(smallint, ColumnProperty (c.id, c.name, 'AllowsNull')),
			REMARKS = convert(varchar(254),null),	/* Remarks are NULL */
			COLUMN_DEF = text,
			d.SQL_DATA_TYPE,
			d.SQL_DATETIME_SUB,
			CHAR_OCTET_LENGTH = isnull(d.length, c.length)+d.charbin,
			ORDINAL_POSITION = convert(int,
					   (
						select count(*)
						from syscolumns sc
						where sc.id     =  c.id
						  AND sc.number =  c.number
						  AND sc.colid  <= c.colid
					    )),
			IS_NULLABLE = convert(varchar(254),
				rtrim(substring('NO YES',(ColumnProperty (c.id, c.name, 'AllowsNull')*3)+1,3))),
			SS_DATA_TYPE = c.type
		FROM
			sysobjects o,
			master.dbo.spt_datatype_info d,
			systypes t,
			syscolumns c
			LEFT OUTER JOIN syscomments m on c.cdefault = m.id
				AND m.colid = 1
		WHERE
			o.name like @table_name
			AND o.id = c.id
			AND t.xtype = d.ss_dtype
			AND c.length = isnull(d.fixlen, c.length)
			AND (o.type not in ('P', 'FN', 'TF', 'IF') OR (o.type in ('TF', 'IF') and c.number = 0))
			AND isnull(d.AUTO_INCREMENT,0) = isnull(ColumnProperty (c.id, c.name, 'IsIdentity'),0)
			AND c.xusertype = t.xusertype
                        AND (d.DATA_TYPE = 12 or d.DATA_TYPE = 1)  
		ORDER BY 2, 3, 17




