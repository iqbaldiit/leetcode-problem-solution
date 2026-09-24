-- Source(MSSQL) : https://leetcode.com/problems/find-users-with-persistent-behavior-patterns/solutions/8537763/simple-best-solution-by-iqbaldiit-rd18/
/*
	Table: activity

	+--------------+---------+
	| Column Name  | Type    |
	+--------------+---------+
	| user_id      | int     |
	| action_date  | date    |
	| action       | varchar |
	+--------------+---------+
	(user_id, action_date, action) is the primary key (unique value) for this table.
	Each row represents a user performing a specific action on a given date.
	Write a solution to identify behaviorally stable users based on the following definition:

	A user is considered behaviorally stable if there exists a sequence of at least 5 consecutive days such that:
	The user performed exactly one action per day during that period.
	The action is the same on all those consecutive days.
	If a user has multiple qualifying sequences, only consider the sequence with the maximum length.
	Return the result table ordered by streak_length in descending order, then by user_id in ascending order.

	The result format is in the following example.

 

	Example:

	Input:

	activity table:

	+---------+-------------+--------+
	| user_id | action_date | action |
	+---------+-------------+--------+
	| 1       | 2024-01-01  | login  |
	| 1       | 2024-01-02  | login  |
	| 1       | 2024-01-03  | login  |
	| 1       | 2024-01-04  | login  |
	| 1       | 2024-01-05  | login  |
	| 1       | 2024-01-06  | logout |
	| 2       | 2024-01-01  | click  |
	| 2       | 2024-01-02  | click  |
	| 2       | 2024-01-03  | click  |
	| 2       | 2024-01-04  | click  |
	| 3       | 2024-01-01  | view   |
	| 3       | 2024-01-02  | view   |
	| 3       | 2024-01-03  | view   |
	| 3       | 2024-01-04  | view   |
	| 3       | 2024-01-05  | view   |
	| 3       | 2024-01-06  | view   |
	| 3       | 2024-01-07  | view   |
	+---------+-------------+--------+
	Output:

	+---------+--------+---------------+------------+------------+
	| user_id | action | streak_length | start_date | end_date   |
	+---------+--------+---------------+------------+------------+
	| 3       | view   | 7             | 2024-01-01 | 2024-01-07 |
	| 1       | login  | 5             | 2024-01-01 | 2024-01-05 |
	+---------+--------+---------------+------------+------------+
	Explanation:

	User 1:
	Performed login from 2024-01-01 to 2024-01-05 on consecutive days
	Each day has exactly one action, and the action is the same
	Streak length = 5 (meets minimum requirement)
	The action changes on 2024-01-06, ending the streak
	User 2:
	Performed click for only 4 consecutive days
	Does not meet the minimum streak length of 5
	Excluded from the result
	User 3:
	Performed view for 7 consecutive days
	This is the longest valid sequence for this user
	Included in the result
	The Results table is ordered by streak_length in descending order, then by user_id in ascending order
*/

CREATE TABLE activity (
    user_id INT,
    action_date DATE,
    action VARCHAR(50),
    PRIMARY KEY (user_id, action_date, action)
);

--INSERT INTO activity (user_id, action_date, action) VALUES
--(1, '2024-01-01', 'login'),
--(1, '2024-01-02', 'login'),
--(1, '2024-01-03', 'login'),
--(1, '2024-01-04', 'login'),
--(1, '2024-01-05', 'login'),
--(1, '2024-01-06', 'logout'),
--(2, '2024-01-01', 'click'),
--(2, '2024-01-02', 'click'),
--(2, '2024-01-03', 'click'),
--(2, '2024-01-04', 'click'),
--(3, '2024-01-01', 'view'),
--(3, '2024-01-02', 'view'),
--(3, '2024-01-03', 'view'),
--(3, '2024-01-04', 'view'),
--(3, '2024-01-05', 'view'),
--(3, '2024-01-06', 'view'),
--(3, '2024-01-07', 'view');

