--Source (MSSQL): https://leetcode.com/problems/daily-leads-and-partners/solutions/6628151/simple-best-solution-by-iqbaldiit-wu47/ 
--Source (mySQL): https://leetcode.com/problems/daily-leads-and-partners/solutions/6628141/simple-best-solution-by-iqbaldiit-6uv9/
--Source (pgSQL): https://leetcode.com/problems/daily-leads-and-partners/solutions/6628149/simple-best-solution-by-iqbaldiit-j4wp/
--Source (oracle): https://leetcode.com/problems/daily-leads-and-partners/solutions/6628250/simple-best-solution-by-iqbaldiit-hyh9/
/*
	Table: DailySales

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| date_id     | date    |
	| make_name   | varchar |
	| lead_id     | int     |
	| partner_id  | int     |
	+-------------+---------+
	There is no primary key (column with unique values) for this table. It may contain duplicates.
	This table contains the date and the name of the product sold and the IDs of the lead and partner it was sold to.
	The name consists of only lowercase English letters.
 

	For each date_id and make_name, find the number of distinct lead_id's and distinct partner_id's.

	Return the result table in any order.

	The result format is in the following example.
	

	Example 1:

	Input: 
	DailySales table:
	+-----------+-----------+---------+------------+
	| date_id   | make_name | lead_id | partner_id |
	+-----------+-----------+---------+------------+
	| 2020-12-8 | toyota    | 0       | 1          |
	| 2020-12-8 | toyota    | 1       | 0          |
	| 2020-12-8 | toyota    | 1       | 2          |
	| 2020-12-7 | toyota    | 0       | 2          |
	| 2020-12-7 | toyota    | 0       | 1          |
	| 2020-12-8 | honda     | 1       | 2          |
	| 2020-12-8 | honda     | 2       | 1          |
	| 2020-12-7 | honda     | 0       | 1          |
	| 2020-12-7 | honda     | 1       | 2          |
	| 2020-12-7 | honda     | 2       | 1          |
	+-----------+-----------+---------+------------+
	Output: 
	+-----------+-----------+--------------+-----------------+
	| date_id   | make_name | unique_leads | unique_partners |
	+-----------+-----------+--------------+-----------------+
	| 2020-12-8 | toyota    | 2            | 3               |
	| 2020-12-7 | toyota    | 1            | 2               |
	| 2020-12-8 | honda     | 2            | 2               |
	| 2020-12-7 | honda     | 3            | 2               |
	+-----------+-----------+--------------+-----------------+
	Explanation: 
	For 2020-12-8, toyota gets leads = [0, 1] and partners = [0, 1, 2] while honda gets leads = [1, 2] and partners = [1, 2].
	For 2020-12-7, toyota gets leads = [0] and partners = [1, 2] while honda gets leads = [0, 1, 2] and partners = [1, 2].
*/
--create table
CREATE TABLE DailySales (date_id   date,make_name varchar(100),lead_id   int,partner_id int);

--insert into table
INSERT INTO DailySales VALUES('2020-12-8','toyota',0,1);
INSERT INTO DailySales VALUES('2020-12-8','toyota',1,0);
INSERT INTO DailySales VALUES('2020-12-8','toyota',1,2);
INSERT INTO DailySales VALUES('2020-12-7','toyota',0,2);
INSERT INTO DailySales VALUES('2020-12-7','toyota',0,1);
INSERT INTO DailySales VALUES('2020-12-8','honda',1,2);
INSERT INTO DailySales VALUES('2020-12-8','honda',2,1);
INSERT INTO DailySales VALUES('2020-12-7','honda',0,1);
INSERT INTO DailySales VALUES('2020-12-7','honda',1,2);
INSERT INTO DailySales VALUES('2020-12-7','honda',2,1);

--solution (MSSQL,MySQL,PGSQL)
SELECT date_id,make_name
,COUNT(DISTINCT lead_id) unique_leads 
,COUNT(DISTINCT partner_id) unique_partners
FROM DailySales GROUP BY date_id,make_name;

----Solution (oracle)
--SELECT TO_CHAR(date_id, 'YYYY-MM-DD') AS "date_id",make_name AS "make_name"
--,COUNT(DISTINCT lead_id) "unique_leads" 
--,COUNT(DISTINCT partner_id) "unique_partners"
--FROM DailySales GROUP BY date_id,make_name;


--drop table
DROP TABLE DailySales

