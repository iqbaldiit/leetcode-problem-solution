--Source (MSSQL): https://leetcode.com/problems/nth-highest-salary/solutions/6556302/simple-best-solution-by-iqbaldiit-9syd/
--Source (mySQL): https://leetcode.com/problems/nth-highest-salary/solutions/6559900/simple-best-solution-by-iqbaldiit-50ek/
--Source (pgSQL): https://leetcode.com/problems/nth-highest-salary/solutions/6560096/simple-best-solution-by-iqbaldiit-h76l/
/*
	Table: Employee

	+-------------+------+
	| Column Name | Type |
	+-------------+------+
	| id          | int  |
	| salary      | int  |
	+-------------+------+
	id is the primary key (column with unique values) for this table.
	Each row of this table contains information about the salary of an employee.

	Write a solution to find the nth highest salary from the Employee table. 
	If there is no nth highest salary, return null.

	The result format is in the following example.

	Example 1:
	Input: 
	Employee table:
	+----+--------+
	| id | salary |
	+----+--------+
	| 1  | 100    |
	| 2  | 200    |
	| 3  | 300    |
	+----+--------+
	n = 2
	Output: 
	+------------------------+
	| getNthHighestSalary(2) |
	+------------------------+
	| 200                    |
	+------------------------+

	Example 2:
	Input: 
	Employee table:
	+----+--------+
	| id | salary |
	+----+--------+
	| 1  | 100    |
	+----+--------+
	n = 2

	Output: 
	+------------------------+
	| getNthHighestSalary(2) |
	+------------------------+
	| null                   |
	+------------------------+
*/

--Create table
CREATE TABLE Employee (id int,salary int);

--Variable declaration
DECLARE @N AS INT=1

--Insert records
INSERT INTO Employee VALUES (1,100);
INSERT INTO Employee VALUES (2,100);
INSERT INTO Employee VALUES (3,300);

--Solution (MSSQL)
SELECT DISTINCT salary AS [getNthHighestSalary(2)] 
FROM (
	SELECT *, DENSE_RANK() OVER (Order By Salary DESC) RK FROM Employee
)tab WHERE tab.RK=@N

-- --Solution (mySQL)
-- N=2;
-- SELECT DISTINCT salary AS getNthHighestSalary 
-- FROM (
--     SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS RK 
--     FROM Employee
-- ) AS tab 
-- WHERE tab.RK = N

-- -- Solution (PGSQL)
-- DO $$  
-- DECLARE  
--     N INT := 2;  -- Set N = 2 (for second highest salary)
--     result INT;
-- BEGIN  
--     SELECT salary INTO result
--     FROM (
--         SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS RK 
--         FROM Employee
--     ) AS tab 
--     WHERE tab.RK = N
--     LIMIT 1;     

--     -- Print the result to console
--     RAISE NOTICE 'The %th highest salary is %', N, result;

-- END $$;

---- leet code submission (PgSQL)
    -- SELECT tab.salary  FROM (
	-- 	SELECT e.salary, DENSE_RANK() OVER (ORDER BY e.salary DESC) rk FROM Employee e
	-- ) tab  WHERE tab.rk = N  LIMIT 1  



--Drop table
DROP TABLE Employee
