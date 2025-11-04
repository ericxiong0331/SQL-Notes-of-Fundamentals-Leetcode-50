# 1378 Replace Employee ID With The Unique Identifier
SELECT unique_id, name 
FROM Employees e
LEFT JOIN EmployeeUNI ei 
    ON e.id = ei.id;
    
# 1068 Product Sales Analysis I
SELECT product_name, year, price
FROM Sales
JOIN Product USING(product_id);

# 1581 Customer Who Visited but Did Not Make Any Transactions
SELECT customer_id, COUNT(*) AS count_no_trans 
FROM Visits
LEFT JOIN Transactions USING (visit_id)
WHERE transaction_id is NULL AND amount is NULL
GROUP BY customer_id;

# 197 Rising Temperature
SELECT a.id
FROM Weather a
JOIN Weather b 
    ON a.recordDate = Date_ADD(b.recordDate, INTERVAL 1 DAY)
WHERE a.temperature > b.temperature;

# 1661 Average Time of Process per Machine
-- Answer 1:
SELECT machine_id, ROUND(AVG(b.timestamp - a.timestamp),3) AS processing_time
FROM (
    SELECT *
    FROM Activity
    WHERE activity_type = 'start'
    ) AS a
LEFT JOIN (
    SELECT *
    FROM Activity
    WHERE activity_type = 'end'
) AS b 
    USING (machine_id, process_id)
WHERE a.timestamp is not NULL AND b.timestamp is not NULL 
GROUP BY machine_id;
-- Answer 2
SELECT machine_id,
    ROUND(SUM(IF(activity_type = 'start', -timestamp, timestamp))/COUNT(*)*2,3) AS processing_time
FROM Activity
GROUP BY machine_id;

# 577 Employee Bonus
SELECT name, bonus
FROM Employee
LEFT JOIN Bonus USING (empId)
WHERE bonus < 1000 or bonus is NULL;

# 1280 Students and Examinations
SELECT student_id, student_name, subject_name,
    IF(attended_exams is NULL, 0, attended_exams) AS attended_exams
FROM Students
CROSS JOIN Subjects
LEFT JOIN (
    SELECT student_id, subject_name, COUNT(*) AS attended_exams
    FROM Examinations
    GROUP BY subject_name, student_id
) AS exam_count USING (student_id, subject_name)
ORDER BY student_id, subject_name;

# 570 Managers with at Least 5 Direct Reports
SELECT name 
FROM Employee
WHERE id IN (
    SELECT IF(COUNT(DISTINCT id)>=5 AND managerId IS NOT NULL, managerId, NULL) AS manager 
FROM Employee
GROUP BY managerId
) ;

# 1934 Confirmation Rate
# Aggregate functions cannot include conditional expressions inside their parentheses.
SELECT s.user_id,
    IF(action IS NULL, 0, ROUND(SUM(IF(action = 'confirmed',1,0))/COUNT(action),2)) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c USING (user_id)
GROUP BY user_id;

