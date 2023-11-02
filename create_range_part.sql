BEGIN TRANSACTION;

DROP TABLE IF EXISTS employees2;
-- Partitioned table creations
CREATE TABLE employees2 (
  emp_no int,
  birth_date date,
  first_name varchar(14),
  last_name varchar(16),
  gender character(1),
  hire_date date,
  dept_no varchar(5),
  from_date date
) PARTITION BY RANGE (date_part('year', hire_date));

-- select date_part('year', hire_date), count(*) from employees group by date_part('year', hire_date) order by date_part('year', hire_date);
--  date_part | count 
-- -----------+-------
--       1985 | 39080
--       1986 | 40005
--       1987 | 36930
--       1988 | 34705
--       1989 | 31348
--       1990 | 28328
--       1991 | 24934
--       1992 | 22539
--       1993 | 19667
--       1994 | 16463
--       1995 | 13413
--       1996 | 10568
--       1997 |  7375
--       1998 |  4562
--       1999 |  1671
--       2000 |    15
-- (16 rows)

-- Selected partitions (100k rows each)
-- P1 1985-1986
-- P2 1987-1989
-- P3 1990-1993
-- P4 1994-2000


-- Create the partitions

-- [1985-1986]
CREATE TABLE employees2_1985_1987 PARTITION OF employees2
  FOR VALUES FROM (1985) TO (1987);

-- [1987-1989]
CREATE TABLE employees2_1987_1990 PARTITION OF employees2
  FOR VALUES FROM (1987) TO (1990);

-- [1990-1993]
CREATE TABLE employees2_1990_1994 PARTITION OF employees2
  FOR VALUES FROM (1990) TO (1994);

-- [1994-2000]
CREATE TABLE employees2_1994_2001 PARTITION OF employees2
  FOR VALUES FROM (1994) TO (2001);


-- Load the data from ./employees.csv
\COPY employees2 FROM '/home/enrique/Documents/BD2/S11/Lab12_1/employees.csv' DELIMITER ',' CSV HEADER;


COMMIT;
