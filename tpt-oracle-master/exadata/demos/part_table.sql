-- Copyright 2018 Tanel Poder. All rights reserved. More info at http://tanelpoder.com
-- Licensed under the Apache License, Version 2.0. See LICENSE.txt for terms & conditions.

CREATE TABLE sales_part
PARTITION BY RANGE (time_id) (
    PARTITION Y1998 VALUES LESS THAN (DATE'1999-01-01')
  , PARTITION Y1999 VALUES LESS THAN (DATE'2000-01-01')
  , PARTITION Y2000 VALUES LESS THAN (DATE'2001-01-01')
  , PARTITION Y2001 VALUES LESS THAN (MAXVALUE)
)
TABLESPACE tanel_large
PARALLEL 32
AS SELECT * FROM sales_100g
/

ALTER TABLE sales_part NOPARALLEL;

EXEC DBMS_STATS.GATHER_TABLE_STATS(user, 'SALES_PART', degree=>16);

CREATE TABLE sales_part_query_high
PARTITION BY RANGE (time_id) (
    PARTITION Y1998 VALUES LESS THAN (DATE'1999-01-01')
  , PARTITION Y1999 VALUES LESS THAN (DATE'2000-01-01')
  , PARTITION Y2000 VALUES LESS THAN (DATE'2001-01-01')
  , PARTITION Y2001 VALUES LESS THAN (MAXVALUE)
)
TABLESPACE tanel_large
COMPRESS FOR QUERY HIGH
PARALLEL 32
AS SELECT * FROM sales_100g
/

ALTER TABLE sales_part_query_high NOPARALLEL;
EXEC DBMS_STATS.GATHER_TABLE_STATS(user, 'SALES_PART_QUERY_HIGH', degree=>16);

alter session set "_fix_control"='6941515:ON';

CREATE TABLE sales_part_fix_6941515
PARTITION BY RANGE (time_id) (
    PARTITION Y1998 VALUES LESS THAN (DATE'1999-01-01')
  , PARTITION Y1999 VALUES LESS THAN (DATE'2000-01-01')
  , PARTITION Y2000 VALUES LESS THAN (DATE'2001-01-01')
  , PARTITION Y2001 VALUES LESS THAN (MAXVALUE)
)
TABLESPACE tanel_large
PARALLEL 32
AS SELECT * FROM sales_100g
/

ALTER TABLE sales_part_fix_6941515 NOPARALLEL;

CREATE TABLE sales_part_query_high_fix
PARTITION BY RANGE (time_id) (
    PARTITION Y1998 VALUES LESS THAN (DATE'1999-01-01')
  , PARTITION Y1999 VALUES LESS THAN (DATE'2000-01-01')
  , PARTITION Y2000 VALUES LESS THAN (DATE'2001-01-01')
  , PARTITION Y2001 VALUES LESS THAN (MAXVALUE)
)
TABLESPACE tanel_large
COMPRESS FOR QUERY HIGH
PARALLEL 32
AS SELECT * FROM sales_100g
/

ALTER TABLE sales_part_query_high_fix NOPARALLEL;
EXEC DBMS_STATS.GATHER_TABLE_STATS(user, 'SALES_PART_QUERY_HIGH_FIX', degree=>16);


