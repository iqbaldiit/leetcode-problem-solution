/*

Source: https://leetcode.com/problems/delete-duplicate-emails/solutions/6301947/easy-best-solution/

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

For Pandas users, please note that you are supposed to modify Person in place.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.

The result format is in the following example.

 

Example 1:

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.
*/

--Create Table
CREATE TABLE Person (id int, email varchar(50));

--Insert Data
INSERT INTO Person VALUES (1,'john@example.com');
INSERT INTO Person VALUES (2,'bob@example.com');
INSERT INTO Person VALUES (3,'john@example.com');

--Solution 1 (MySQL, MSSQL, PostgreSQL)
DELETE p1 FROM Person p1, Person p2 
WHERE p1.email = p2.email AND p1.id > p2.id;

--Solution 2 Using CTE (MSSQL, PostgreSQL)
--WITH CTE_Duplicates AS (
--    SELECT
--        id,
--        email,
--        ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS RowNum
--    FROM
--        Person
--)
--DELETE FROM Person
--WHERE id IN (
--    SELECT id
--    FROM CTE_Duplicates
--    WHERE RowNum > 1
--);
--SELECT * FROM Person;


--SELECT * FROM Person;

--Drop table
DROP TABLE Person