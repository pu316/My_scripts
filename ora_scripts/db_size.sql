PROMPT
PROMPT Database Size in GB with use space and free space.
PROMPT ********************** In GB ********************************
select round(sum(used.bytes) / 1024 / 1024 / 1024 ) || 'GB' "Database Size"
, round(sum(used.bytes) / 1024 / 1024 / 1024 ) - round(free.p / 1024 / 1024 / 1024) || 'GB' "Used space"
,round(free.p / 1024 / 1024 / 1024) || 'GB' "Free space"
from (select bytes
from v$datafile
union all
select bytes
from v$tempfile
union all
select bytes
from v$log) used
,(select sum(bytes) as p
from dba_free_space) free
group by free.p
/
PROMPT
PROMPT ********************** In TB ********************************
select round(sum(used.bytes) / 1024 / 1024 / 1024/1024 ) || 'TB' "Database Size"
, round(sum(used.bytes) / 1024 / 1024 / 1024/1024 ) - round(free.p / 1024 / 1024 / 1024/1024) || 'TB' "Used space"
,round(free.p / 1024 / 1024 / 1024 /1024 ) || 'TB' "Free space"
from (select bytes
from v$datafile
union all
select bytes
from v$tempfile
union all
select bytes
from v$log) used
,(select sum(bytes) as p
from dba_free_space) free
group by free.p
/



SET LINESIZE 200
SET PAGESIZE 200
COL "Database Size" FORMAT a13
COL "Used Space" FORMAT a12
COL "Used in %" FORMAT a11
COL "Free in %" FORMAT a11
COL "Database Name" FORMAT a13
COL "Free Space" FORMAT a12
COL "Growth DAY" FORMAT a11
COL "Growth WEEK" FORMAT a12
COL "Growth DAY in %" FORMAT a16
COL "Growth WEEK in %" FORMAT a16
PROMPT
PROMPT Query to find Database Growth
PROMPT ********************** Growth of DB ********************************
SELECT
(select min(creation_time) from v$datafile) "Create Time",
(select name from v$database) "Database Name",
ROUND((SUM(USED.BYTES) / 1024 / 1024 ),2) || 'MB' "Database Size",
ROUND((SUM(USED.BYTES) / 1024 / 1024 ) - ROUND(FREE.P / 1024 / 1024 ),2) || 'MB' "Used Space",
ROUND(((SUM(USED.BYTES) / 1024 / 1024 ) - (FREE.P / 1024 / 1024 )) / ROUND(SUM(USED.BYTES) / 1024 / 1024 ,2)*100,2) || '% MB' "Used in %",
ROUND((FREE.P / 1024 / 1024 ),2) || 'MB' "Free Space",
ROUND(((SUM(USED.BYTES) / 1024 / 1024 ) - ((SUM(USED.BYTES) / 1024 / 1024 ) - ROUND(FREE.P / 1024 / 1024 )))/ROUND(SUM(USED.BYTES) / 1024 / 1024,2 )*100,2) || '% MB' "Free in %",
ROUND(((SUM(USED.BYTES) / 1024 / 1024 ) - (FREE.P / 1024 / 1024 ))/(select sysdate-min(creation_time) from v$datafile),2) || 'MB' "Growth DAY",
ROUND(((SUM(USED.BYTES) / 1024 / 1024 ) - (FREE.P / 1024 / 1024 ))/(select sysdate-min(creation_time) from v$datafile)/ROUND((SUM(USED.BYTES) / 1024 / 1024 ),2)*100,3) || '% MB' "Growth DAY in %",
ROUND(((SUM(USED.BYTES) / 1024 / 1024 ) - (FREE.P / 1024 / 1024 ))/(select sysdate-min(creation_time) from v$datafile)*7,2) || 'MB' "Growth WEEK",
ROUND((((SUM(USED.BYTES) / 1024 / 1024 ) - (FREE.P / 1024 / 1024 ))/(select sysdate-min(creation_time) from v$datafile)/ROUND((SUM(USED.BYTES) / 1024 / 1024 ),2)*100)*7,3) || '% MB' "Growth WEEK in %"
FROM    (SELECT BYTES FROM V$DATAFILE
UNION ALL
SELECT BYTES FROM V$TEMPFILE
UNION ALL
SELECT BYTES FROM V$LOG) USED,
(SELECT SUM(BYTES) AS P FROM DBA_FREE_SPACE) FREE
GROUP BY FREE.P;