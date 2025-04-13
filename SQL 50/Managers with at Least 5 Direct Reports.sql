--source(mssql): https://leetcode.com/problems/managers-with-at-least-5-direct-reports/solutions/6645963/simple-best-solution-by-iqbaldiit-w0f4/
--source(mysql): https://leetcode.com/problems/managers-with-at-least-5-direct-reports/solutions/6645952/simple-best-solution-by-iqbaldiit-mrkd/
--source(pgsql): https://leetcode.com/problems/managers-with-at-least-5-direct-reports/solutions/6645962/simple-best-solution-by-iqbaldiit-i2cm/
--source(oracle): https://leetcode.com/problems/managers-with-at-least-5-direct-reports/solutions/6645955/simple-best-solution-by-iqbaldiit-snhf/
/*
	Table: Employee

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| id          | int     |
	| name        | varchar |
	| department  | varchar |
	| managerId   | int     |
	+-------------+---------+
	id is the primary key (column with unique values) for this table.
	Each row of this table indicates the name of an employee, their department, and the id of their manager.
	If managerId is null, then the employee does not have a manager.
	No employee will be the manager of themself.
 

	Write a solution to find managers with at least five direct reports.

	Return the result table in any order.

	The result format is in the following example.

 

	Example 1:

	Input: 
	Employee table:
	+-----+-------+------------+-----------+
	| id  | name  | department | managerId |
	+-----+-------+------------+-----------+
	| 101 | John  | A          | null      |
	| 102 | Dan   | A          | 101       |
	| 103 | James | A          | 101       |
	| 104 | Amy   | A          | 101       |
	| 105 | Anne  | A          | 101       |
	| 106 | Ron   | B          | 101       |
	+-----+-------+------------+-----------+
	Output: 
	+------+
	| name |
	+------+
	| John |
	+------+
*/

--create table
CREATE TABLE Employee (id INT,name VARCHAR(50),department VARCHAR(50),managerId INT NULL);

--INSERT TABLE
INSERT INTO Employee (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),(102, 'Dan', 'A', 101),(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),(105, 'Anne', 'A', 101),(106, 'Ron', 'B', 101);

--Solution (mssql,mysql,pgsql,oracle)
SELECT E.name
FROM Employee M
LEFT JOIN Employee E On M.managerId=E.id  
WHERE M.managerId IS NOT NULL AND E.id IS NOT NULL
GROUP BY M.managerId,E.name HAVING COUNT(M.id)>=5

--drop table 
DROP TABLE Employee