prompt
PROMPT ************DB STATUS************
set linesize 300;
set wrap ON;
set pagesize 300;
col HOST_NAME for a30;
col INST_ID for 999;
col STATUS for a08;
col INSTANCE_NAME for a10;
col DATABASE_ROLE for a11;
col OPEN_MODE for a10;
col LOGINS for a10;
col FLASHBACK_ON for a04;
col FORCE_LOGGING for a5;
col DB_UNIQUE_NAME for a08;
col PLATFORM_NAME for a16;
select a.INST_ID,a.instance_name ,b.DBID,a.host_name,a.status,b.database_role,b.open_mode,b.CONTROLFILE_TYPE,b.flashback_on,to_char(startup_time,'DD/MM/YYYY HH24:MI:SS'),a.logins,b.FORCE_LOGGING,b.DB_UNIQUE_NAME,b.PLATFORM_NAME from gv$instance a ,v$database b order by 1;


prompt
Prompt ***************GRP database*******************
set linesize 300 ;
col NAME for a40;
col TIME for a40;
col SCN for a20;
SELECT NAME, to_char(SCN) SCN, TIME, DATABASE_INCARNATION#,GUARANTEE_FLASHBACK_DATABASE,sum(STORAGE_SIZE/1024/1024/1024) STORAGE_SIZE_GB
FROM V$RESTORE_POINT group by NAME,SCN, TIME, DATABASE_INCARNATION#,GUARANTEE_FLASHBACK_DATABASE,STORAGE_SIZE; 

prompt
Prompt ***************BCT status *******************
col FILENAME for a70;
SELECT * FROM V$BLOCK_CHANGE_TRACKING;