--Source (MySQL): https://leetcode.com/problems/find-covid-recovery-patients/solutions/6875306/simple-best-solution-by-iqbaldiit-bo6l/
/*
	Table: patients

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| patient_id  | int     |
	| patient_name| varchar |
	| age         | int     |
	+-------------+---------+
	patient_id is the unique identifier for this table.
	Each row contains information about a patient.
	Table: covid_tests

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| test_id     | int     |
	| patient_id  | int     |
	| test_date   | date    |
	| result      | varchar |
	+-------------+---------+
	test_id is the unique identifier for this table.
	Each row represents a COVID test result. The result can be Positive, Negative, or Inconclusive.
	Write a solution to find patients who have recovered from COVID - patients who tested positive but later tested negative.

	A patient is considered recovered if they have at least one Positive test followed by at least one Negative test on a later date
	Calculate the recovery time in days as the difference between the first positive test and the first negative test after that positive test
	Only include patients who have both positive and negative test results
	Return the result table ordered by recovery_time in ascending order, then by patient_name in ascending order.

	The result format is in the following example.

 

	Example:

	Input:

	patients table:

	+------------+--------------+-----+
	| patient_id | patient_name | age |
	+------------+--------------+-----+
	| 1          | Alice Smith  | 28  |
	| 2          | Bob Johnson  | 35  |
	| 3          | Carol Davis  | 42  |
	| 4          | David Wilson | 31  |
	| 5          | Emma Brown   | 29  |
	+------------+--------------+-----+
	covid_tests table:

	+---------+------------+------------+--------------+
	| test_id | patient_id | test_date  | result       |
	+---------+------------+------------+--------------+
	| 1       | 1          | 2023-01-15 | Positive     |
	| 2       | 1          | 2023-01-25 | Negative     |
	| 3       | 2          | 2023-02-01 | Positive     |
	| 4       | 2          | 2023-02-05 | Inconclusive |
	| 5       | 2          | 2023-02-12 | Negative     |
	| 6       | 3          | 2023-01-20 | Negative     |
	| 7       | 3          | 2023-02-10 | Positive     |
	| 8       | 3          | 2023-02-20 | Negative     |
	| 9       | 4          | 2023-01-10 | Positive     |
	| 10      | 4          | 2023-01-18 | Positive     |
	| 11      | 5          | 2023-02-15 | Negative     |
	| 12      | 5          | 2023-02-20 | Negative     |
	+---------+------------+------------+--------------+
	Output:

	+------------+--------------+-----+---------------+
	| patient_id | patient_name | age | recovery_time |
	+------------+--------------+-----+---------------+
	| 1          | Alice Smith  | 28  | 10            |
	| 3          | Carol Davis  | 42  | 10            |
	| 2          | Bob Johnson  | 35  | 11            |
	+------------+--------------+-----+---------------+
	Explanation:

	Alice Smith (patient_id = 1):
	First positive test: 2023-01-15
	First negative test after positive: 2023-01-25
	Recovery time: 25 - 15 = 10 days
	Bob Johnson (patient_id = 2):
	First positive test: 2023-02-01
	Inconclusive test on 2023-02-05 (ignored for recovery calculation)
	First negative test after positive: 2023-02-12
	Recovery time: 12 - 1 = 11 days
	Carol Davis (patient_id = 3):
	Had negative test on 2023-01-20 (before positive test)
	First positive test: 2023-02-10
	First negative test after positive: 2023-02-20
	Recovery time: 20 - 10 = 10 days
	Patients not included:
	David Wilson (patient_id = 4): Only has positive tests, no negative test after positive
	Emma Brown (patient_id = 5): Only has negative tests, never tested positive
	Output table is ordered by recovery_time in ascending order, and then by patient_name in ascending order.
*/

CREATE TABLE patients (patient_id INT,patient_name VARCHAR(255),age INT);
CREATE TABLE covid_tests (test_id INT,patient_id INT,test_date DATE,result VARCHAR(50));

--insert patient table
--insert into patients (patient_id, patient_name, age) values ('1', 'Alice Smith', '28')
--insert into patients (patient_id, patient_name, age) values ('2', 'Bob Johnson', '35')
--insert into patients (patient_id, patient_name, age) values ('3', 'Carol Davis', '42')
--insert into patients (patient_id, patient_name, age) values ('4', 'David Wilson', '31')
--insert into patients (patient_id, patient_name, age) values ('5', 'Emma Brown', '29')

