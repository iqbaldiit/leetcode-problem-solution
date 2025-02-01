/*
Source: https://leetcode.com/problems/employees-with-missing-information/solutions/6354902/simple-best-solution-by-iqbaldiit-87a5/

Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
 

Table: Salaries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
 

Write a solution to report the IDs of all the employees with missing information. 
The information of an employee is missing if:

The employee's name is missing, or
The employee's salary is missing.
Return the result table ordered by employee_id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |
+-------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+
Explanation: 
Employees 1, 2, 4, and 5 are working at this company.
The name of employee 1 is missing.
The salary of employee 2 is missing.
*/

--Create Table
CREATE TABLE Employees (employee_id INT,name VARCHAR(100));
CREATE TABLE Salaries (employee_id INT,salary INT);
--Insert Table
INSERT INTO Employees VALUES(2,'Crew');
INSERT INTO Employees VALUES(4,'Haven');
INSERT INTO Employees VALUES(5,'Kristian');

INSERT INTO Salaries VALUES(5,76071);
INSERT INTO Salaries VALUES(1,22517);
INSERT INTO Salaries VALUES(4,63539);

--Solution (MSSQL, PostGresSQL, MySQL)-- Approach:1

SELECT S.employee_id FROM Employees E
RIGHT JOIN Salaries S ON E.employee_id=S.employee_id WHERE E.name IS NULL
UNION ALL
SELECT E.employee_id FROM Employees E
LEFT JOIN Salaries S ON E.employee_id=S.employee_id WHERE S.salary  IS NULL
ORDER BY employee_id

--Solution (MSSQL, PostGresSQL)-- Approach:2
SELECT COALESCE(E.employee_id,S.employee_id) employee_id
FROM Employees E
FULL JOIN Salaries S ON E.employee_id=S.employee_id
WHERE E.employee_id IS NULL OR S.employee_id IS NULL
ORDER BY employee_id



--DROP TABLE
DROP TABLE Employees
DROP TABLE Salaries