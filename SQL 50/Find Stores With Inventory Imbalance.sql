--Source (MySQL): https://leetcode.com/problems/find-stores-with-inventory-imbalance/solutions/7022428/simple-best-solution/
/*
	Table: stores

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| store_id    | int     |
	| store_name  | varchar |
	| location    | varchar |
	+-------------+---------+
	store_id is the unique identifier for this table.
	Each row contains information about a store and its location.
	Table: inventory

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| inventory_id| int     |
	| store_id    | int     |
	| product_name| varchar |
	| quantity    | int     |
	| price       | decimal |
	+-------------+---------+
	inventory_id is the unique identifier for this table.
	Each row represents the inventory of a specific product at a specific store.
	Write a solution to find stores that have inventory imbalance - stores where the most expensive product has lower stock than the cheapest product.

	For each store, identify the most expensive product (highest price) and its quantity
	For each store, identify the cheapest product (lowest price) and its quantity
	A store has inventory imbalance if the most expensive product's quantity is less than the cheapest product's quantity
	Calculate the imbalance ratio as (cheapest_quantity / most_expensive_quantity)
	Round the imbalance ratio to 2 decimal places
	Only include stores that have at least 3 different products
	Return the result table ordered by imbalance ratio in descending order, then by store name in ascending order.

	The result format is in the following example.

 

	Example:

	Input:

	stores table:

	+----------+----------------+-------------+
	| store_id | store_name     | location    |
	+----------+----------------+-------------+
	| 1        | Downtown Tech  | New York    |
	| 2        | Suburb Mall    | Chicago     |
	| 3        | City Center    | Los Angeles |
	| 4        | Corner Shop    | Miami       |
	| 5        | Plaza Store    | Seattle     |
	+----------+----------------+-------------+
	inventory table:

	+--------------+----------+--------------+----------+--------+
	| inventory_id | store_id | product_name | quantity | price  |
	+--------------+----------+--------------+----------+--------+
	| 1            | 1        | Laptop       | 5        | 999.99 |
	| 2            | 1        | Mouse        | 50       | 19.99  |
	| 3            | 1        | Keyboard     | 25       | 79.99  |
	| 4            | 1        | Monitor      | 15       | 299.99 |
	| 5            | 2        | Phone        | 3        | 699.99 |
	| 6            | 2        | Charger      | 100      | 25.99  |
	| 7            | 2        | Case         | 75       | 15.99  |
	| 8            | 2        | Headphones   | 20       | 149.99 |
	| 9            | 3        | Tablet       | 2        | 499.99 |
	| 10           | 3        | Stylus       | 80       | 29.99  |
	| 11           | 3        | Cover        | 60       | 39.99  |
	| 12           | 4        | Watch        | 10       | 299.99 |
	| 13           | 4        | Band         | 25       | 49.99  |
	| 14           | 5        | Camera       | 8        | 599.99 |
	| 15           | 5        | Lens         | 12       | 199.99 |
	+--------------+----------+--------------+----------+--------+
	Output:

	+----------+----------------+-------------+------------------+--------------------+------------------+
	| store_id | store_name     | location    | most_exp_product | cheapest_product   | imbalance_ratio  |
	+----------+----------------+-------------+------------------+--------------------+------------------+
	| 3        | City Center    | Los Angeles | Tablet           | Stylus             | 40.00            |
	| 1        | Downtown Tech  | New York    | Laptop           | Mouse              | 10.00            |
	| 2        | Suburb Mall    | Chicago     | Phone            | Case               | 25.00            |
	+----------+----------------+-------------+------------------+--------------------+------------------+
	Explanation:

	Downtown Tech (store_id = 1):
	Most expensive product: Laptop ($999.99) with quantity 5
	Cheapest product: Mouse ($19.99) with quantity 50
	Inventory imbalance: 5 < 50 (expensive product has lower stock)
	Imbalance ratio: 50 / 5 = 10.00
	Has 4 products (≥ 3), so qualifies
	Suburb Mall (store_id = 2):
	Most expensive product: Phone ($699.99) with quantity 3
	Cheapest product: Case ($15.99) with quantity 75
	Inventory imbalance: 3 < 75 (expensive product has lower stock)
	Imbalance ratio: 75 / 3 = 25.00
	Has 4 products (≥ 3), so qualifies
	City Center (store_id = 3):
	Most expensive product: Tablet ($499.99) with quantity 2
	Cheapest product: Stylus ($29.99) with quantity 80
	Inventory imbalance: 2 < 80 (expensive product has lower stock)
	Imbalance ratio: 80 / 2 = 40.00
	Has 3 products (≥ 3), so qualifies
	Stores not included:
	Corner Shop (store_id = 4): Only has 2 products (Watch, Band) - doesn't meet minimum 3 products requirement
	Plaza Store (store_id = 5): Only has 2 products (Camera, Lens) - doesn't meet minimum 3 products requirement
	The Results table is ordered by imbalance ratio in descending order, then by store name in ascending order
*/

