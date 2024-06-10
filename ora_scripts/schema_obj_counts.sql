set lines 400 pages 300
col OWNER for a19
col OBJECT_TYPE for a21
 
select owner,object_type,count(*)  from dba_objects where owner in ('&1') group by owner,object_type order by owner,object_type;
