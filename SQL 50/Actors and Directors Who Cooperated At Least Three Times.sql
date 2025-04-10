--Source (mssql):https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/solutions/6635240/simple-best-solution-by-iqbaldiit-fx3d/
--Source (pgsql):https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/solutions/6635239/simple-best-solution-by-iqbaldiit-6tn2/
--Source (mysql):https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/solutions/6635233/simple-best-solution-by-iqbaldiit-y3sc/ 
--Source (oracle): https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/solutions/6635245/simple-best-solution-by-iqbaldiit-xt1x/
/*
	Table: ActorDirector

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| actor_id    | int     |
	| director_id | int     |
	| timestamp   | int     |
	+-------------+---------+
	timestamp is the primary key (column with unique values) for this table.
 

	Write a solution to find all the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.

	Return the result table in any order.

	The result format is in the following example.

 

	Example 1:

	Input: 
	ActorDirector table:
	+-------------+-------------+-------------+
	| actor_id    | director_id | timestamp   |
	+-------------+-------------+-------------+
	| 1           | 1           | 0           |
	| 1           | 1           | 1           |
	| 1           | 1           | 2           |
	| 1           | 2           | 3           |
	| 1           | 2           | 4           |
	| 2           | 1           | 5           |
	| 2           | 1           | 6           |
	+-------------+-------------+-------------+
	Output: 
	+-------------+-------------+
	| actor_id    | director_id |
	+-------------+-------------+
	| 1           | 1           |
	+-------------+-------------+
	Explanation: The only pair is (1, 1) where they cooperated exactly 3 times.
*/

--crete table
CREATE TABLE ActorDirector (actor_id INT,director_id INT,timestamp INT);

--insert data
INSERT INTO ActorDirector (actor_id, director_id, timestamp) VALUES
(1, 1, 0),(1, 1, 1),(1, 1, 2),(1, 2, 3),(1, 2, 4),(2, 1, 5),(2, 1, 6);

--solution (mssql,mysql,pgsql,oracle)
SELECT actor_id,director_id FROM ActorDirector
GROUP BY actor_id,director_id HAVING COUNT(timestamp)>=3;

--drop table
DROP TABLE ActorDirector