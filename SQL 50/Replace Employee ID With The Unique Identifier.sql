--Source (mssql): https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/solutions/6638672/simple-best-solution-by-iqbaldiit-0hce/
--Source (pgsql): https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/solutions/6638679/simple-best-solution-by-iqbaldiit-a9po/
--Source (mysql): https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/solutions/6638640/simple-best-solution-by-iqbaldiit-mg1h/
--Source (oracle):https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/solutions/6638669/simple-best-solution-by-iqbaldiit-m2w6/
/*
	Table: Employees

	+---------------+---------+
	| Column Name   | Type    |
	+---------------+---------+
	| id            | int     |
	| name          | varchar |
	+---------------+---------+
	id is the primary key (column with unique values) for this table.
	Each row of this table contains the id and the name of an employee in a company.
 

	Table: EmployeeUNI

	+---------------+---------+
	| Column Name   | Type    |
	+---------------+---------+
	| id            | int     |
	| unique_id     | int     |
	+---------------+---------+
	(id, unique_id) is the primary key (combination of columns with unique values) for this table.
	Each row of this table contains the id and the corresponding unique id of an employee in the company.
 

	Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

	Return the result table in any order.

	The result format is in the following example.

 

	Example 1:

	Input: 
	Employees table:
	+----+----------+
	| id | name     |
	+----+----------+
	| 1  | Alice    |
	| 7  | Bob      |
	| 11 | Meir     |
	| 90 | Winston  |
	| 3  | Jonathan |
	+----+----------+
	EmployeeUNI table:
	+----+-----------+
	| id | unique_id |
	+----+-----------+
	| 3  | 1         |
	| 11 | 2         |
	| 90 | 3         |
	+----+-----------+
	Output: 
	+-----------+----------+
	| unique_id | name     |
	+-----------+----------+
	| null      | Alice    |
	| null      | Bob      |
	| 2         | Meir     |
	| 3         | Winston  |
	| 1         | Jonathan |
	+-----------+----------+
	Explanation: 
	Alice and Bob do not have a unique ID, We will show null instead.
	The unique ID of Meir is 2.
	The unique ID of Winston is 3.
	The unique ID of Jonathan is 1.
*/

-- create table
CREATE TABLE Employees (id int,name varchar(100))
CREATE TABLE EmployeeUNI (id int,unique_id int)

--insert into table
INSERT INTO Employees VALUES (1,'Alice');
INSERT INTO Employees VALUES (7,'Bob')
INSERT INTO Employees VALUES (11,'Meir')
INSERT INTO Employees VALUES (90,'Winston')
INSERT INTO Employees VALUES (3,'Jonathan')

--insert into table
INSERT INTO EmployeeUNI VALUES (3 ,1)
INSERT INTO EmployeeUNI VALUES (11,2)
INSERT INTO EmployeeUNI VALUES (90,3)


--Solution (mssql, mysql, pgsql)
SELECT U.unique_id, E.name
FROM Employees E 
LEFT JOIN EmployeeUNI U ON E.id=U.id

--drop table
DROP TABLE Employees
DROP TABLE EmployeeUNI