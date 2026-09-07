/*
https://leetcode.com/problems/find-churn-risk-customers/description/
	Table: subscription_events

	+------------------+---------+
	| Column Name      | Type    | 
	+------------------+---------+
	| event_id         | int     |
	| user_id          | int     |
	| event_date       | date    |
	| event_type       | varchar |
	| plan_name        | varchar |
	| monthly_amount   | decimal |
	+------------------+---------+
	event_id is the unique identifier for this table.
	event_type can be start, upgrade, downgrade, or cancel.
	plan_name can be basic, standard, premium, or NULL (when event_type is cancel).
	monthly_amount represents the monthly subscription cost after this event.
	For cancel events, monthly_amount is 0.
	Write a solution to Find Churn Risk Customers - users who show warning signs before churning. A user is considered churn risk customer if they meet ALL the following criteria:

	Currently have an active subscription (their last event is not cancel).
	Have performed at least one downgrade in their subscription history.
	Their current plan revenue is less than 50% of their historical maximum plan revenue.
	Have been a subscriber for at least 60 days.
	Return the result table ordered by days_as_subscriber in descending order, then by user_id in ascending order.

	The result format is in the following example.

 

	Example:

	Input:

	subscription_events table:

	+----------+---------+------------+------------+-----------+----------------+
	| event_id | user_id | event_date | event_type | plan_name | monthly_amount |
	+----------+---------+------------+------------+-----------+----------------+
	| 1        | 501     | 2024-01-01 | start      | premium   | 29.99          |
	| 2        | 501     | 2024-02-15 | downgrade  | standard  | 19.99          |
	| 3        | 501     | 2024-03-20 | downgrade  | basic     | 9.99           |
	| 4        | 502     | 2024-01-05 | start      | standard  | 19.99          |
	| 5        | 502     | 2024-02-10 | upgrade    | premium   | 29.99          |
	| 6        | 502     | 2024-03-15 | downgrade  | basic     | 9.99           |
	| 7        | 503     | 2024-01-10 | start      | basic     | 9.99           |
	| 8        | 503     | 2024-02-20 | upgrade    | standard  | 19.99          |
	| 9        | 503     | 2024-03-25 | upgrade    | premium   | 29.99          |
	| 10       | 504     | 2024-01-15 | start      | premium   | 29.99          |
	| 11       | 504     | 2024-03-01 | downgrade  | standard  | 19.99          |
	| 12       | 504     | 2024-03-30 | cancel     | NULL      | 0.00           |
	| 13       | 505     | 2024-02-01 | start      | basic     | 9.99           |
	| 14       | 505     | 2024-02-28 | upgrade    | standard  | 19.99          |
	| 15       | 506     | 2024-01-20 | start      | premium   | 29.99          |
	| 16       | 506     | 2024-03-10 | downgrade  | basic     | 9.99           |
	+----------+---------+------------+------------+-----------+----------------+
	Output:

	+----------+--------------+------------------------+-----------------------+--------------------+
	| user_id  | current_plan | current_monthly_amount | max_historical_amount | days_as_subscriber |
	+----------+--------------+------------------------+-----------------------+--------------------+
	| 501      | basic        | 9.99                   | 29.99                 | 79                 |
	| 502      | basic        | 9.99                   | 29.99                 | 70                 |
	+----------+--------------+------------------------+-----------------------+--------------------+
	Explanation:

	User 501:
	Currently active: Last event is downgrade to basic (not cancelled) 
	Has downgrades: Yes, 2 downgrades in history 
	Current revenue (9.99) vs max (29.99): 9.99/29.99 = 33.3% (less than 50%) 
	Days as subscriber: Jan 1 to Mar 20 = 79 days (at least 60) 
	Result: Churn Risk Customer
	User 502:
	Currently active: Last event is downgrade to basic (not cancelled) 
	Has downgrades: Yes, 1 downgrade in history 
	Current revenue (9.99) vs max (29.99): 9.99/29.99 = 33.3% (less than 50%) 
	Days as subscriber: Jan 5 to Mar 15 = 70 days (at least 60) 
	Result: Churn Risk Customer
	User 503:
	Currently active: Last event is upgrade to premium (not cancelled) 
	Has downgrades: No downgrades in history 
	Result: Not at-risk (no downgrade history)
	User 504:
	Currently active: Last event is cancel
	Result: Not at-risk (subscription cancelled)
	User 505:
	Currently active: Last event is 'upgrade' to standard (not cancelled) 
	Has downgrades: No downgrades in history 
	Result: Not at-risk (no downgrade history)
	User 506:
	Currently active: Last event is downgrade to basic (not cancelled) 
	Has downgrades: Yes, 1 downgrade in history 
	Current revenue (9.99) vs max (29.99): 9.99/29.99 = 33.3% (less than 50%) 
	Days as subscriber: Jan 20 to Mar 10 = 50 days (less than 60) 
	Result: Not at-risk (insufficient subscription duration)
	Result table is ordered by days_as_subscriber DESC, then user_id ASC.

	Note: days_as_subscriber is calculated from the first event date to the last event date for each user.

 
*/

