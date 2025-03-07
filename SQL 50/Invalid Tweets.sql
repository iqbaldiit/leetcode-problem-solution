--Source(MsSQL): https://leetcode.com/problems/invalid-tweets/solutions/6509659/best-simple-solution-by-iqbaldiit-vfm7/ 
--Source(PgSQL): https://leetcode.com/problems/invalid-tweets/solutions/6509657/best-simple-solution-by-iqbaldiit-o9ag/
--Source(MySQL): https://leetcode.com/problems/invalid-tweets/solutions/6509645/simple-best-solution-by-iqbaldiit-0c14/
/*
	Table: Tweets
	+----------------+---------+
	| Column Name    | Type    |
	+----------------+---------+
	| tweet_id       | int     |
	| content        | varchar |
	+----------------+---------+
	tweet_id is the primary key (column with unique values) for this table.
	content consists of characters on an American Keyboard, and no other special characters.
	This table contains all the tweets in a social media app.
 
	Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
	Return the result table in any order.

	The result format is in the following example.

	Example 1:

	Input: 
	Tweets table:
	+----------+-----------------------------------+
	| tweet_id | content                           |
	+----------+-----------------------------------+
	| 1        | Let us Code                       |
	| 2        | More than fifteen chars are here! |
	+----------+-----------------------------------+
	Output: 
	+----------+
	| tweet_id |
	+----------+
	| 2        |
	+----------+
	Explanation: 
	Tweet 1 has length = 11. It is a valid tweet.
	Tweet 2 has length = 33. It is an invalid tweet.
*/

--Create table (MSSQL)
CREATE TABLE Tweets (tweet_id INT, content VARCHAR(MAX));

----Create table (PGSQL,MySQL)
--CREATE TABLE Tweets (tweet_id INT, content VARCHAR);

--insert data to table
INSERT INTO Tweets VALUES 
(1,'Let us Code')
,(2,'More than fifteen chars are here!');

/*Solution (MSSQL) */
SELECT tweet_id FROM Tweets WHERE LEN(content)>15;

--/*Solution (PostGreSQL, MySQL) */
--SELECT tweet_id FROM Tweets WHERE LENGTH(content)>15;

DROP TABLE Tweets;