INSERT INTO patients (patient_id, patient_name, age) VALUES
(1, 'Henry Johnson', 65),(2, 'Ruby Garcia', 32),(3, 'Ivy Moore', 61),(4, 'Frank Wright', 20),
(5, 'Bob Wilson', 31),(6, 'Olivia Johnson', 53),(7, 'Mia King', 32),(8, 'Claire Robinson', 69),
(9, 'Alice Jackson', 62),(10, 'Brian Lee', 35),(11, 'Jack Martin', 79),(12, 'Victor Moore', 23),
(13, 'Yolanda Moore', 40),(14, 'Wendy Martinez', 69),(15, 'Carol Hill', 52),(16, 'Henry Allen', 23),
(17, 'Sam Hall', 54),(18, 'Mia Miller', 20);

----insert covid_test table
--insert into covid_tests (test_id, patient_id, test_date, result) values ('1', '1', '2023-01-15', 'Positive')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('2', '1', '2023-01-25', 'Negative')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('3', '2', '2023-02-01', 'Positive')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('4', '2', '2023-02-05', 'Inconclusive')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('5', '2', '2023-02-12', 'Negative')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('6', '3', '2023-01-20', 'Negative')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('7', '3', '2023-02-10', 'Positive')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('8', '3', '2023-02-20', 'Negative')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('9', '4', '2023-01-10', 'Positive')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('10', '4', '2023-01-18', 'Positive')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('11', '5', '2023-02-15', 'Negative')
--insert into covid_tests (test_id, patient_id, test_date, result) values ('12', '5', '2023-02-20', 'Negative');

INSERT INTO covid_tests (test_id, patient_id, test_date, result) VALUES
(1, 1, '2023-02-24', 'Negative'),(2, 1, '2023-03-11', 'Positive'),(3, 1, '2023-04-03', 'Negative'),(4, 1, '2023-05-28', 'Negative'),
(5, 2, '2023-02-05', 'Negative'),(6, 2, '2023-03-13', 'Negative'),(7, 2, '2023-04-12', 'Negative'),(8, 2, '2023-05-07', 'Positive'),
(9, 2, '2023-06-21', 'Negative'),(10, 3, '2023-02-14', 'Negative'),(11, 3, '2023-03-14', 'Inconclusive'),(12, 3, '2023-04-09', 'Positive'),
(13, 3, '2023-05-30', 'Negative'),(14, 4, '2023-02-26', 'Positive'),(15, 4, '2023-03-03', 'Negative'),(16, 4, '2023-04-26', 'Negative'),
(17, 4, '2023-05-11', 'Inconclusive'),(18, 5, '2023-02-12', 'Negative'),(19, 5, '2023-03-30', 'Inconclusive'),(20, 5, '2023-04-30', 'Positive'),
(21, 5, '2023-05-21', 'Inconclusive'),(22, 5, '2023-06-14', 'Negative'),(23, 5, '2023-07-04', 'Positive'),(24, 6, '2023-02-16', 'Negative'),
(25, 6, '2023-03-17', 'Positive'),(26, 6, '2023-04-03', 'Negative'),(27, 6, '2023-05-25', 'Inconclusive'),(28, 7, '2023-03-04', 'Inconclusive'),
(29, 7, '2023-08-14', 'Positive'),(30, 7, '2023-08-16', 'Positive'),(31, 7, '2023-09-27', 'Inconclusive'),(32, 8, '2023-03-29', 'Positive'),
(33, 8, '2023-06-30', 'Inconclusive'),(34, 8, '2023-09-10', 'Positive'),(35, 9, '2023-05-02', 'Positive'),(36, 9, '2023-10-14', 'Inconclusive'),
(37, 9, '2023-10-17', 'Positive'),(38, 10, '2023-08-10', 'Negative'),(39, 11, '2023-01-31', 'Negative'),(40, 11, '2023-07-15', 'Negative'),
(41, 11, '2023-10-08', 'Inconclusive'),(42, 12, '2023-03-01', 'Negative'),(43, 12, '2023-06-02', 'Negative'),(44, 13, '2023-03-07', 'Positive'),
(45, 13, '2023-10-06', 'Positive'),(46, 14, '2023-04-06', 'Inconclusive'),(47, 14, '2023-04-25', 'Inconclusive'),(48, 14, '2023-10-01', 'Inconclusive'),
(49, 15, '2023-05-13', 'Inconclusive'),(50, 15, '2023-05-19', 'Inconclusive'),(51, 15, '2023-07-09', 'Inconclusive'),(52, 15, '2023-08-10', 'Inconclusive'),
(53, 15, '2023-08-23', 'Inconclusive'),(54, 16, '2023-03-04', 'Negative'),(55, 16, '2023-04-02', 'Positive'),(56, 16, '2023-05-26', 'Positive'),
(57, 16, '2023-06-06', 'Positive'),(58, 16, '2023-07-23', 'Positive'),(59, 17, '2023-02-03', 'Positive'),(60, 17, '2023-03-08', 'Positive'),
(61, 17, '2023-05-23', 'Positive'),(62, 18, '2023-03-06', 'Negative'),(63, 18, '2023-05-28', 'Positive');

