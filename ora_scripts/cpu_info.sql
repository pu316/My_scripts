set pagesize 299
set lines 299
select STAT_NAME,to_char(VALUE) as VALUE ,COMMENTS from v$osstat where stat_name IN ('NUM_CPUS','NUM_CPU_CORES','NUM_CPU_SOCKETS')
union
select STAT_NAME,VALUE/1024/1024/1024 || ' GB' ,COMMENTS from v$osstat where stat_name IN ('PHYSICAL_MEMORY_BYTES');
prompt
prompt


set lines 288
col sample_time for a14
col CONFIGURATION head "CONFIG" for 99.99
col ADMINISTRATIVE head "ADMIN" for 99.99
col OTHER for 99.99

SELECT TO_CHAR(SAMPLE_TIME, 'HH24:MI ') AS SAMPLE_TIME,
ROUND(OTHER / 60, 3) AS OTHER,
ROUND(CLUST / 60, 3) AS CLUST,
ROUND(QUEUEING / 60, 3) AS QUEUEING,
ROUND(NETWORK / 60, 3) AS NETWORK,
ROUND(ADMINISTRATIVE / 60, 3) AS ADMINISTRATIVE,
ROUND(CONFIGURATION / 60, 3) AS CONFIGURATION,
ROUND(COMMIT / 60, 3) AS COMMIT,
ROUND(APPLICATION / 60, 3) AS APPLICATION,
ROUND(CONCURRENCY / 60, 3) AS CONCURRENCY,
ROUND(SIO / 60, 3) AS SYSTEM_IO,
ROUND(UIO / 60, 3) AS USER_IO,
ROUND(SCHEDULER / 60, 3) AS SCHEDULER,
ROUND(CPU / 60, 3) AS CPU,
ROUND(BCPU / 60, 3) AS BACKGROUND_CPU
FROM (SELECT TRUNC(SAMPLE_TIME, 'MI') AS SAMPLE_TIME,
DECODE(SESSION_STATE,
'ON CPU',
DECODE(SESSION_TYPE, 'BACKGROUND', 'BCPU', 'ON CPU'),
WAIT_CLASS) AS WAIT_CLASS
FROM V$ACTIVE_SESSION_HISTORY
WHERE SAMPLE_TIME > SYSDATE - INTERVAL '2'
HOUR
AND SAMPLE_TIME <= TRUNC(SYSDATE, 'MI')) ASH PIVOT(COUNT(*)
FOR WAIT_CLASS IN('ON CPU' AS CPU,'BCPU' AS BCPU,
'Scheduler' AS SCHEDULER,
'User I/O' AS UIO,
'System I/O' AS SIO,
'Concurrency' AS CONCURRENCY,
'Application' AS APPLICATION,
'Commit' AS COMMIT,
'Configuration' AS CONFIGURATION,
'Administrative' AS ADMINISTRATIVE,
'Network' AS NETWORK,
'Queueing' AS QUEUEING,
'Cluster' AS CLUST,
'Other' AS OTHER))
/

PROMPT 
PROMPT Top CPU Users @ DB Level 

set linesize 300;
set pagesize 300;
col USERNAME for a20;
col EVENT for a40;
col INST_ID format 999;
col OSUSER for a10;
col TO_CHAR(TRUNC(value/3600)) for a20;
select 
   ss.INST_ID,
   ss.username,ss.OSUSER,
   se.SID,ss.SERIAL#,ss.SQL_ID,ss.status,SS.event,
   VALUE/100 cpu_usage_seconds,
   (value/3600) cpu_usage_hr
from
   gv$session ss, 
   gv$sesstat se, 
   gv$statname sn
where
   se.STATISTIC# = sn.STATISTIC# 
and
   NAME like '%CPU used by this session%'
and
   se.SID = ss.SID
and 
   ss.status='ACTIVE'
and 
   ss.username is not null
order by VALUE desc;
