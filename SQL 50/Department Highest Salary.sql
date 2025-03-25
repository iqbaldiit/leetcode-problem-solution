--Source (MSSQL): https://leetcode.com/problems/department-highest-salary/solutions/6578570/simple-best-solution-by-iqbaldiit-mo30/
--Source (MySQL): https://leetcode.com/problems/department-highest-salary/solutions/6578575/simple-best-solution-by-iqbaldiit-in7w/
--Source (PgSQL): https://leetcode.com/problems/department-highest-salary/solutions/6578581/simple-best-solution-by-iqbaldiit-npeu/
/*
	Table: Employee

	+--------------+---------+
	| Column Name  | Type    |
	+--------------+---------+
	| id           | int     |
	| name         | varchar |
	| salary       | int     |
	| departmentId | int     |
	+--------------+---------+

	id is the primary key (column with unique values) for this table.
	departmentId is a foreign key (reference columns) of the ID from the Department table.
	Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

	Table: Department
	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| id          | int     |
	| name        | varchar |
	+-------------+---------+

	id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
	Each row of this table indicates the ID of a department and its name.
 

	Write a solution to find employees who have the highest salary in each of the departments.
	Return the result table in any order.
	The result format is in the following example.
*/
--Create table
CREATE TABLE Employee (id int, name varchar(100),salary int,departmentId int);
CREATE TABLE Department (id int, name varchar(100));

-- Insert data into table
INSERT INTO Employee VALUES(1,'Joe',70000,1);
INSERT INTO Employee VALUES(2,'Jim',90000,1);
INSERT INTO Employee VALUES(3,'Henry',80000,2);
INSERT INTO Employee VALUES(4,'Sam',60000,2);
INSERT INTO Employee VALUES(5,'Max',90000,1);

INSERT INTO Department VALUES(1,'IT');
INSERT INTO Department VALUES(2,'Sales');

--Solution Approach: 1 (MSSQL, MySQL)
SELECT D.name AS Department, E.name AS Employee, tab.Salary 
FROM  (
	SELECT E.departmentId, MAX(E.salary) Salary 
	FROM Employee E GROUP BY E.departmentId
)tab
INNER JOIN Employee E ON E.departmentId=tab.departmentId AND E.salary=tab.Salary
INNER JOIN Department D ON D.id=tab.departmentId

--Solution Approach: 2 (MSSQL)
;WITH tab AS (
	SELECT E.departmentId,E.name AS Employee, E.salary, DENSE_RANK () OVER (PARTITION BY E.departmentId ORDER BY E.salary DESC) AS rk
	FROM Employee E 
)
SELECT D.name AS Department, tab.Employee,tab.salary  FROM tab
INNER JOIN Department D ON tab.departmentId=D.id
WHERE tab.rk=1

--Drop table
DROP TABLE Employee
DROP TABLE Department

