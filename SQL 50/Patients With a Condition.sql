/*
Source (MSSQL): https://leetcode.com/problems/patients-with-a-condition/solutions/5294647/using-cross-apply-string-split-function/
Source (PostGreSQL): https://leetcode.com/problems/patients-with-a-condition/solutions/6326035/simple-best-solution-by-iqbaldiit-vqsg/

Table: Patients

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key (column with unique values) for this table.
'conditions' contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.
 

Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Patients table:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        |              |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |
+------------+--------------+--------------+
Output: 
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 | 
+------------+--------------+--------------+
Explanation: Bob and George both have a condition that starts with DIAB1.
*/

--Create Table
CREATE TABLE Patients (patient_id INT, patient_name VARCHAR(100),conditions VARCHAR(100));

--Insert Data
INSERT INTO Patients Values(1,'Daniel','YFEV COUGH');
INSERT INTO Patients Values(2,'Alice ','');
INSERT INTO Patients Values(3,'Bob','DIAB100 MYOP');
INSERT INTO Patients Values(4,'George','ACNE DIAB100');
INSERT INTO Patients Values(5,'Alain','DIAB201');

--Solution (MSSQL)
SELECT patient_id,patient_name, conditions
FROM Patients
CROSS APPLY STRING_SPLIT(conditions, ' ')
WHERE value LIKE 'DIAB1%';

SELECT patient_id,patient_name, conditions
FROM Patients WHERE conditions LIKE '%DIAB1%'

----Solution (PostGresSQL)
--SELECT patient_id, patient_name, conditions
--FROM Patients
--JOIN LATERAL unnest(string_to_array(conditions, ' ')) AS value ON value LIKE 'DIAB1%';

--DROp Table
DROP TABLE Patients;