
set linesize 300 ; 
set pagesize 300 ; 
select instance_name , status from gv$instance ; 
select name , DB_UNIQUE_NAME , open_mode, FLASHBACK_ON ,CONTROLFILE_TYPE from v$database ; 

set linesize 300 ; 
set pagesize 300 ; 
set numwidth 30;
set pagesize 50000;
alter session set nls_date_format = 'DD-MON-RRRR HH24:MI:SS';
select status,checkpoint_change#,checkpoint_time, resetlogs_change#, resetlogs_time, count(*), fuzzy from v$datafile_header group by status,checkpoint_change#,checkpoint_time, resetlogs_change#, resetlogs_time, fuzzy;


