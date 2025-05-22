--source(mssql): https://leetcode.com/problems/find-students-who-improved/solutions/6761966/simple-best-solution/
--source(mySQL): https://leetcode.com/problems/find-students-who-improved/solutions/6765239/simple-best-solution-by-iqbaldiit-b7y4/
/*
	Table: Scores

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| student_id  | int     |
	| subject     | varchar |
	| score       | int     |
	| exam_date   | varchar |
	+-------------+---------+
	(student_id, subject, exam_date) is the primary key for this table.
	Each row contains information about a student's score in a specific subject on a particular exam date. score is between 0 and 100 (inclusive).
	Write a solution to find the students who have shown improvement. A student is considered to have shown improvement if they meet both of these conditions:

	Have taken exams in the same subject on at least two different dates
	Their latest score in that subject is higher than their first score
	Return the result table ordered by student_id, subject in ascending order.

	The result format is in the following example.

 

	Example:

	Input:

	Scores table:

	+------------+----------+-------+------------+
	| student_id | subject  | score | exam_date  |
	+------------+----------+-------+------------+
	| 101        | Math     | 70    | 2023-01-15 |
	| 101        | Math     | 85    | 2023-02-15 |
	| 101        | Physics  | 65    | 2023-01-15 |
	| 101        | Physics  | 60    | 2023-02-15 |
	| 102        | Math     | 80    | 2023-01-15 |
	| 102        | Math     | 85    | 2023-02-15 |
	| 103        | Math     | 90    | 2023-01-15 |
	| 104        | Physics  | 75    | 2023-01-15 |
	| 104        | Physics  | 85    | 2023-02-15 |
	+------------+----------+-------+------------+
	Output:

	+------------+----------+-------------+--------------+
	| student_id | subject  | first_score | latest_score |
	+------------+----------+-------------+--------------+
	| 101        | Math     | 70          | 85           |
	| 102        | Math     | 80          | 85           |
	| 104        | Physics  | 75          | 85           |
	+------------+----------+-------------+--------------+
	Explanation:

	Student 101 in Math: Improved from 70 to 85
	Student 101 in Physics: No improvement (dropped from 65 to 60)
	Student 102 in Math: Improved from 80 to 85
	Student 103 in Math: Only one exam, not eligible
	Student 104 in Physics: Improved from 75 to 85
*/

--create table
CREATE TABLE Scores (student_id INT,subject VARCHAR(50),score INT CHECK (score BETWEEN 0 AND 100),exam_date VARCHAR(10));

--insert table
INSERT INTO Scores (student_id, subject, score, exam_date) VALUES
(101, 'Math', 70, '2023-01-15'),(101, 'Math', 85, '2023-02-15'),(101, 'Physics', 65, '2023-01-15'),
(101, 'Physics', 60, '2023-02-15'),(102, 'Math', 80, '2023-01-15'),(102, 'Math', 85, '2023-02-15'),
(103, 'Math', 90, '2023-01-15'),(104, 'Physics', 75, '2023-01-15'),(104, 'Physics', 85, '2023-02-15');

----solution (MSSQL, PostGreSQL, MySQL)
WITH tab AS(
	SELECT * 
	,FIRST_VALUE(score) OVER (PARTITION BY student_id, subject Order by exam_date) AS first_score
	,LAST_VALUE(score) OVER (PARTITION BY student_id, subject Order by exam_date
								ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS latest_score
	FROM Scores 
)
SELECT DISTINCT student_id,subject,first_score,latest_score FROM tab WHERE latest_score>first_score
ORDER BY student_id

----Solution (Oracle)
--SELECT * FROM (
--SELECT 
--    student_id,
--    subject,
--    MIN(score) KEEP (DENSE_RANK FIRST ORDER BY exam_date) AS first_score,
--    MAX(score) KEEP (DENSE_RANK LAST ORDER BY exam_date) AS latest_score
--FROM Scores
--GROUP BY student_id, subject
--HAVING COUNT(*) >= 2)tab WHERE latest_score > first_score
--ORDER BY student_id, subject;


DROP TABLE Scores