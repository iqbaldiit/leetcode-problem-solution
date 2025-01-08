/*
Table: Customers

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID and name of a customer.
 

Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
customerId is a foreign key (reference columns) of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
 

Write a solution to find all customers who never order anything.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output: 
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
*/

--Create Table (MSSQL)
CREATE TABLE Customers(id INT, name VARCHAR(50))
CREATE TABLE Orders (id INT,customerId INT)

--Insert Data
INSERT INTO Customers VALUES(1,'Joe')
INSERT INTO Customers VALUES(2,'Henry')
INSERT INTO Customers VALUES(3,'Sam')
INSERT INTO Customers VALUES(4,'Max')

INSERT INTO Orders VALUES(1,3)
INSERT INTO Orders VALUES(2,1)


--Solution (MSSQL,PostGresSQL,MySQL)
SELECT C.name AS Customers  FROM Customers C  WHERE C.id NOT IN (
SELECT O.customerId FROM Orders O)
--Drop Table
DROP TABLE Customers
DROP TABLE Orders