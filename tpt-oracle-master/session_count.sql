--session Count
Prompt ***** Total Connection *****
select count(s.status) TOTAL_SESSIONS from gv$session s;

Prompt ***** Total Active *****
select count(s.status) ACTIVE_SESSIONS
from gv$session s, v$process p
where
p.addr=s.paddr and
s.status='ACTIVE';

Prompt ***** Total Inactive *****
select count(s.status) INACTIVE_SESSIONS
from gv$session s, v$process p
where
p.addr=s.paddr and
s.status='INACTIVE';

PROMPT ******** connection from application server wise ******** 
PROMPT
set linesize 300 ; 
set pagesize 300 ; 
col machine for a40;
col username for a20;
col CLIENT_INFO for a20;
col TERMINAL for a20;
SELECT count(1) AS con_count, machine, username,CLIENT_INFO,terminal,status,count(status)
FROM gv$session 
--WHERE type <> 'BACKGROUND'
GROUP BY username, machine,username,CLIENT_INFO,terminal,status
ORDER BY con_count DESC;