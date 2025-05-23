--Source (MSSQL):https://leetcode.com/problems/game-play-analysis-i/solutions/6593020/simple-best-solution-by-iqbaldiit-dqmn/ 
--Source (PGSQL):https://leetcode.com/problems/game-play-analysis-i/solutions/6593026/simple-best-solution-by-iqbaldiit-mxtk/
--Source (MYSQL):https://leetcode.com/problems/game-play-analysis-i/solutions/6593024/simple-best-solution-by-iqbaldiit-j94i/
/*
	Table: Activity

	+--------------+---------+
	| Column Name  | Type    |
	+--------------+---------+
	| player_id    | int     |
	| device_id    | int     |
	| event_date   | date    |
	| games_played | int     |
	+--------------+---------+
	(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
	This table shows the activity of players of some games.
	Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

	Write a solution to find the first login date for each player.

	Return the result table in any order.

	The result format is in the following example.

 

	Example 1:

	Input: 
	Activity table:
	+-----------+-----------+------------+--------------+
	| player_id | device_id | event_date | games_played |
	+-----------+-----------+------------+--------------+
	| 1         | 2         | 2016-03-01 | 5            |
	| 1         | 2         | 2016-05-02 | 6            |
	| 2         | 3         | 2017-06-25 | 1            |
	| 3         | 1         | 2016-03-02 | 0            |
	| 3         | 4         | 2018-07-03 | 5            |
	+-----------+-----------+------------+--------------+
	Output: 
	+-----------+-------------+
	| player_id | first_login |
	+-----------+-------------+
	| 1         | 2016-03-01  |
	| 2         | 2017-06-25  |
	| 3         | 2016-03-02  |
	+-----------+-------------+
*/

--crete table
CREATE TABLE Activity (player_id INT ,device_id INT,event_date DATE,games_played INT);

--insert into table
INSERT INTO Activity VALUES (1,2,'2016-03-01',5);
INSERT INTO Activity VALUES (1,2,'2016-05-02',6);
INSERT INTO Activity VALUES (2,3,'2017-06-25',1);
INSERT INTO Activity VALUES (3,1,'2016-03-02',0);
INSERT INTO Activity VALUES (3,4,'2018-07-03',5);

--Solution (MSSQL, PGSQL, MYSQL)
SELECT player_id, MIN(event_date) first_login FROM Activity
GROUP BY player_id;

--drop table 
DROP TABLE Activity;
