--Source: https://leetcode.com/problems/find-overbooked-employees/
/*
	Table: employees

	+---------------+---------+
	| Column Name   | Type    |
	+---------------+---------+
	| employee_id   | int     |
	| employee_name | varchar |
	| department    | varchar |
	+---------------+---------+
	employee_id is the unique identifier for this table.
	Each row contains information about an employee and their department.
	Table: meetings

	+---------------+---------+
	| Column Name   | Type    |
	+---------------+---------+
	| meeting_id    | int     |
	| employee_id   | int     |
	| meeting_date  | date    |
	| meeting_type  | varchar |
	| duration_hours| decimal |
	+---------------+---------+
	meeting_id is the unique identifier for this table.
	Each row represents a meeting attended by an employee. meeting_type can be 'Team', 'Client', or 'Training'.
	Write a solution to find employees who are meeting-heavy - employees who spend more than 50% of their working time in meetings during any given week.

	Assume a standard work week is 40 hours
	Calculate total meeting hours per employee per week (Monday to Sunday)
	An employee is meeting-heavy if their weekly meeting hours > 20 hours (50% of 40 hours)
	Count how many weeks each employee was meeting-heavy
	Only include employees who were meeting-heavy for at least 2 weeks
	Return the result table ordered by the number of meeting-heavy weeks in descending order, then by employee name in ascending order.

	The result format is in the following example.

 

	Example:

	Input:

	employees table:

	+-------------+----------------+-------------+
	| employee_id | employee_name  | department  |
	+-------------+----------------+-------------+
	| 1           | Alice Johnson  | Engineering |
	| 2           | Bob Smith      | Marketing   |
	| 3           | Carol Davis    | Sales       |
	| 4           | David Wilson   | Engineering |
	| 5           | Emma Brown     | HR          |
	+-------------+----------------+-------------+
	meetings table:

	+------------+-------------+--------------+--------------+----------------+
	| meeting_id | employee_id | meeting_date | meeting_type | duration_hours |
	+------------+-------------+--------------+--------------+----------------+
	| 1          | 1           | 2023-06-05   | Team         | 8.0            |
	| 2          | 1           | 2023-06-06   | Client       | 6.0            |
	| 3          | 1           | 2023-06-07   | Training     | 7.0            |
	| 4          | 1           | 2023-06-12   | Team         | 12.0           |
	| 5          | 1           | 2023-06-13   | Client       | 9.0            |
	| 6          | 2           | 2023-06-05   | Team         | 15.0           |
	| 7          | 2           | 2023-06-06   | Client       | 8.0            |
	| 8          | 2           | 2023-06-12   | Training     | 10.0           |
	| 9          | 3           | 2023-06-05   | Team         | 4.0            |
	| 10         | 3           | 2023-06-06   | Client       | 3.0            |
	| 11         | 4           | 2023-06-05   | Team         | 25.0           |
	| 12         | 4           | 2023-06-19   | Client       | 22.0           |
	| 13         | 5           | 2023-06-05   | Training     | 2.0            |
	+------------+-------------+--------------+--------------+----------------+
	Output:

	+-------------+----------------+-------------+---------------------+
	| employee_id | employee_name  | department  | meeting_heavy_weeks |
	+-------------+----------------+-------------+---------------------+
	| 1           | Alice Johnson  | Engineering | 2                   |
	| 4           | David Wilson   | Engineering | 2                   |
	+-------------+----------------+-------------+---------------------+
	Explanation:

	Alice Johnson (employee_id = 1):
	Week of June 5-11 (2023-06-05 to 2023-06-11): 8.0 + 6.0 + 7.0 = 21.0 hours (> 20 hours)
	Week of June 12-18 (2023-06-12 to 2023-06-18): 12.0 + 9.0 = 21.0 hours (> 20 hours)
	Meeting-heavy for 2 weeks
	David Wilson (employee_id = 4):
	Week of June 5-11: 25.0 hours (> 20 hours)
	Week of June 19-25: 22.0 hours (> 20 hours)
	Meeting-heavy for 2 weeks
	Employees not included:
	Bob Smith (employee_id = 2): Week of June 5-11: 15.0 + 8.0 = 23.0 hours (> 20), Week of June 12-18: 10.0 hours (< 20). Only 1 meeting-heavy week
	Carol Davis (employee_id = 3): Week of June 5-11: 4.0 + 3.0 = 7.0 hours (< 20). No meeting-heavy weeks
	Emma Brown (employee_id = 5): Week of June 5-11: 2.0 hours (< 20). No meeting-heavy weeks
	The result table is ordered by meeting_heavy_weeks in descending order, then by employee name in ascending order.
*/

--create table
CREATE TABLE employees (employee_id INT,employee_name VARCHAR(255),department VARCHAR(100))
CREATE TABLE meetings (meeting_id INT,employee_id INT,meeting_date DATE,meeting_type VARCHAR(50),duration_hours DECIMAL(4, 2))

---- create table employees
--insert into employees (employee_id, employee_name, department) values ('1', 'Alice Johnson', 'Engineering')
--insert into employees (employee_id, employee_name, department) values ('2', 'Bob Smith', 'Marketing')
--insert into employees (employee_id, employee_name, department) values ('3', 'Carol Davis', 'Sales')
--insert into employees (employee_id, employee_name, department) values ('4', 'David Wilson', 'Engineering')
--insert into employees (employee_id, employee_name, department) values ('5', 'Emma Brown', 'HR');