INSERT INTO activity (user_id, action_date, action) VALUES
(1, '2024-01-01', 'login'),
(1, '2024-01-02', 'login'),
(1, '2024-01-03', 'login'),
(1, '2024-01-04', 'login'),
(1, '2024-01-05', 'login'),
(2, '2024-01-01', 'login'),
(2, '2024-01-02', 'login'),
(2, '2024-01-03', 'login'),
(2, '2024-01-04', 'login'),
(2, '2024-01-05', 'login'),
(2, '2024-01-06', 'login'),
(2, '2024-01-07', 'login'),
(2, '2024-01-08', 'login'),
(3, '2024-01-01', 'click'),
(3, '2024-01-02', 'click'),
(3, '2024-01-03', 'click'),
(3, '2024-01-04', 'click'),
(3, '2024-01-06', 'login'),
(3, '2024-01-07', 'login'),
(3, '2024-01-08', 'login'),
(3, '2024-01-09', 'login'),
(3, '2024-01-10', 'login'),
(3, '2024-01-11', 'login'),
(4, '2024-01-01', 'view'),
(4, '2024-01-02', 'login'),
(4, '2024-01-04', 'login'),
(4, '2024-01-05', 'login'),
(5, '2024-01-01', 'view'),
(5, '2024-01-02', 'view'),
(5, '2024-01-03', 'view'),
(5, '2024-01-04', 'view'),
(5, '2024-01-05', 'view'),
(6, '2024-01-01', 'login'),
(6, '2024-01-02', 'login'),
(6, '2024-01-03', 'login'),
(6, '2024-01-04', 'login'),
(6, '2024-01-05', 'login'),
(6, '2024-01-06', 'login'),
(6, '2024-01-07', 'login'),
(6, '2024-01-08', 'login'),
(7, '2024-01-01', 'view'),
(7, '2024-01-02', 'view'),
(7, '2024-01-03', 'view'),
(7, '2024-01-04', 'view'),
(7, '2024-01-06', 'logout'),
(7, '2024-01-07', 'logout'),
(7, '2024-01-08', 'logout'),
(7, '2024-01-09', 'logout'),
(7, '2024-01-10', 'logout'),
(7, '2024-01-11', 'logout'),
(8, '2024-01-01', 'view'),
(8, '2024-01-03', 'click'),
(8, '2024-01-04', 'view'),
(8, '2024-01-06', 'click'),
(8, '2024-01-08', 'view'),
(8, '2024-01-09', 'click'),
(9, '2024-01-01', 'login'),
(9, '2024-01-02', 'login'),
(9, '2024-01-03', 'login'),
(9, '2024-01-04', 'login'),
(9, '2024-01-05', 'login'),
(10, '2024-01-01', 'logout'),
(10, '2024-01-02', 'logout'),
(10, '2024-01-03', 'logout'),
(10, '2024-01-04', 'logout'),
(10, '2024-01-05', 'logout'),
(10, '2024-01-06', 'logout'),
(11, '2024-01-01', 'click'),
(11, '2024-01-02', 'click'),
(11, '2024-01-03', 'click'),
(11, '2024-01-04', 'click'),
(11, '2024-01-06', 'view'),
(11, '2024-01-07', 'view'),
(11, '2024-01-08', 'view'),
(11, '2024-01-09', 'view'),
(11, '2024-01-10', 'view'),
(11, '2024-01-11', 'view');

--solution
SELECT * FROM activity WHERE user_id=2;

WITH tbl_lead AS (
SELECT *
, LEAD(action_date) OVER (PARTITION BY user_id,action ORDER BY user_id,action) AS next_date
, COUNT(action) OVER (PARTITION BY user_id,action_date) AS action_count
FROM activity 
)
SELECT user_id,action
,SUM(DATEDIFF(DAY,action_date,next_date))+1 AS streak_length 
,MIN(action_date) start_date
,MAX(next_date) end_date
FROM tbl_lead WHERE action_count=1 AND DATEDIFF(DAY,action_date,next_date)=1
GROUP BY user_id,action
HAVING SUM(DATEDIFF(DAY,action_date,next_date))+1>=5
ORDER BY streak_length DESC, user_id ASC

--SELECT * 
--,(DATEDIFF(DAY,action_date,next_date))+1 AS streak_length 
--FROM tbl_lead WHERE DATEDIFF(DAY,action_date,next_date)=1
-- drop  table
DROP TABLE activity