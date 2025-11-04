# 1731 The Number of Employees Which Report to Each Employee
SELECT m.employee_id, m.name,
    COUNT(e.employee_id) AS reports_count,
    ROUND(AVG(e.age)) AS average_age
FROM Employees e, Employees m
WHERE e.reports_to IS NOT NULL AND e.reports_to = m.employee_id
GROUP BY m.employee_id 
ORDER BY m.employee_id;

# 1789 Primary Department for Each Employee  
# Window functions can avoid the GROUP BY limitation where HAVING conditions must be part of the SELECT clause.
# Answer 1
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'
GROUP BY employee_id
UNION 
SELECT employee_id, department_id
FROM Employee
GROUP BY employee_id
HAVING (COUNT(*) = 1);
# Answer 2
SELECT employee_id, department_id
FROM(
    SELECT employee_id, department_id, primary_flag,
        COUNT(*) OVER(PARTITION BY employee_id) AS counts
    FROM Employee
) AS counted_employee
WHERE primary_flag = 'Y' OR counts = 1;

# 610 Triangle Judgement
SELECT x,y,z,
   IF(x+y > z AND y+z > x AND x+z > y, 'Yes', 'No') AS triangle
FROM Triangle;

# 180 Consecutive Numbers  
# WHERE clauses cannot use double equals (==); use a single equals sign (=).
SELECT DISTINCT num AS ConsecutiveNums
FROM Logs L0,(
    SELECT id-1 AS id_1, num AS num_1
    FROM Logs
) AS L1, (
    SELECT id-2 AS id_2, num AS num_2
    FROM Logs 
) AS L2
WHERE id = id_1 AND id_1 = id_2 AND num = num_1 AND num_1= num_2;

# 1164 Product Price at a Given Date
SELECT DISTINCT up.product_id, IF(price IS NULL, 10, price) AS price
FROM (
    SELECT DISTINCT product_id
    FROM Products
) AS up 
LEFT JOIN (
    SELECT product_id, 
    IF(change_date = MAX(change_date) OVER(PARTITION BY product_id),new_price,-1) AS price
    FROM Products
    WHERE change_date <= '2019-08-16'
) AS p USING(product_id)
WHERE price != -1 OR price IS NULL;

# 1204 Last Person to Fit in the Bus  
# Use SELECT with ORDER BY and LIMIT 1 to return maximum or minimum values.
SELECT person_name
FROM (
    SELECT person_name, SUM(weight) OVER(ORDER BY turn ROWS BETWEEN unbounded preceding AND current row) AS total_weight
    FROM Queue
) AS weight
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;

# 1907 Count Salary Categories
WITH counts AS(
    SELECT category, COUNT(DISTINCT account_id) AS accounts_count
    FROM (
        SELECT account_id,
        CASE WHEN income > 50000 THEN 'High Salary'
        WHEN income < 20000 THEN 'Low Salary'
        ElSE 'Average Salary'
        END AS category
        FROM Accounts
    ) AS catnum
    GROUP BY category
)
SELECT category,
    IF(accounts_count IS NULL, 0, accounts_count) AS accounts_count
FROM counts
RIGHT JOIN (
    SELECT 'High Salary' AS category
    UNION 
    SELECT 'Average Salary'
    UNION
    SELECT 'Low Salary'
) AS cats USING (category);

