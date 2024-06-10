set linesize 300 ; 
set pagesize 300 ; 
col name for a14;
SELECT sn.inst_id, sn.name, ss.VALUE
    FROM gv$statname sn, gv$sysstat ss
   WHERE     sn.inst_id = ss.inst_id
         AND sn.statistic# = ss.statistic#
         AND sn.name = 'gc blocks lost'
ORDER BY sn.inst_id;


SET PAGES 999
SET LINES 300
COL RATIO FOR 99999999

SELECT A.INST_ID "INSTANCE",
       A.VALUE "GC BLOCKS LOST",
       B.VALUE "GC CUR BLOCKS SERVED",
       C.VALUE "GC CR BLOCKS SERVED",
       A.VALUE/(B.VALUE+C.VALUE) RATIO
FROM
       GV$SYSSTAT A, 
       GV$SYSSTAT B,
       GV$SYSSTAT C
WHERE
       A.NAME='gc blocks lost' AND
       B.NAME='gc current blocks served' AND
       C.NAME='gc cr blocks served' and
       B.INST_ID=a.inst_id AND
       C.INST_ID = a.inst_id;
	   

col EVENT for a30;
select
inst_id,
event,
total_waits,
time_waited
from
gv$system_event
where
event in ('gc current block lost','gc cr block lost')
order by
inst_id, total_waits desc;



prompt lost blocks ratio in the target instance
prompt
SET PAGES 999
SET LINES 300
COL RATIO FOR 99999999

SELECT A.INST_ID "INSTANCE",
       A.VALUE "GC BLOCKS LOST",
       B.VALUE "GC CUR BLOCKS SERVED",
       C.VALUE "GC CR BLOCKS SERVED",
       A.VALUE/(B.VALUE+C.VALUE) RATIO
FROM
       GV$SYSSTAT A, 
       GV$SYSSTAT B,
       GV$SYSSTAT C
WHERE
       A.NAME='gc blocks lost' AND
       B.NAME='gc current blocks served' AND
       C.NAME='gc cr blocks served' and
       B.INST_ID=a.inst_id AND
       C.INST_ID = a.inst_id;