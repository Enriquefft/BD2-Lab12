BEGIN TRANSACTION;

DROP INDEX IF EXISTS employees_hire_date_idx;
DROP INDEX IF EXISTS employees2_hire_date_idx;


CREATE INDEX employees_hire_date_idx ON employees (hire_date);
CREATE INDEX employees2_hire_date_idx ON employees2 (hire_date);

COMMIT;
