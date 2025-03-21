--Source: (MSSQL): https://leetcode.com/problems/second-highest-salary/solutions/5294837/easy-and-simple-solution/
--Source: (PgSQL): https://leetcode.com/problems/second-highest-salary/submissions/1581404551/?envType=study-plan-v2&envId=30-days-of-pandas&lang=pythondata
--Source: (mySQL): https://leetcode.com/problems/second-highest-salary/solutions/6563433/simple-best-solution-by-iqbaldiit-u9l5/

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
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

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
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
*/

--Create table
CREATE TABLE Employee (id int,salary int);


--Insert records
INSERT INTO Employee VALUES (1,100);
INSERT INTO Employee VALUES (2,200);
INSERT INTO Employee VALUES (3,300);

--Solution (MSSQL, PGSQL, mySQL)
SELECT MAX(salary) AS SecondHighestSalary 
FROM (
	SELECT salary, DENSE_RANK() OVER (Order By Salary DESC) RK FROM Employee
)tab WHERE tab.RK=2

--Drop table
DROP TABLE Employee