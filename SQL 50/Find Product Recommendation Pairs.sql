--Source(MySQL):https://leetcode.com/problems/find-product-recommendation-pairs/solutions/6933925/simple-best-solution/
--Source(MySQL, MSSQL, Oracle, PGSQL):https://leetcode.com/problems/find-product-recommendation-pairs/solutions/6937381/simple-best-solution-by-iqbaldiit-5wur/
/*
	Table: ProductPurchases

	+-------------+------+
	| Column Name | Type | 
	+-------------+------+
	| user_id     | int  |
	| product_id  | int  |
	| quantity    | int  |
	+-------------+------+
	(user_id, product_id) is the unique identifier for this table. 
	Each row represents a purchase of a product by a user in a specific quantity.
	Table: ProductInfo

	+-------------+---------+
	| Column Name | Type    | 
	+-------------+---------+
	| product_id  | int     |
	| category    | varchar |
	| price       | decimal |
	+-------------+---------+

	product_id is the unique identifier for this table.
	Each row assigns a category and price to a product.
	Amazon wants to understand shoPPng patterns across product categories. Write a solution to:

	Find all category pairs (where category1 < category2)
	For each category pair, determine the number of unique customers who purchased products from both categories
	A category pair is considered reportable if at least 3 different customers have purchased products from both categories.

	Return the result table of reportable category pairs ordered by customer_count in descending order, and in case of a tie, by category1 in ascending order lexicographically, and then by category2 in ascending order.

	The result format is in the following example.

	Example:

	Input:

	ProductPurchases table:

	+---------+------------+----------+
	| user_id | product_id | quantity |
	+---------+------------+----------+
	| 1       | 101        | 2        |
	| 1       | 102        | 1        |
	| 1       | 201        | 3        |
	| 1       | 301        | 1        |
	| 2       | 101        | 1        |
	| 2       | 102        | 2        |
	| 2       | 103        | 1        |
	| 2       | 201        | 5        |
	| 3       | 101        | 2        |
	| 3       | 103        | 1        |
	| 3       | 301        | 4        |
	| 3       | 401        | 2        |
	| 4       | 101        | 1        |
	| 4       | 201        | 3        |
	| 4       | 301        | 1        |
	| 4       | 401        | 2        |
	| 5       | 102        | 2        |
	| 5       | 103        | 1        |
	| 5       | 201        | 2        |
	| 5       | 202        | 3        |
	+---------+------------+----------+
	ProductInfo table:

	+------------+-------------+-------+
	| product_id | category    | price |
	+------------+-------------+-------+
	| 101        | Electronics | 100   |
	| 102        | Books       | 20    |
	| 103        | Books       | 35    |
	| 201        | Clothing    | 45    |
	| 202        | Clothing    | 60    |
	| 301        | Sports      | 75    |
	| 401        | Kitchen     | 50    |
	+------------+-------------+-------+
	Output:

	+-------------+-------------+----------------+
	| category1   | category2   | customer_count |
	+-------------+-------------+----------------+
	| Books       | Clothing    | 3              |
	| Books       | Electronics | 3              |
	| Clothing    | Electronics | 3              |
	| Electronics | Sports      | 3              |
	+-------------+-------------+----------------+
	Explanation:

	Books-Clothing:
	User 1 purchased products from Books (102) and Clothing (201)
	User 2 purchased products from Books (102, 103) and Clothing (201)
	User 5 purchased products from Books (102, 103) and Clothing (201, 202)
	Total: 3 customers purchased from both categories
	Books-Electronics:
	User 1 purchased products from Books (102) and Electronics (101)
	User 2 purchased products from Books (102, 103) and Electronics (101)
	User 3 purchased products from Books (103) and Electronics (101)
	Total: 3 customers purchased from both categories
	Clothing-Electronics:
	User 1 purchased products from Clothing (201) and Electronics (101)
	User 2 purchased products from Clothing (201) and Electronics (101)
	User 4 purchased products from Clothing (201) and Electronics (101)
	Total: 3 customers purchased from both categories
	Electronics-Sports:
	User 1 purchased products from Electronics (101) and Sports (301)
	User 3 purchased products from Electronics (101) and Sports (301)
	User 4 purchased products from Electronics (101) and Sports (301)
	Total: 3 customers purchased from both categories
	Other category pairs like Clothing-Sports (only 2 customers: Users 1 and 4) and Books-Kitchen (only 1 customer: User 3) have fewer than 3 shared customers and are not included in the result.
	The result is ordered by customer_count in descending order. Since all pairs have the same customer_count of 3, they are ordered by category1 (then category2) in ascending order.
*/

--Create Tables
CREATE TABLE ProductPurchases (user_id INT,product_id INT,quantity INT);
CREATE TABLE  ProductInfo (product_id INT,category VARCHAR(100),price DECIMAL(10, 2));

--insert product purchase tables
insert into ProductPurchases (user_id, product_id, quantity) values ('1', '101', '2')
insert into ProductPurchases (user_id, product_id, quantity) values ('1', '102', '1')
insert into ProductPurchases (user_id, product_id, quantity) values ('1', '103', '3')
insert into ProductPurchases (user_id, product_id, quantity) values ('2', '101', '1')
insert into ProductPurchases (user_id, product_id, quantity) values ('2', '102', '5')
insert into ProductPurchases (user_id, product_id, quantity) values ('2', '104', '1')
insert into ProductPurchases (user_id, product_id, quantity) values ('3', '101', '2')
insert into ProductPurchases (user_id, product_id, quantity) values ('3', '103', '1')
insert into ProductPurchases (user_id, product_id, quantity) values ('3', '105', '4')
insert into ProductPurchases (user_id, product_id, quantity) values ('4', '101', '1')
insert into ProductPurchases (user_id, product_id, quantity) values ('4', '102', '1')
insert into ProductPurchases (user_id, product_id, quantity) values ('4', '103', '2')
insert into ProductPurchases (user_id, product_id, quantity) values ('4', '104', '3')
insert into ProductPurchases (user_id, product_id, quantity) values ('5', '102', '2')
insert into ProductPurchases (user_id, product_id, quantity) values ('5', '104', '1')

--insert product info table
insert into ProductInfo (product_id, category, price) values ('101', 'Electronics', '100')
insert into ProductInfo (product_id, category, price) values ('102', 'Books', '20')
insert into ProductInfo (product_id, category, price) values ('103', 'Clothing', '35')
insert into ProductInfo (product_id, category, price) values ('104', 'Kitchen', '50')
insert into ProductInfo (product_id, category, price) values ('105', 'Sports', '75');

--Solution (MySQL, MSSQL, Oracle, PgSQL) 

WITH UserProducts AS (
    SELECT DISTINCT PP.user_id,PP.product_id, P.category FROM ProductPurchases PP
    INNER JOIN ProductInfo P ON PP.product_id = P.product_id
),ProductPairs AS(
	SELECT	UP1.product_id AS product1_id
		,UP2.product_id AS product2_id
		,UP1.category AS product1_category
		,UP2.category AS product2_category
		,COUNT(UP1.user_id) customer_count 
	FROM UserProducts UP1
	INNER JOIN UserProducts UP2 ON UP1.user_id=UP2.user_id AND UP1.product_id<UP2.product_id
	GROUP BY UP1.product_id,UP2.product_id,UP1.category,UP2.category
	HAVING COUNT(UP1.user_id)>=3
)
SELECT * FROM ProductPairs ORDER BY customer_count DESC,product1_id ASC,product2_id ASC;

-- drop table
DROP TABLE ProductPurchases
DROP TABLE ProductInfo

