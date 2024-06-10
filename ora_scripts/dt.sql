set echo off ; 
set linesize 300 ;
set pagesize 300 ; 

set feedback off verify off heading off;
PROMPT
PROMPT  CURRENT DB TIME
SELECT TO_CHAR(SYSDATE,'dd-MM-yyyy hh:mi:ss PM') As "Current_time" FROM dual;
--ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS PM';

--select TO_CHAR(SYSDATE, 'DD-MON-YYYY hh:mi:ss PM') from dual;
SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS PM'  ) "NOW" FROM DUAL;
PROMPT
set feedback on verify on heading on;