--create tables
CREATE TABLE stores (store_id INT,store_name VARCHAR(255),location VARCHAR(255));
CREATE TABLE inventory (inventory_id INT,store_id INT,product_name VARCHAR(255),quantity INT,price DECIMAL(10, 2));

--insert sample data (store)
--insert into stores (store_id, store_name, location) values ('1', 'Downtown Tech', 'New York')
--insert into stores (store_id, store_name, location) values ('2', 'Suburb Mall', 'Chicago')
--insert into stores (store_id, store_name, location) values ('3', 'City Center', 'Los Angeles')
--insert into stores (store_id, store_name, location) values ('4', 'Corner Shop', 'Miami')
--insert into stores (store_id, store_name, location) values ('5', 'Plaza Store', 'Seattle')

insert into stores(store_id,store_name,location) values('1','CityMall','LasVegas')
insert into stores(store_id,store_name,location) values('2','NorthDepot','SanDiego')
insert into stores(store_id,store_name,location) values('3','MetroShop','Detroit')
insert into stores(store_id,store_name,location) values('4','SuburbPrime','LosAngeles')
insert into stores(store_id,store_name,location) values('5','DowntownCenter','SanAntonio')
insert into stores(store_id,store_name,location) values('6','WestMall','Seattle')
insert into stores(store_id,store_name,location) values('7','EastPrime','SanDiego')
insert into stores(store_id,store_name,location) values('8','BayHub','NewYork')
insert into stores(store_id,store_name,location) values('9','CentralPrime','Austin')
insert into stores(store_id,store_name,location) values('10','NorthStore','SanAntonio')
insert into stores(store_id,store_name,location) values('11','MainShop','Chicago')
insert into stores(store_id,store_name,location) values('12','ValleyShop','Jacksonville')
insert into stores(store_id,store_name,location) values('13','ParkHub','LosAngeles')
insert into stores(store_id,store_name,location) values('14','BayShop','FortWorth')
insert into stores(store_id,store_name,location) values('15','SuburbCorner','Nashville')
insert into stores(store_id,store_name,location) values('16','ParkOutlet','Portland')
insert into stores(store_id,store_name,location) values('17','SuburbPlaza','Detroit')
insert into stores(store_id,store_name,location) values('18','WestCorner','Chicago')