----Solution (MSSQL)
WITH pos AS(
	SELECT patient_id,MIN(test_date) AS pos_date FROM covid_tests WHERE result='Positive' GROUP BY patient_id
), neg AS (
	SELECT CT.patient_id,pos.pos_date,MIN(CT.test_date) AS neg_date FROM covid_tests CT 
	INNER JOIN pos ON CT.patient_id=pos.patient_id
	WHERE result='Negative' AND CT.test_date>pos.pos_date
	GROUP BY CT.patient_id,pos.pos_date
), result AS ( 
	SELECT N.patient_id,P.patient_name,P.age,DATEDIFF(DAY,N.pos_date,N.neg_date) recovery_time  FROM neg N
	INNER JOIN patients P ON P.patient_id=N.patient_id
)
SELECT * FROM result ORDER BY recovery_time,patient_name

----Solution (MySQL)
--WITH pos AS(
--	SELECT patient_id,MIN(test_date) AS pos_date FROM covid_tests WHERE result='Positive' GROUP BY patient_id
--), neg AS (
--	SELECT CT.patient_id,pos.pos_date,MIN(CT.test_date) AS neg_date FROM covid_tests CT 
--	INNER JOIN pos ON CT.patient_id=pos.patient_id
--	WHERE result='Negative' AND CT.test_date>pos.pos_date
--	GROUP BY CT.patient_id,pos.pos_date
--), result AS ( 
--	SELECT N.patient_id,P.patient_name,P.age,DATEDIFF(N.neg_date,N.pos_date) recovery_time  FROM neg N
--	INNER JOIN patients P ON P.patient_id=N.patient_id
--)
--SELECT * FROM result ORDER BY recovery_time,patient_name


