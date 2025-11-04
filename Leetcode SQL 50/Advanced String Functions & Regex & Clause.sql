# 1667 Fix Names in a Table   
# Converts the first letter of each name to uppercase and the rest to lowercase.
SELECT user_id,
    CONCAT(UPPER(LEFT(name,1))
        ,LOWER(SUBSTRING(name,2))) AS name
FROM Users
ORDER BY user_id;

# 1527 Patients With a Condition  
-- WHERE condition LIKE 'DIAB1%' OR condition LIKE '% DIAB1%'  
-- WHERE condition REGEXP '^DIAB1| DIAB1'  
# Both statements match strings that start with or contain 'DIAB1'.
SELECT patient_id, patient_name, conditions
FROM Patients
-- WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%'
WHERE conditions REGEXP '^DIAB1| DIAB1';

# 196 Delete Duplicate Emails
DELETE p2 FROM Person p1, Person p2
WHERE p1.email = p2.email AND p1.id < p2.id;

# 176 Second Highest Salary
SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);

# 1484 Group Sold Products By The Date  
# Using GROUP_CONCAT function  
-- GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',')  
# Concatenates distinct product names separated by commas.
SELECT sell_date, COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS products
FROM Activities
GROUP BY sell_date;

# 1327 List the Products Ordered in a Period
SELECT product_name, unit
FROM Products p, 
    (SELECT product_id, SUM(unit) AS unit
    FROM Orders 
    WHERE order_date BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY product_id    
    ) o
WHERE o.unit >= 100 AND o.product_id = p.product_id;

# 1517 Find Users With Valid E-Mails  
# Regular Expression Notes:  
# The AND condition in regex cannot restrict other characters unless the full expression anchors start and end.  
# ^[a-zA-Z] → starts with a letter.  
# [a-zA-Z0-9\\_\\.\\-] → allows only letters, digits, underscores, dots, and hyphens.  
# * → matches zero or more occurrences.  
# @leetcode\\.com$ → ends with "@leetcode.com".  
# \\ → escape character to treat punctuation literally.  

-- WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9\\_\\.\\-]*@leetcode\\.com$'  
# Case-insensitive by default.  

-- WHERE REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9\\_\\.\\-]*@leetcode\\.com$', 'c')  
# REGEXP_LIKE enforces case-sensitive matching.
SELECT *
FROM Users
WHERE REGEXP_LIKE(mail,'^[a-zA-Z][a-zA-Z0-9\\_\\.\\-]*@leetcode\\.com$','c');