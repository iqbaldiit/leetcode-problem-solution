--Source (mssql): https://leetcode.com/problems/first-letter-capitalization-ii/solutions/6713111/simple-best-solution-by-iqbaldiit-38bj/
--Source (pgsql): https://leetcode.com/problems/first-letter-capitalization-ii/solutions/6729442/simple-best-solution-by-iqbaldiit-mpqb/
/*
	Table: user_content

	+-------------+---------+
	| Column Name | Type    |
	+-------------+---------+
	| content_id  | int     |
	| content_text| varchar |
	+-------------+---------+
	content_id is the unique key for this table.
	Each row contains a unique ID and the corresponding text content.
	Write a solution to transform the text in the content_text column by applying the following rules:

	Convert the first letter of each word to uppercase and the remaining letters to lowercase
	Special handling for words containing special characters:
	For words connected with a hyphen -, both parts should be capitalized (e.g., top-rated → Top-Rated)
	All other formatting and spacing should remain unchanged
	Return the result table that includes both the original content_text and the modified text following the above rules.

	The result format is in the following example.

 

	Example:

	Input:

	user_content table:

	+------------+---------------------------------+
	| content_id | content_text                    |
	+------------+---------------------------------+
	| 1          | hello world of SQL              |
	| 2          | the QUICK-brown fox             |
	| 3          | modern-day DATA science         |
	| 4          | web-based FRONT-end development |
	+------------+---------------------------------+
	Output:

	+------------+---------------------------------+---------------------------------+
	| content_id | original_text                   | converted_text                  |
	+------------+---------------------------------+---------------------------------+
	| 1          | hello world of SQL              | Hello World Of Sql              |
	| 2          | the QUICK-brown fox             | The Quick-Brown Fox             |
	| 3          | modern-day DATA science         | Modern-Day Data Science         |
	| 4          | web-based FRONT-end development | Web-Based Front-End Development |
	+------------+---------------------------------+---------------------------------+
	Explanation:

	For content_id = 1:
	Each word's first letter is capitalized: "Hello World Of Sql"
	For content_id = 2:
	Contains the hyphenated word "QUICK-brown" which becomes "Quick-Brown"
	Other words follow normal capitalization rules
	For content_id = 3:
	Hyphenated word "modern-day" becomes "Modern-Day"
	"DATA" is converted to "Data"
	For content_id = 4:
	Contains two hyphenated words: "web-based" → "Web-Based"
	And "FRONT-end" → "Front-End"
*/

--create table
CREATE TABLE user_content (content_id INT,content_text VARCHAR(255));

--insert data
INSERT INTO user_content (content_id, content_text) VALUES
(1, 'hello world of SQL'),(2, 'the QUICK-brown fox')
,(3, 'modern-day DATA science'),(4, 'web-based FRONT-end development');

--solution (MSSQL)

;WITH SplitWords AS (
    SELECT content_id, value AS word
    FROM user_content
    CROSS APPLY STRING_SPLIT(content_text, ' ')
),
FormattedWords AS (
    SELECT content_id,
           STRING_AGG(
               CASE 
                   WHEN CHARINDEX('-', word) > 0 THEN 
                        CONCAT(
								CONCAT(UPPER(LEFT(word,1)),LOWER(SUBSTRING(word,2, CHARINDEX('-', word) - 1)))																	
								, CONCAT(
										UPPER(LEFT(SUBSTRING(word, CHARINDEX('-', word) + 1, LEN(word)),1))
										,LOWER(RIGHT(word,LEN(word)-CHARINDEX('-', word)-1))
										)
								)
                   ELSE 
                        CONCAT(UPPER(LEFT(word, 1)), LOWER(SUBSTRING(word, 2, LEN(word))))
               END, ' '
           ) AS converted_text
    FROM SplitWords
    GROUP BY content_id
)
SELECT uc.content_id, uc.content_text AS original_text, fw.converted_text
FROM user_content uc
JOIN FormattedWords fw ON uc.content_id = fw.content_id;


--Solution (pgsql)

-- WITH SplitWords AS (
--     SELECT 
--         content_id, 
--         unnest(string_to_array(content_text, ' ')) AS word
--     FROM user_content
-- ),
-- FormattedWords AS (
--     SELECT 
--         content_id,
--         string_agg(
--             CASE 
--                 WHEN position('-' IN word) > 0 THEN 
--                     -- Handle hyphenated words
--                     (
--                         SELECT string_agg(
--                             upper(substring(part FROM 1 FOR 1)) || 
--                             lower(substring(part FROM 2)),
--                             '-'
--                         ) 
--                         FROM unnest(string_to_array(word, '-')) AS part
--                     )
--                 ELSE 
--                     -- Handle regular words
--                     upper(substring(word FROM 1 FOR 1)) || 
--                     lower(substring(word FROM 2))
--             END,
--             ' '
--         ) AS converted_text
--     FROM SplitWords
--     GROUP BY content_id
-- )
-- SELECT 
--     uc.content_id, 
--     uc.content_text AS original_text, 
--     fw.converted_text
-- FROM user_content uc
-- JOIN FormattedWords fw ON uc.content_id = fw.content_id;


--drop table
DROP TABLE user_content
