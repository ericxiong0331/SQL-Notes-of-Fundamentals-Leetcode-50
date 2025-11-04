# 1978 Employees Whose Manager Left the Company
SELECT e.employee_id
FROM Employees e
WHERE e.manager_id NOT IN (
    SELECT DISTINCT m.employee_id
    FROM Employees m
) AND (e.manager_id IS NOT NULL) AND salary < 30000
ORDER BY e.employee_id;

# 626 Exchange Seats  
-- SELECT  
--     IF(id % 2 = 0,  
--         id - 1,  
--         IF(id = (SELECT COUNT(DISTINCT id) FROM seat),  
--             id,  
--             id + 1)  
--     ) AS id,  
--     student  
-- FROM seat  
-- ORDER BY id;  
# Aggregate functions cannot be used in IF() or WHERE clauses.  
# They can only appear in CASE WHEN or HAVING clauses.  
# To select the row with the maximum id, use a subquery with MAX() inside IF().
WITH ex AS(
    SELECT id+1 AS id, student
    FROM Seat 
    WHERE MOD(id,2) = 1
    UNION 
    
    SELECT id-1 AS id, student
    FROM Seat
    WHERE Mod(id,2) = 0
    UNION
    
    SELECT *
    FROM(
    SELECT *
    FROM Seat
    ORDER BY id DESC
    LIMIT 1
    ) AS t
    WHERE Mod(id,2) = 1 
)
SELECT s.id, ex.student
FROM Seat s
LEFT JOIN ex USING (id)
ORDER BY id;

# 1341 Movie Rating  
# For multiple common table expressions (CTEs), use WITH only once before SELECT:  
-- WITH t1 AS (...), t2 AS (...)  
# Use UNION ALL instead of UNION to preserve duplicate results.
# Example:  
-- SELECT 1 UNION SELECT 2 UNION SELECT 2 UNION SELECT 3;  
# Returns 1, 2, 3 (duplicates removed).  
-- SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 2 UNION ALL SELECT 3;  
# Returns 1, 2, 2, 3 (duplicates kept).
With movies_users AS (
    SELECT u.name, COUNT(DISTINCT movie_id) AS numbers
    FROM Users u
    LEFT JOIN MovieRating USING (user_id)
    GROUP BY u.user_id
),
movies_rating AS (
    SELECT title, AVG(rating) AS avg_ratings
    FROM Movies m
    LEFT JOIN MovieRating USING (movie_id)
    WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY m.movie_id
)
(SELECT name AS results
FROM movies_users
ORDER BY numbers DESC, name
LIMIT 1)
UNION ALL
(SELECT title AS results
FROM movies_rating
ORDER BY avg_ratings DESC, title
LIMIT 1);

# 1321 Restaurant Growth
WITH start_1 AS(
    SELECT
        visited_on,
        ROUND(SUM(daily_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 preceding AND current row),2) AS amount,
        ROUND(AVG(daily_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 preceding AND current row),2) AS average_amount
    FROM(
        SELECT visited_on, SUM(amount) AS daily_amount
        FROM Customer
        GROUP BY visited_on
    ) AS daily_customer
    ORDER BY visited_on
)
SELECT *
FROM start_1
WHERE visited_on >= (
    SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY) FROM start_1
);

# 602 Friend Requests II: Who Has the Most Friends
WITH id_s AS(
    SELECT DISTINCT requester_id AS id FROM RequestAccepted
    UNION
    SELECT DISTINCT accepter_id FROM RequestAccepted
),
accepters AS(
    SELECT accepter_id, COUNT(DISTINCT requester_id) AS request_num
    FROM RequestAccepted
    GROUP BY accepter_id
),
requesters AS(
    SELECT requester_id, COUNT(DISTINCT accepter_id) AS accept_num
    FROM RequestAccepted
    GROUP BY requester_id
)
SELECT *
FROM(
    SELECT id, IF(request_num IS NULL, 0, request_num) + IF(accept_num IS NULL, 0, accept_num) AS num
    FROM id_s
    LEFT JOIN accepters ON id = accepter_id
    LEFT JOIN requesters ON id = requester_id
) AS total_frds
ORDER BY num DESC
LIMIT 1;

# 585 Investments in 2016
WITH condition2 AS(
    SELECT pid
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
),
condition1 AS(
    SELECT CASE WHEN COUNT(*) OVER(PARTITION BY tiv_2015)>1 THEN pid END AS pid
    FROM Insurance
)
SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM Insurance i, condition1 c1, condition2 c2
WHERE i.pid = c1.pid AND i.pid = c2.pid;

# 185 Department Top Three Salaries  
# RANK() does not take parameters inside parentheses.
SELECT Department, Employee, Salary
FROM(
    SELECT d.name AS Department, e.name AS Employee, salary AS Salary,
        DENSE_RANK() OVER(PARTITION BY d.id ORDER BY salary DESC) AS ranks
    FROM Department d
    LEFT JOIN Employee e ON d.id = e.departmentID
    WHERE Salary IS NOT NULL
) AS ranked_salaries
WHERE ranks <= 3 AND ranks IS NOT NULL;