----insert sample data (inventory)
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('1', '1', 'Laptop', '5', '999.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('2', '1', 'Mouse', '50', '19.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('3', '1', 'Keyboard', '25', '79.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('4', '1', 'Monitor', '15', '299.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('5', '2', 'Phone', '3', '699.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('6', '2', 'Charger', '100', '25.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('7', '2', 'Case', '75', '15.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('8', '2', 'Headphones', '20', '149.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('9', '3', 'Tablet', '2', '499.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('10', '3', 'Stylus', '80', '29.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('11', '3', 'Cover', '60', '39.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('12', '4', 'Watch', '10', '299.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('13', '4', 'Band', '25', '49.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('14', '5', 'Camera', '8', '599.99')
--insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('15', '5', 'Lens', '12', '199.99');



insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('1','1','Cover','81','71.67')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('2','1','Lamp','20','191.39')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('3','1','Mouse','29','592.05')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('4','1','Tablet','7','1091.57')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('5','2','Clip','100','88.25')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('6','2','Folder','35','141.19')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('7','2','Weights','29','280.15')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('8','2','Notebook','19','331.16')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('9','2','Monitor','5','1652.52')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('10','3','Clip','146','51.88')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('11','3','Holder','16','56.2')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('12','3','Clock','18','77.51')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('13','3','Bag','3','361.17')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('14','4','Plant','148','33.11')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('15','4','Curtains','35','165.8')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('16','4','Ball','25','278.51')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('17','4','Camera','2','1514.21')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('18','5','Protector','119','77.44')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('19','5','Candle','39','144.31')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('20','5','Board','31','308.4')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('21','5','Racket','15','350.8')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('22','5','Calendar','10','383.36')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('23','6','Pillow','110','46.88')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('24','6','Shoes','32','68.79')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('25','6','Clip','20','94.96')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('26','6','Pen','23','127.33')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('27','6','Speaker','9','1641.25')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('28','7','Cover','27','42.9')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('29','7','Blanket','27','85.65')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('30','7','Keyboard','38','91.02')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('31','7','Frame','27','279.74')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('32','7','Organizer','40','450.81')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('33','8','Cover','16','68.55')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('34','8','Monitor','37','181.43')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('35','8','Mouse','48','188.17')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('36','9','Mirror','20','69.27')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('37','9','Phone','45','168.19')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('38','9','Gear','47','199.61')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('39','9','Rug','23','261.19')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('40','9','Mouse','55','740.88')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('41','10','Charger','27','47.1')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('42','10','Holder','23','47.62')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('43','10','Candle','43','94.39')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('44','11','Monitor','36','374.31')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('45','12','Adapter','15','90.73')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('46','12','Pillow','21','295.81')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('47','13','Folder','40','351.33')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('48','13','Candle','18','69.12')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('49','14','Helmet','25','43.16')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('50','15','Smartwatch','68','979.74')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('51','15','Case','11','96.27')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('52','15','Charger','87','61.53')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('53','16','Blanket','73','283.35')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('54','16','Clip','80','61.48')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('55','16','Mouse','73','1331.88')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('56','16','Bottle','27','375.19')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('57','17','Cover','86','42.6')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('58','17','Organizer','97','164.93')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('59','17','Laptop','73','943.66')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('60','17','Phone','65','1098.39')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('61','17','Lamp','9','467.3')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('62','18','Pen','70','87.3')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('63','18','Board','84','492.09')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('64','18','Ball','71','273.79')
insert into inventory (inventory_id, store_id, product_name, quantity, price) values ('65','18','Chair','18','470.08');

--Solution (MySQL, MSSQL, Oracle, PgSQL)

WITH exp_product AS(
	SELECT e.store_id, i.product_name AS most_exp_product,e.price, i.quantity FROM inventory i
	INNER JOIN (SELECT store_id,MAX(price) price FROM inventory GROUP BY store_id HAVING COUNT(DISTINCT product_name)>2) e 
	ON e.store_id=i.store_id AND e.price=i.price 
)
, cheap_product AS (
	SELECT c.store_id, i.product_name AS cheapest_product,c.price, i.quantity FROM inventory i
	INNER JOIN (SELECT store_id,MIN(price) price FROM inventory GROUP BY store_id  HAVING COUNT(DISTINCT product_name)>2) c 
	ON c.store_id=i.store_id AND c.price=i.price	
)
, final AS(
	SELECT e.store_id,s.store_name,s.location,e.most_exp_product,c.cheapest_product
	,ROUND(c.quantity*1.00/e.quantity*1.00,2) AS imbalance_ratio
	FROM exp_product e
	INNER JOIN cheap_product c ON e.store_id=c.store_id
	INNER JOIN stores s ON e.store_id=s.store_id
	WHERE e.quantity<c.quantity
)
SELECT * FROM final ORDER BY imbalance_ratio DESC, store_name


DROP TABLE stores
DROP TABLE inventory