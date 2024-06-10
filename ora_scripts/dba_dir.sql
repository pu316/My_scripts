set linesize 300;
set pagesize 300;
col OWNER for a20;
set verify off ;
col DIRECTORY_NAME for a30;
col DIRECTORY_PATH for a70;
select *  from  dba_directories;
select *  from  dba_directories where DIRECTORY_NAME='&1';
PROMPT *******************Below users have access on Dir ******************
col GRANTEE for a15;
col TABLE_NAME for a20;
col GRANTOR for a20;
SELECT * FROM dba_tab_privs WHERE table_name='&1';