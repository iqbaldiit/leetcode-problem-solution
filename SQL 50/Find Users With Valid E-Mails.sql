--Source (PostgreSQL): https://leetcode.com/problems/find-users-with-valid-e-mails/solutions/6534967/simple-best-solution-by-iqbaldiit-0phw/ 
--Source (MySQL) : https://leetcode.com/problems/find-users-with-valid-e-mails/solutions/6534977/simple-best-solution-by-iqbaldiit-liq9/
--Source (MSSQL) : https://leetcode.com/problems/find-users-with-valid-e-mails/solutions/6534983/simple-best-solution-by-iqbaldiit-xwau/
/*
Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains information of the users signed up in a website. Some e-mails are invalid.
 

Write a solution to find the users who have valid emails.

A valid e-mail has a prefix name and a domain where:

The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
The domain is '@leetcode.com'.
Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Users table:
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 2       | Jonathan  | jonathanisgreat         |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
| 5       | Marwan    | quarz#2020@leetcode.com |
| 6       | David     | david69@gmail.com       |
| 7       | Shapiro   | .shapo@leetcode.com     |
+---------+-----------+-------------------------+
Output: 
+---------+-----------+-------------------------+
| user_id | name      | mail                    |
+---------+-----------+-------------------------+
| 1       | Winston   | winston@leetcode.com    |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
+---------+-----------+-------------------------+
Explanation: 
The mail of user 2 does not have a domain.
The mail of user 5 has the # sign which is not allowed.
The mail of user 6 does not have the leetcode domain.
The mail of user 7 starts with a period.
*/


--Create table
CREATE TABLE users (user_id int ,name varchar(100),mail varchar(100));
--insert data to table
INSERT INTO users VALUES(1,'Winston','winston@leetcode.com');
INSERT INTO users VALUES(2,'Jonathan','jonathanisgreat');
INSERT INTO users VALUES(3,'Annabelle','bella-@leetcode.com');
INSERT INTO users VALUES(4,'Sally','sally.come@leetcode.com');
INSERT INTO users VALUES(5,'Marwan','quarz#2020@leetcode.com');
INSERT INTO users VALUES(6,'David','david69@gmail.com');
INSERT INTO users VALUES(7,'Shapiro','.shapo@leetcode.com');

--Raw Data
SELECT * FROM users;

/*Solution (MSSQL) */

SELECT * FROM users 
WHERE mail LIKE '[a-zA-Z]%@leetcode.com' 
AND mail NOT LIKE '%[^a-zA-Z0-9_.-]%@leetcode.com'

--Approach (2 MSSQL)
;WITH CT AS (
SELECT *
,IIF(mail LIKE '[a-zA-Z]%@leetcode.com' AND
       mail NOT LIKE '%[^a-zA-Z0-9_.-]%@leetcode.com',1,0) AS isValid
FROM Users)
SELECT user_id,name,mail FROM CT WHERE isValid=1

--/*Solution (PostGreSQL) */
--SELECT * FROM users 
--WHERE mail LIKE '%@leetcode.com'
--AND mail ~ '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\.com$'

--/*Solution (MySQL) */
--SELECT * FROM Users
--WHERE mail LIKE '%@leetcode.com'
--AND mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com$';

DROP TABLE users;