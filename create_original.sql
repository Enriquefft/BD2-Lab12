BEGIN TRANSACTION;

DROP TABLE IF EXISTS employees;

-- Original table creation
CREATE TABLE employees (
  emp_no int,
  birth_date date,
  first_name varchar(14),
  last_name varchar(16),
  gender character(1),
  hire_date date,
  dept_no varchar(5),
  from_date date
);

-- Populate from employees.csv
\COPY employees FROM '/home/enrique/Documents/BD2/S11/Lab12_1/employees.csv' DELIMITER ',' CSV HEADER;

COMMIT;
