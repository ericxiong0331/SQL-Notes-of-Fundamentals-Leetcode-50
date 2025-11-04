# MySQL Numeric Functions
-- ROUND(5.15, 1)
-- TRUNCATE(5.1524, 3)
-- CEILING(5.1)
-- FLOOR(5.1)
-- ABS(-5.1)
-- RAND()
# Numeric functions perform rounding, truncation, absolute value, and random number generation.

# MySQL String Functions
-- LENGTH(str)
-- UPPER(str) / LOWER(str)
-- LTRIM(str) / RTRIM(str) / TRIM(str)
# Remove spaces on the left, right, or both sides of a string.
-- LEFT(str, len) / RIGHT(str, len)
# Return the first or last len characters of a string.
-- SUBSTRING(str, start, len)
# Extract len characters starting at position start; if len is omitted, returns from start to the end.
-- LOCATE(str1, str2)
# Find the position of the first occurrence of str1 in str2; returns 0 if not found.
-- REPLACE(str0, str1, str2)
# Replace occurrences of str1 with str2 in str0.
-- CONCAT(str1, str2, ...)
# Concatenate multiple strings into one.

# MySQL Datetime Functions
-- NOW() / CURDATE() / CURTIME()
# Return current datetime / date / time respectively.
-- YEAR() / MONTH() / DAY() / HOUR() / MINUTE() / SECOND()
# Extract integer values from a date or datetime.
-- DAYNAME() / MONTHNAME()
# Return the weekday or month name (string) from a date or datetime.

# Example 7.3
-- SELECT EXTRACT(YEAR FROM NOW())
# You cannot write EXTRACT(YEAR(NOW())).

# MySQL Date Format Functions
-- DATE_FORMAT('2025-01-30', '%m/%d/%Y')
-- TIME_FORMAT(NOW(), '%H:%i %p')
# The format specifiers in FORMAT are case-sensitive.

# Date and Time Calculations
-- DATE_ADD(NOW(), INTERVAL 1 YEAR)
# Add a time interval to a date.
-- DATE_SUB(NOW(), INTERVAL -1 YEAR)
# Equivalent to adding the same interval.
-- DATEDIFF(date1, date2)
# Returns the number of days between two dates (date1 - date2); ignores time.
-- TIME_TO_SEC(time)
# Converts a time value to seconds since midnight; differences can be used to compute time gaps.

# IFNULL() and COALESCE() Functions
# Both handle NULL values by replacing them with a specified alternative.
-- USE sql_store;
-- SELECT order_id, IFNULL(shipper_id, 'Not Assigned') AS shipper
# IFNULL() directly replaces NULL with the second argument.
-- SELECT order_id, COALESCE(shipper_id, comments, 'Not Assigned') 
-- FROM orders
# COALESCE() returns the first non-NULL value among the arguments; if all are NULL, returns the last one.

# IF() Function as a UNION Alternative
-- IF(condition, output1, output2)
# If the condition is TRUE, returns output1; otherwise, returns output2.

# CASE Operator
-- column1, CASE
--     WHEN condition1 THEN output1
--     WHEN condition2 THEN output2
--     WHEN condition3 THEN output3
--     ELSE output4
-- END AS column2
-- FROM table
# The CASE operator allows conditional logic inside SQL queries.