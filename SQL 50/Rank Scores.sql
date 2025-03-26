--Source (MSSQL):https://leetcode.com/problems/rank-scores/solutions/6582648/simple-best-solution-by-iqbaldiit-5sna/
--Source (PGSQL):https://leetcode.com/problems/rank-scores/solutions/6582659/simple-best-solution-by-iqbaldiit-munt/
--Source (MySQL):https://leetcode.com/problems/rank-scores/solutions/6582682/simple-best-solution-by-iqbaldiit-jikr/
/*
	Table: Scores

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| id          | int     |
	| score       | decimal |
	+-------------+---------+
	id is the primary key (column with unique values) for this table.
	Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
 

	Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

	The scores should be ranked from the highest to the lowest.
	If there is a tie between two scores, both should have the same ranking.
	After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
	Return the result table ordered by score in descending order.

	The result format is in the following example.

 

	Example 1:

	Input: 
	Scores table:
	+----+-------+
	| id | score |
	+----+-------+
	| 1  | 3.50  |
	| 2  | 3.65  |
	| 3  | 4.00  |
	| 4  | 3.85  |
	| 5  | 4.00  |
	| 6  | 3.65  |
	+----+-------+
	Output: 
	+-------+------+
	| score | rank |
	+-------+------+
	| 4.00  | 1    |
	| 4.00  | 1    |
	| 3.85  | 2    |
	| 3.65  | 3    |
	| 3.65  | 3    |
	| 3.50  | 4    |
	+-------+------+
*/
--Create tabel
CREATE TABLE Scores (id INT, score DECIMAL(18,2));

--Insert Data
INSERT INTO Scores VALUES(1,3.50);
INSERT INTO Scores VALUES(2,3.65);
INSERT INTO Scores VALUES(3,4.00);
INSERT INTO Scores VALUES(4,3.85);
INSERT INTO Scores VALUES(5,4.00);
INSERT INTO Scores VALUES(6,3.65);

--Solution (MSSQL)
SELECT score,DENSE_RANK() OVER (ORDER BY score DESC) AS [rank] FROM Scores;

----Solution (PGSQL)
--SELECT score,DENSE_RANK() OVER (ORDER BY score DESC) AS rank FROM Scores;

----Solution (MySQL)
--SELECT score,DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank' FROM Scores;

--drop table
DROP TABLE Scores



