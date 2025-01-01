/*
Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 

Find the names of the customer that are not referred by the customer with id = 2.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
*/

/* Write your T-SQL query statement below */
CREATE TABLE Customer (id INT, [name] VARCHAR(50), referee_id INT)
INSERT INTO Customer VALUES (1 ,'Will', null)
INSERT INTO Customer VALUES (2 ,'Jane', null)
INSERT INTO Customer VALUES (3 ,'Alex', 2   )
INSERT INTO Customer VALUES (4 ,'Bill', null)
INSERT INTO Customer VALUES (5 ,'Zack', 1  )
INSERT INTO Customer VALUES (6 ,'Mark', 2   )

SELECT [name] FROM Customer WHERE ISNULL(referee_id,0)<>2

DROP TABLE Customer