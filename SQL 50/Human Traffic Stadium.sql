--Source (mssql): https://leetcode.com/problems/human-traffic-of-stadium/solutions/6691396/simple-best-solution-by-iqbaldiit-f4y2/
--Source (mysql): https://leetcode.com/problems/human-traffic-of-stadium/solutions/6691392/simple-best-solution-by-iqbaldiit-d0t5/
--Source (pgsql): https://leetcode.com/problems/human-traffic-of-stadium/solutions/6691421/simple-best-solution-by-iqbaldiit-yfo5/
--Source (oracle): https://leetcode.com/problems/human-traffic-of-stadium/solutions/6691419/simple-best-solution-by-iqbaldiit-oh95/
/* 
	Table: Stadium

	+---------------+---------+
	| Column Name   | Type    |
	+---------------+---------+
	| id            | int     |
	| visit_date    | date    |
	| people        | int     |
	+---------------+---------+
	visit_date is the column with unique values for this table.
	Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
	As the id increases, the date increases as well.
 

	Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

	Return the result table ordered by visit_date in ascending order.

	The result format is in the following example.

 

	Example 1:

	Input: 
	Stadium table:
	+------+------------+-----------+
	| id   | visit_date | people    |
	+------+------------+-----------+
	| 1    | 2017-01-01 | 10        |
	| 2    | 2017-01-02 | 109       |
	| 3    | 2017-01-03 | 150       |
	| 4    | 2017-01-04 | 99        |
	| 5    | 2017-01-05 | 145       |
	| 6    | 2017-01-06 | 1455      |
	| 7    | 2017-01-07 | 199       |
	| 8    | 2017-01-09 | 188       |
	+------+------------+-----------+
	Output: 
	+------+------------+-----------+
	| id   | visit_date | people    |
	+------+------------+-----------+
	| 5    | 2017-01-05 | 145       |
	| 6    | 2017-01-06 | 1455      |
	| 7    | 2017-01-07 | 199       |
	| 8    | 2017-01-09 | 188       |
	+------+------------+-----------+
	Explanation: 
	The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
	The rows with ids 2 and 3 are not included because we need at least three consecutive ids.
*/

-- Create table
CREATE TABLE Stadium (
id INT,visit_date DATE, people INT);

-- Insert the example data
INSERT INTO Stadium (id, visit_date, people) VALUES
(1, '2017-01-01', 10),(2, '2017-01-02', 109),(3, '2017-01-03', 150),
(4, '2017-01-04', 99),(5, '2017-01-05', 145),(6, '2017-01-06', 1455),
(7, '2017-01-07', 199),(8, '2017-01-09', 188);

--Solution (mssql, pgsql)
WITH RankedStadium AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY id) AS rn
    FROM Stadium
    WHERE people >= 100
)
,ConsecutiveGroups AS (
    SELECT id, visit_date, people,
           rn - id AS group_id
    FROM RankedStadium
)
,FilteredGroups AS (
    SELECT group_id
    FROM ConsecutiveGroups
    GROUP BY group_id
    HAVING COUNT(*) >= 3
)
SELECT DISTINCT C.id, C.visit_date, C.people
FROM ConsecutiveGroups C
JOIN FilteredGroups F
ON C.group_id = F.group_id
ORDER BY C.visit_date;

----Solution (mySQL)
--WITH RankedStadium AS (
--    SELECT *,
--           ROW_NUMBER() OVER (ORDER BY id) AS rn
--    FROM Stadium
--    WHERE people >= 100
--),
--ConsecutiveGroups AS (
--    SELECT id, visit_date, people, 
--           CAST(rn AS SIGNED) - CAST(id AS SIGNED) AS group_id
--    FROM RankedStadium
--),
--FilteredGroups AS (
--    SELECT group_id
--    FROM ConsecutiveGroups
--    GROUP BY group_id
--    HAVING COUNT(*) >= 3
--)
--SELECT DISTINCT C.id, C.visit_date, C.people
--FROM ConsecutiveGroups C
--JOIN FilteredGroups F
--ON C.group_id = F.group_id
--ORDER BY C.visit_date;

----Solution (Oracle)
--WITH RankedStadium AS (
--    SELECT id, visit_date, people,
--           ROW_NUMBER() OVER (ORDER BY id) AS rn
--    FROM Stadium
--    WHERE people >= 100
--),
--ConsecutiveGroups AS (
--    SELECT id, visit_date, people,
--           rn - id AS group_id
--    FROM RankedStadium
--),
--FilteredGroups AS (
--    SELECT group_id
--    FROM ConsecutiveGroups
--    GROUP BY group_id
--    HAVING COUNT(*) >= 3
--)
--SELECT id, TO_CHAR(visit_date, 'YYYY-MM-DD') AS visit_date, people
--FROM ConsecutiveGroups
--WHERE group_id IN (SELECT group_id FROM FilteredGroups)
--ORDER BY visit_date;


--Drop table
DROP TABLE Stadium