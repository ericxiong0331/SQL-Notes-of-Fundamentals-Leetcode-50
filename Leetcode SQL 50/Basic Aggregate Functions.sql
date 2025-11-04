# 620 Not Boring Movies  
-- MOD(x, y)  
# Returns the remainder of x divided by y.
SELECT *
FROM cinema
WHERE (description NOT LIKE '%boring%') AND ID/2 != ROUND(ID/2) 
ORDER BY rating DESC;

# 1251 Average Selling Price  
-- IFNULL(ROUND(SUM(sales) / SUM(units), 2), 0)  
# Replaces NULL values with 0 after rounding the division result.
SELECT p.product_id,
    IF(SUM(price * units) IS NULL, 0, ROUND(SUM(price * units)/SUM(units),2)) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u USING(product_id)
WHERE (purchase_date BETWEEN start_date AND end_date) OR (purchase_date IS NULL)
GROUP BY product_id;

# 1075 Project Employees I
SELECT project_id, 
    ROUND(AVG(experience_years),2) AS average_years
FROM Project
JOIN Employee USING (employee_id)
GROUP BY project_id;

# 1633 Percentage of Users Attended a Contest
SELECT contest_id, 
    ROUND(100*COUNT(user_id)/(
        SELECT COUNT(*)
        FROM Users
    ),2) AS percentage
FROM Register 
GROUP BY contest_id
ORDER BY percentage DESC, contest_id;

# 1211 Queries Quality and Percentage
SELECT query_name,
    ROUND(AVG(rating/position),2) AS quality,
    ROUND(100* SUM(IF(rating<3,1,0))
    /COUNT(*),2) AS poor_query_percentage
FROM (
    SELECT DISTINCT *
    FROM Queries
) AS Queries_distinct
GROUP BY query_name;

# 1193 Monthly Transactions I
SELECT month, country,
    COUNT(*) AS trans_count,
    SUM(IF(state = 'approved',1,0)) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(IF(state = 'approved',amount,0)) AS approved_total_amount
FROM (
    SELECT DATE_FORMAT(trans_date,'%Y-%m') AS month,
        country, state, amount
    FROM Transactions 
) AS monthly_t
GROUP BY month, country;

# 1174 Immediate Food Delivery II  
-- SELECT IF(customer_pref_delivery_date = order_date, 1, 0) AS immediate_count, order_date  
-- FROM Delivery  
-- GROUP BY customer_id  
-- HAVING order_date = MIN(order_date);  
# HAVING may remove entire groups if the randomly chosen representative row fails the condition.  
SELECT DISTINCT ROUND(100*AVG(immediate_count) OVER(),2) AS immediate_percentage
FROM (
    SELECT IF(customer_pref_delivery_date = order_date, 1, 0) AS immediate_count,    
        order_date,
        MIN(order_date) OVER(PARTITION BY customer_id) AS first_date
    FROM Delivery
) AS a
WHERE order_date = first_date;
# Uses a window function to find the first order per customer and calculate immediate delivery percentage.

# 550 Game Play Analysis IV  
# COUNT(*) can be used as a general function (not necessarily as an aggregate).
WITH b AS(
    SELECT player_id,
        DATE_ADD(MIN(event_date), INTERVAL 1 DAY) AS next_day_possible  
    FROM Activity
    GROUP BY player_id
)
SELECT DISTINCT ROUND(COUNT(*)/
    (SELECT COUNT(*) FROM b),2)
    AS fraction
FROM Activity a, b
WHERE a.player_id = b.player_id AND event_date = next_day_possible;

