#!/bin/bash



test_query ()
{
  local query=$1
  psql -P pager=off -d lab12 -c '\timing' -c "$query" | tail -n 1
  
}

run_test ()
{
  echo "Query $1"

  local query=$2

  local query2=${query//employees/employees2}

  echo "Base table:"
  test_query "$query"

  echo "Partitioned table:"
  test_query "$query2"

  echo " "

}

run_queries ()

{
  run_test 1 "SELECT * FROM employees WHERE date_part('year', hire_date) = 1985 OR date_part('year', hire_date) = 1986;"

  run_test 2 "SELECT * FROM employees WHERE date_part('year', hire_date) BETWEEN 1994 and 1996 OR date_part('year', hire_date) BETWEEN 1998 and 2000 AND gender = 'M';"

  run_test 3 "
  SELECT e1.* 
  FROM employees e1
  JOIN employees e2 ON e1.emp_no = e2.emp_no
  WHERE (date_part('year', e1.hire_date) BETWEEN 1990 AND 1993 OR date_part('year', e1.hire_date) BETWEEN 1991 AND 1992) 
  AND e1.gender = 'M'
  AND date_part('year', e2.hire_date) BETWEEN 1992 AND 1993;"
}

create_tables ()
{
  psql -d lab12 -f create_original.sql
  psql -d lab12 -f create_range_part.sql
  echo "Created tables"
}

create_indexes()
{
  psql -d lab12 -f create_indexes.sql
  echo "Created btree indexes on hire_date"
}

main() {
  create_tables
  run_queries
  create_indexes
  run_queries
}


main
