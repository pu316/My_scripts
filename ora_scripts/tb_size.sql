set linesize 300 ;
col owner for a40;
col SEGMENT_NAME for a30;
set verify off ;
select
   *
from (
   select
      owner,
      segment_name,
      bytes/1024/1024 "in MB",bytes/1024/1024/1024 "in GB"
   from
      dba_segments
   where
      segment_type = 'TABLE'
   order by
      bytes/1024/1024 desc)
where
segment_name = '' || UPPER('&1') || '' and rownum <= 10;