CREATE TABLE subscription_events (
    event_id       INT           NOT NULL,
    user_id        INT           ,
    event_date     DATE          ,
    event_type     VARCHAR(50)   ,
    plan_name      VARCHAR(100)  ,
    monthly_amount DECIMAL(10,2) 
);

GO

--INSERT INTO subscription_events (event_id, user_id, event_date, event_type, plan_name, monthly_amount)
--VALUES
--(1, 501, '2024-01-01', 'start', 'premium', 29.99),
--(2, 501, '2024-02-15', 'downgrade', 'standard', 19.99),
--(3, 501, '2024-03-20', 'downgrade', 'basic', 9.99),
--(4, 502, '2024-01-05', 'start', 'standard', 19.99),
--(5, 502, '2024-02-10', 'upgrade', 'premium', 29.99),
--(6, 502, '2024-03-15', 'downgrade', 'basic', 9.99),
--(7, 503, '2024-01-10', 'start', 'basic', 9.99),
--(8, 503, '2024-02-20', 'upgrade', 'standard', 19.99),
--(9, 503, '2024-03-25', 'upgrade', 'premium', 29.99),
--(10, 504, '2024-01-15', 'start', 'premium', 29.99),
--(11, 504, '2024-03-01', 'downgrade', 'standard', 19.99),
--(12, 504, '2024-03-30', 'cancel', NULL, 0.00),
--(13, 505, '2024-02-01', 'start', 'basic', 9.99),
--(14, 505, '2024-02-28', 'upgrade', 'standard', 19.99),
--(15, 506, '2024-01-20', 'start', 'premium', 29.99),
--(16, 506, '2024-03-10', 'downgrade', 'basic', 9.99);



INSERT INTO subscription_events (event_id, user_id, event_date, event_type, plan_name, monthly_amount)
VALUES
(1, 501, '2024-01-01', 'start', 'premium', 29.99),
(2, 501, '2024-02-15', 'downgrade', 'standard', 19.99),
(3, 501, '2024-03-20', 'downgrade', 'basic', 9.99),
(4, 502, '2024-01-05', 'start', 'standard', 19.99),
(5, 502, '2024-02-10', 'upgrade', 'premium', 29.99),
(6, 502, '2024-03-15', 'downgrade', 'basic', 9.99),
(7, 503, '2024-01-10', 'start', 'basic', 9.99),
(8, 503, '2024-02-20', 'upgrade', 'standard', 19.99),
(9, 503, '2024-03-25', 'upgrade', 'premium', 29.99),
(10, 504, '2024-01-15', 'start', 'premium', 29.99),
(11, 504, '2024-03-01', 'downgrade', 'standard', 19.99),
(12, 504, '2024-03-30', 'cancel', NULL, 0.00),
(13, 504, '2024-03-30', 'start', 'basic', 9.99),
(14, 504, '2024-03-30', 'cancel', NULL, 0.00),
(15, 505, '2024-02-01', 'start', 'basic', 9.99),
(16, 505, '2024-02-28', 'upgrade', 'standard', 19.99),
(17, 506, '2024-01-20', 'start', 'premium', 29.99),
(18, 506, '2024-03-10', 'downgrade', 'basic', 9.99);



