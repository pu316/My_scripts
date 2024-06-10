SET lines 140
COL owner_name FORMAT a10;
COL job_name FORMAT a30
COL state FORMAT a12 
COL operation LIKE owner_name
COL job_mode LIKE owner_name
SELECT owner_name, job_name, operation, job_mode,
state, attached_sessions
FROM dba_datapump_jobs;