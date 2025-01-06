--Classes More Than 5 Students
/*
Table: Courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 

Write a solution to find all the classes that have at least five students.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
Output: 
+---------+
| class   |
+---------+
| Math    |
+---------+
Explanation: 
- Math has 6 students, so we include it.
- English has 1 student, so we do not include it.
- Biology has 1 student, so we do not include it.
- Computer has 1 student, so we do not include it.
*/

--Create Tables
CREATE TABLE Courses (student varchar(100),class varchar(100))

--insert data
INSERT INTO Courses VALUES('A','Math')
INSERT INTO Courses VALUES('B','English ')
INSERT INTO Courses VALUES('C','Math')
INSERT INTO Courses VALUES('D','Biology ')
INSERT INTO Courses VALUES('E','Math')
INSERT INTO Courses VALUES('F','Computer')
INSERT INTO Courses VALUES('G','Math')
INSERT INTO Courses VALUES('H','Math')
INSERT INTO Courses VALUES('I','Math')


/* Solution */
SELECT class FROM (
SELECT class, COUNT(student) ct FROM Courses GROUP BY class    
HAVING COUNT(student)>=5)tab

-- Drop the table
DROP TABLE Courses