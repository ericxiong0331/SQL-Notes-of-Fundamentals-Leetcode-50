# 2356 Number of Unique Subjects Taught by Each Teacher
SELECT teacher_id,
    COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;

# 1141 User Activity for the Past 30 Days I
SELECT activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
GROUP BY activity_date
HAVING activity_date BETWEEN DATE_ADD("2019-07-27", INTERVAL -29 DAY) AND '2019-07-27';

# 1070 Product Sales Analysis III
SELECT DISTINCT s.product_id, product_name
FROM Sales s, Product p
WHERE s.product_id = p.product_id
GROUP BY product_id
HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31';

# 596 Classes With at Least 5 Students
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;

# 1729 Find Followers Count
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;

# 619 Biggest Single Number
SELECT IF(COUNT(num) = 0, NULL, MAX(num)) AS num
FROM(
    SELECT *
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS unique_num;

# 1045 Customers Who Bought All Products
SELECT customer_id
FROM (
    SELECT customer_id, COUNT(DISTINCT product_key) AS own_products
    FROM Product
    LEFT JOIN Customer USING (product_key)
    GROUP BY customer_id
) AS ownings
WHERE own_products = (
    SELECT COUNT(*) FROM Product
);
