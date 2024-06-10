clear columns
set linesize 300;
set pagesize 300 ;
set WRAP off ;
col MODULE for a30;
col inst for 9999
col to_char(sid) for a6;
col serial# for 99990 print
col username for a12
col osuser for a10
col machine for a15
col program for a13 trunc
col locks for a5
col status for a6 trunc
col "hh:mm:ss" for a8
col "Total_Time" for a16;
col SQL_ID for a13
col seq# for 99990
col event head 'current/last event' for a27 trunc
col state  head 'state    (sec)' for a14
col MODULE for a15;
set linesize 200;
select inst_id inst
  , to_char(sid)
  , serial#
  , username
  , osuser
  , machine
  , program
  , decode(lockwait,NULL,' ','L') as locks
  , status
  --, to_char(to_date(mod(last_call_et,86400), 'sssss'), 'hh24:mi:ss') "hh:mm:ss",
  ,floor(last_call_et/86400) || 'd ' ||  to_char(to_date(mod  (last_call_et,86400) ,'sssss'),'hh24"h" mi"m" ss"s"') "Total_Time"
  , sql_id
  , seq#
  , event
  , decode(state,'WAITING','WAITING '||lpad(to_char(mod(SECONDS_IN_WAIT,86400),'99990'),6)
    ,'WAITED SHORT TIME','ON CPU','WAITED KNOWN TIME','ON CPU',state) state
  , substr(module,1,18) module
from GV$SESSION s
where type = 'USER'
and s.audsid != 0  -- 0 is for internal processes
and (status = 'ACTIVE' or SQL_HASH_VALUE <> 0 or s.lockwait is not null)
order by SECONDS_IN_WAIT desc;
set WRAP off ;