/*
Other test Case

| patient_id | patient_name    | age |
| ---------- | --------------- | --- |
| 1          | Henry Johnson   | 65  |
| 2          | Ruby Garcia     | 32  |
| 3          | Ivy Moore       | 61  |
| 4          | Frank Wright    | 20  |
| 5          | Bob Wilson      | 31  |
| 6          | Olivia Johnson  | 53  |
| 7          | Mia King        | 32  |
| 8          | Claire Robinson | 69  |
| 9          | Alice Jackson   | 62  |
| 10         | Brian Lee       | 35  |
| 11         | Jack Martin     | 79  |
| 12         | Victor Moore    | 23  |
| 13         | Yolanda Moore   | 40  |
| 14         | Wendy Martinez  | 69  |
| 15         | Carol Hill      | 52  |
| 16         | Henry Allen     | 23  |
| 17         | Sam Hall        | 54  |
| 18         | Mia Miller      | 20  |

| test_id | patient_id | test_date  | result       |
| ------- | ---------- | ---------- | ------------ |
| 1       | 1          | 2023-02-24 | Negative     |
| 2       | 1          | 2023-03-11 | Positive     |
| 3       | 1          | 2023-04-03 | Negative     |
| 4       | 1          | 2023-05-28 | Negative     |
| 5       | 2          | 2023-02-05 | Negative     |
| 6       | 2          | 2023-03-13 | Negative     |
| 7       | 2          | 2023-04-12 | Negative     |
| 8       | 2          | 2023-05-07 | Positive     |
| 9       | 2          | 2023-06-21 | Negative     |
| 10      | 3          | 2023-02-14 | Negative     |
| 11      | 3          | 2023-03-14 | Inconclusive |
| 12      | 3          | 2023-04-09 | Positive     |
| 13      | 3          | 2023-05-30 | Negative     |
| 14      | 4          | 2023-02-26 | Positive     |
| 15      | 4          | 2023-03-03 | Negative     |
| 16      | 4          | 2023-04-26 | Negative     |
| 17      | 4          | 2023-05-11 | Inconclusive |
| 18      | 5          | 2023-02-12 | Negative     |
| 19      | 5          | 2023-03-30 | Inconclusive |
| 20      | 5          | 2023-04-30 | Positive     |
| 21      | 5          | 2023-05-21 | Inconclusive |
| 22      | 5          | 2023-06-14 | Negative     |
| 23      | 5          | 2023-07-04 | Positive     |
| 24      | 6          | 2023-02-16 | Negative     |
| 25      | 6          | 2023-03-17 | Positive     |
| 26      | 6          | 2023-04-03 | Negative     |
| 27      | 6          | 2023-05-25 | Inconclusive |
| 28      | 7          | 2023-03-04 | Inconclusive |
| 29      | 7          | 2023-08-14 | Positive     |
| 30      | 7          | 2023-08-16 | Positive     |
| 31      | 7          | 2023-09-27 | Inconclusive |
| 32      | 8          | 2023-03-29 | Positive     |
| 33      | 8          | 2023-06-30 | Inconclusive |
| 34      | 8          | 2023-09-10 | Positive     |
| 35      | 9          | 2023-05-02 | Positive     |
| 36      | 9          | 2023-10-14 | Inconclusive |
| 37      | 9          | 2023-10-17 | Positive     |
| 38      | 10         | 2023-08-10 | Negative     |
| 39      | 11         | 2023-01-31 | Negative     |
| 40      | 11         | 2023-07-15 | Negative     |
| 41      | 11         | 2023-10-08 | Inconclusive |
| 42      | 12         | 2023-03-01 | Negative     |
| 43      | 12         | 2023-06-02 | Negative     |
| 44      | 13         | 2023-03-07 | Positive     |
| 45      | 13         | 2023-10-06 | Positive     |
| 46      | 14         | 2023-04-06 | Inconclusive |
| 47      | 14         | 2023-04-25 | Inconclusive |
| 48      | 14         | 2023-10-01 | Inconclusive |
| 49      | 15         | 2023-05-13 | Inconclusive |
| 50      | 15         | 2023-05-19 | Inconclusive |
| 51      | 15         | 2023-07-09 | Inconclusive |
| 52      | 15         | 2023-08-10 | Inconclusive |
| 53      | 15         | 2023-08-23 | Inconclusive |
| 54      | 16         | 2023-03-04 | Negative     |
| 55      | 16         | 2023-04-02 | Positive     |
| 56      | 16         | 2023-05-26 | Positive     |
| 57      | 16         | 2023-06-06 | Positive     |
| 58      | 16         | 2023-07-23 | Positive     |
| 59      | 17         | 2023-02-03 | Positive     |
| 60      | 17         | 2023-03-08 | Positive     |
| 61      | 17         | 2023-05-23 | Positive     |
| 62      | 18         | 2023-03-06 | Negative     |
| 63      | 18         | 2023-05-28 | Positive     |



Output

| patient_id | patient_name   | age | recovery_time |
| ---------- | -------------- | --- | ------------- |
| 4          | Frank Wright   | 20  | 5             |
| 6          | Olivia Johnson | 53  | 17            |
| 1          | Henry Johnson  | 65  | 23            |
| 5          | Bob Wilson     | 31  | 45            |
| 2          | Ruby Garcia    | 32  | 45            |
| 3          | Ivy Moore      | 61  | 51            |
*/



--drop table
DROP TABLE patients
DROP TABLE covid_tests