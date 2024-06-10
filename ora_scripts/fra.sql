PROMPT
PROMPT ***********Connected DB ***********
PROMPT
select name ,CREATED,LOG_MODE,OPEN_MODE,DATABASE_ROLE,flashback_on from v$database ;
PROMPT
PROMPT ***********Check FRA SPACE***********
set linesize 300;
col NAME for a50;
select NAME,
floor(space_limit/1024/1024/1024) "Size_GB",
ceil(space_used/1024/1024/1024) "Used_GB",
floor(space_limit/1024/1024/1024) - ceil(space_used/1024/1024/1024) "Available_GB",
round(ceil(space_used/1024/1024/1024) / floor(space_limit/1024/1024/1024) * 100)  || '%' "Percent Used"
from v$recovery_file_dest
order by 1;
PROMPT
PROMPT ***********Check FRA SPACE***********
PROMPT
select * from v$flash_recovery_area_usage;
PROMPT
PROMPT
PROMPT ***********Check GRP SIZE***********
PROMPT
set linesize 300 ; 
col NAME for a30;
col TIME for a40;
select NAME,TIME,sum(STORAGE_SIZE/1024/1024/1024)As "Size IN GB",to_char(SCN),GUARANTEE_FLASHBACK_DATABASE
from V$RESTORE_POINT group by STORAGE_SIZE,SCN,NAME,GUARANTEE_FLASHBACK_DATABASE,TIME order by TIME;