GO

SELECT * FROM subscription_events

--;WITH tbl_max AS(
--	SELECT user_id, MAX(event_date) last_event_date,MAX(monthly_amount)  AS max_amount  ,MAX(event_id) AS event_id
--	FROM subscription_events GROUP BY user_id
--),tbl_active_subscription AS(
--	SELECT SE.user_id,SE.monthly_amount,LE.max_amount,SE.plan_name AS current_plan FROM subscription_events SE
--	INNER JOIN tbl_max LE ON SE.event_id=LE.event_id --SE.user_id=LE.user_id AND SE.event_date=LE.last_event_date AND 
--	WHERE SE.event_type<>'cancel'
--), tbl_one_downgrade AS (
--	SELECT * FROM tbl_active_subscription WHERE user_id IN (
--	SELECT user_id FROM subscription_events WHERE event_type='downgrade')
--) ,tbl_days_sub AS (
--	SELECT user_id,DATEDIFF(DAY,MIN(event_date),MAX(event_date)) AS days_as_subscriber FROM subscription_events
--	GROUP BY user_id  
--)
--SELECT ds.user_id,od.current_plan,od.monthly_amount AS current_monthly_amount  
--,od.max_amount AS max_historical_amount, ds.days_as_subscriber
--FROM tbl_days_sub ds 
--INNER JOIN tbl_one_downgrade od ON ds.user_id=od.user_id
--WHERE ds.days_as_subscriber>=60 AND (od.monthly_amount/od.max_amount)*100.00<50.00
--ORDER BY ds.days_as_subscriber DESC, ds.user_id ASC

;WITH user_stats AS (
    SELECT
        user_id,
        -- Latest non‑cancel event (most recent by date, tie‑break by event_id)
        FIRST_VALUE(plan_name)   OVER (PARTITION BY user_id ORDER BY event_date DESC, event_id DESC) AS current_plan,
        FIRST_VALUE(monthly_amount) OVER (PARTITION BY user_id ORDER BY event_date DESC, event_id DESC) AS current_amount,
        -- Historical maximum monthly amount
        MAX(monthly_amount) OVER (PARTITION BY user_id) AS max_historical,
        -- First and last event dates for subscriber tenure
        MIN(event_date) OVER (PARTITION BY user_id) AS first_date,
        MAX(event_date) OVER (PARTITION BY user_id) AS last_date,
        -- Flag if user has ever downgraded
        MAX(CASE WHEN event_type = 'downgrade' THEN 1 ELSE 0 END) OVER (PARTITION BY user_id) AS has_downgrade
    FROM subscription_events
),active_users AS (
    SELECT
        user_id,
        current_plan,
        current_amount,
        max_historical,
        DATEDIFF(DAY, first_date, last_date) AS days_as_subscriber
    FROM user_stats
    WHERE 
        current_plan IS NOT NULL          -- latest event is not 'cancel' (plan_name is NULL for cancel)
        AND has_downgrade = 1
        AND DATEDIFF(DAY, first_date, last_date) >= 60
        AND max_historical > 0            -- avoid division by zero
        AND (current_amount * 100.0 / max_historical) < 50.0
)
SELECT DISTINCT
    user_id,
    current_plan,
    current_amount AS current_monthly_amount,
    max_historical AS max_historical_amount,
    days_as_subscriber
FROM active_users
ORDER BY days_as_subscriber DESC, user_id ASC;


DROP TABLE subscription_events

