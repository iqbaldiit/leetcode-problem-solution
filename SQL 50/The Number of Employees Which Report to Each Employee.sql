/*
Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.

The result format is in the following example.

 

Example 1:

Input: 
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+
Output: 
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
Explanation: Hercy has 2 people report directly to him, Alice and Bob. Their average age is (41+36)/2 = 38.5, which is 39 after rounding it to the nearest integer.
Example 2:

Input: 
Employees table:
+-------------+---------+------------+-----+ 
| employee_id | name    | reports_to | age |
|-------------|---------|------------|-----|
| 1           | Michael | null       | 45  |
| 2           | Alice   | 1          | 38  |
| 3           | Bob     | 1          | 42  |
| 4           | Charlie | 2          | 34  |
| 5           | David   | 2          | 40  |
| 6           | Eve     | 3          | 37  |
| 7           | Frank   | null       | 50  |
| 8           | Grace   | null       | 48  |
+-------------+---------+------------+-----+ 
Output: 
+-------------+---------+---------------+-------------+
| employee_id | name    | reports_count | average_age |
| ----------- | ------- | ------------- | ----------- |
| 1           | Michael | 2             | 40          |
| 2           | Alice   | 2             | 37          |
| 3           | Bob     | 1             | 37          |
+-------------+---------+---------------+-------------+
*/


--Create an employee table 
CREATE TABLE Employees (employee_id INT, [name] VARCHAR(50), reports_to INT, age INT)

--insert data to employee table
INSERT INTO Employees VALUES(1,'Michael',null,45)
INSERT INTO Employees VALUES(2,'Alice',1 ,38)
INSERT INTO Employees VALUES(3,'Bob',1 ,42)
INSERT INTO Employees VALUES(4,'Charlie',2 ,34)
INSERT INTO Employees VALUES(5,'David',2 ,40)
INSERT INTO Employees VALUES(6,'Eve',3 ,37)
INSERT INTO Employees VALUES(7,'Frank',null,50)
INSERT INTO Employees VALUES(8,'Grace',null,48)

/* Write your T-SQL query statement below */
SELECT M.reports_to AS employee_id,E.name
,COUNT(M.employee_id) reports_count, ROUND(SUM(age)*1.00/COUNT(M.employee_id)*1.00,0) average_age 
FROM Employees M 
LEFT JOIN (SELECT DISTINCT employee_id,name FROm Employees) E 
ON M.reports_to=E.employee_id
WHERE M.reports_to IS NOT NULL
GROUP BY M.reports_to,E.name

--DROP table
DROP TABLE Employees