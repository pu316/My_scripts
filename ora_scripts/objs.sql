SET LINESIZE 500 ;
set verify off ;
set wrap off ; 
SET HEADING ON;
COLUMN owner FORMAT A10;
COLUMN object_name FORMAT A30;
COLUMN edition_name FORMAT A15
col OBJECT_TYPE for a20;
col LAST_DDL_TIME for a24;
col TIMESTAMP for a20;
col EDITION_NAME for a10;
col CREATED for a24;
col STATUS for a10;
SELECT owner,
       object_name,
       --subobject_name,
       object_id,
       object_type,
       TO_CHAR(created, 'DD-MON-YYYY HH24:MI:SS') AS created,
       TO_CHAR(last_ddl_time, 'DD-MON-YYYY HH24:MI:SS') AS last_ddl_time,
       timestamp,
       status,
       temporary,
       generated,
       secondary,
       namespace,
       edition_name
FROM   dba_objects
WHERE  object_name LIKE (DECODE(UPPER('&1'), 'ALL', '%', UPPER('%&1%')))
--AND OBJECT_TYPE LIKE (DECODE(UPPER('&2'), 'ALL', '%', UPPER('%&2%')))
ORDER BY owner,OBJECT_TYPE,object_name,object_type;

SET VERIFY ON