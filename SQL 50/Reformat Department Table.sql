--Source: https://leetcode.com/problems/reformat-department-table/solutions/6702617/simple-best-solution-by-iqbaldiit-lgg4/

/*
	Table: Department

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| id          | int     |
	| revenue     | int     |
	| month       | varchar |
	+-------------+---------+
	In SQL,(id, month) is the primary key of this table.
	The table has information about the revenue of each department per month.
	The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 

	Reformat the table such that there is a department id column and a revenue column for each month.

	Return the result table in any order.

	The result format is in the following example.

 

	Example 1:

	Input: 
	Department table:
	+------+---------+-------+
	| id   | revenue | month |
	+------+---------+-------+
	| 1    | 8000    | Jan   |
	| 2    | 9000    | Jan   |
	| 3    | 10000   | Feb   |
	| 1    | 7000    | Feb   |
	| 1    | 6000    | Mar   |
	+------+---------+-------+
	Output: 
	+------+-------------+-------------+-------------+-----+-------------+
	| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
	+------+-------------+-------------+-------------+-----+-------------+
	| 1    | 8000        | 7000        | 6000        | ... | null        |
	| 2    | 9000        | null        | null        | ... | null        |
	| 3    | null        | 10000       | null        | ... | null        |
	+------+-------------+-------------+-------------+-----+-------------+
	Explanation: The revenue from Apr to Dec is null.
	Note that the result table has 13 columns (1 for the department id + 12 for the months).

*/

-- Create the Department table
CREATE TABLE Department (id INT,revenue INT,month VARCHAR(3));

-- Insert data into the Department table
INSERT INTO Department (id, revenue, month) VALUES
(1, 8000, 'Jan'),(2, 9000, 'Jan'),(3, 10000, 'Feb'),(1, 7000, 'Feb'),(1, 6000, 'Mar');

-- Solution (MSSQL,MySQL, PGSQL, Oracle)
SELECT 
    id,
    MAX(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
    MAX(CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
    MAX(CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
    MAX(CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
    MAX(CASE WHEN month = 'May' THEN revenue ELSE NULL END) AS May_Revenue,
    MAX(CASE WHEN month = 'Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
    MAX(CASE WHEN month = 'Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
    MAX(CASE WHEN month = 'Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
    MAX(CASE WHEN month = 'Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
    MAX(CASE WHEN month = 'Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
    MAX(CASE WHEN month = 'Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
    MAX(CASE WHEN month = 'Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY id;


-- drop table 
DROP TABLE Department