insert into employees (employee_id, employee_name, department) values ('1', 'Yolanda Harris', 'Finance')
insert into employees (employee_id, employee_name, department) values ('2', 'Carol Wright', 'Engineering')

---- create table meetings
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('1', '1', '2023-06-05', 'Team', '8.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('2', '1', '2023-06-06', 'Client', '6.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('3', '1', '2023-06-07', 'Training', '7.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('4', '1', '2023-06-12', 'Team', '12.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('5', '1', '2023-06-13', 'Client', '9.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('6', '2', '2023-06-05', 'Team', '15.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('7', '2', '2023-06-06', 'Client', '8.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('8', '2', '2023-06-12', 'Training', '10.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('9', '3', '2023-06-05', 'Team', '4.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('10', '3', '2023-06-06', 'Client', '3.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('11', '4', '2023-06-05', 'Team', '25.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('12', '4', '2023-06-19', 'Client', '22.0')
--insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values ('13', '5', '2023-06-05', 'Training', '2.0');

insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (1,1,'2023-06-05','Team',2.9)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (2,1,'2023-06-06','Client',31.4)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (3,1,'2023-06-11','Training',1.6)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (4,1,'2023-06-10','Team',2.4)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (5,1,'2023-06-11','Client',2.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (6,1,'2023-06-09','Training',3.2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (7,1,'2023-06-19','Client',6.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (8,1,'2023-06-17','Team',22.2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (9,1,'2023-06-26','Client',5.4)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (10,1,'2023-06-25','Team',3.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (11,1,'2023-06-26','Client',17.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (12,1,'2023-06-30','Client',2.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (13,1,'2023-07-03','Training',2.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (14,1,'2023-07-01','Team',0.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (15,1,'2023-07-01','Team',6.5)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (16,1,'2023-07-06','Client',0.7)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (17,1,'2023-07-10','Team',12.4)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (18,1,'2023-07-17','Training',1.2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (19,1,'2023-07-16','Team',2.2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (20,1,'2023-07-14','Team',2.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (21,1,'2023-07-13','Client',3.3)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (22,1,'2023-07-24','Training',4)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (23,1,'2023-07-21','Team',7.4)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (24,1,'2023-07-23','Team',12.7)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (25,2,'2023-06-05','Training',2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (26,2,'2023-06-04','Training',3.6)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (27,2,'2023-06-04','Team',2.1)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (28,2,'2023-06-03','Training',3.4)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (29,2,'2023-06-10','Training',2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (30,2,'2023-06-10','Team',7.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (31,2,'2023-06-19','Team',0.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (32,2,'2023-06-16','Team',1.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (33,2,'2023-06-16','Team',5.1)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (34,2,'2023-06-26','Team',4)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (35,2,'2023-06-23','Client',22.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (36,2,'2023-06-29','Training',3.5)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (37,2,'2023-07-02','Client',2.2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (38,2,'2023-07-01','Client',2.2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (39,2,'2023-07-03','Training',1)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (40,2,'2023-07-07','Client',4.2)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (41,2,'2023-07-09','Client',4.1)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (42,2,'2023-07-08','Training',23)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (43,2,'2023-07-18','Client',1.7)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (44,2,'2023-07-14','Training',28.8)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (45,2,'2023-07-24','Team',2.5)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (46,2,'2023-07-20','Team',2.7)
insert into meetings (meeting_id, employee_id, meeting_date, meeting_type, duration_hours) values (47,2,'2023-07-23','Team',5.1);

--Solution ()

WITH hr_meeting as (
SELECT employee_id , DATEPART(WEEK,meeting_date) as wk ,sum(duration_hours) as total_hours
from meetings 
GROUP BY employee_id , DATEPART(WEEK,meeting_date)
)
SELECT m.employee_id,employee_name,department,COUNT(*) as meeting_heavy_weeks FROM hr_meeting m
INNER JOIN employees e ON e.employee_id=m.employee_id WHERE total_hours >20
GROUP BY  m.employee_id ,e.employee_name ,e.department HAVING count(wk) >1 
ORDER BY  meeting_heavy_weeks desc ,employee_name asc



--Solution (MySQL)
--WITH hr_meeting AS (
--	SELECT employee_id,SUM(duration_hours) AS weekly_hours FROM meetings
--	GROUP BY employee_id,WEEK(meeting_date),YEAR(meeting_date) 
--	HAVING SUM(duration_hours)>=20
--), wk_meeting AS (
--	SELECT employee_id,COUNT(*) AS meeting_heavy_weeks  FROM hr_meeting
--	GROUP BY employee_id HAVING COUNT(*)>=2
--)
--SELECT  wk.employee_id,emp.employee_name,emp.department,wk.meeting_heavy_weeks
--FROM wk_meeting wk
--INNER JOIN employees emp ON wk.employee_id=emp.employee_id
--ORDER BY wk.meeting_heavy_weeks DESC, emp.employee_name ASC

--drop tables
DROP TABLE employees
DROP TABLE meetings