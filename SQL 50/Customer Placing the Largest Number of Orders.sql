--Source (MSSQL):https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/solutions/6615831/simple-best-solution-by-iqbaldiit-k3z4/
--Source (MySQL):https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/solutions/6615819/simple-best-solution-by-iqbaldiit-472u/
--Source (PGSQL):https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/solutions/6615829/simple-best-solution-by-iqbaldiit-dy13/
/*
	Table: Orders

	+-----------------+----------+
	| Column Name     | Type     |
	+-----------------+----------+
	| order_number    | int      |
	| customer_number | int      |
	+-----------------+----------+
	order_number is the primary key (column with unique values) for this table.
	This table contains information about the order ID and the customer ID. 

	Write a solution to find the customer_number for the customer who has 
	placed the largest number of orders.
	The test cases are generated so that exactly one customer will have placed 
	more orders than any other customer.

	The result format is in the following example.
	
	Example 1:

	Input: 
	Orders table:
	+--------------+-----------------+
	| order_number | customer_number |
	+--------------+-----------------+
	| 1            | 1               |
	| 2            | 2               |
	| 3            | 3               |
	| 4            | 3               |
	+--------------+-----------------+
	Output: 
	+-----------------+
	| customer_number |
	+-----------------+
	| 3               |
	+-----------------+
	Explanation: 
	The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
	So the result is customer_number 3.
*/

--Create table 
CREATE TABLE Orders (order_number INT, customer_number INT);

--insert table
INSERT INTO Orders VALUES (1,1);
INSERT INTO Orders VALUES (2,2);
INSERT INTO Orders VALUES (3,3);
INSERT INTO Orders VALUES (4,3);

--solution (MSSQL, MySQL, PGSQL)
/* Write your T-SQL query statement below */
SELECT tab2.customer_number FROM 
(SELECT tab.customer_number, DENSE_RANK() OVER (ORDER BY order_number DESC) rk FROM 
	(SELECT customer_number, COUNT(order_number) AS order_number 
		FROM Orders GROUP BY customer_number
	)tab
)tab2 WHERE tab2.rk=1

--DROP table
DROP TABLE Orders