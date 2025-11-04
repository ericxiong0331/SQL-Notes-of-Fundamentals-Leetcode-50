# 1757 Recyclable and Low Fat Products
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

# 584 Find Customer Referee
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id is NULL;

# 595 Big Countries
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;

# 1148 Article Views I
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id ASC;

# 1683 Invalid Tweets
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
