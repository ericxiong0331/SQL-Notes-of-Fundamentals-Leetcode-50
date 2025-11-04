# Use the database
-- USE sql_store;

# Select output columns
-- SELECT *
# The asterisk (*) means selecting all columns.

-- SELECT *, points * 2 AS score
# You CANNOT use a comma after the asterisk (*).
# AS is used to rename or create an alias for a column.

# Specify the source table
-- FROM customers

# Limit the output by rows
-- LIMIT m
# m represents the number of rows to return from the top.

-- LIMIT m, n
# m, n represent returning n rows starting from the (m + 1)-th row.

# Add output conditions
-- WHERE first_name LIKE '%R'
# LIKE matches text patterns in each row of the given column.
# % means any sequence of characters (including blank) before or after the specified pattern.

-- WHERE first_name REGEXP 'ELKA|AMBUR'
# REGEXP is for regular expression matching.
# The vertical bar (|) means “OR”.

-- WHERE last_name REGEXP 'EY$|ON$'
# The dollar sign ($) means the string ends with the given characters.

-- WHERE last_name REGEXP '^MY|SE'
# The caret (^) means the string starts with the given characters.

-- WHERE last_name REGEXP 'B[RU]'
# Square brackets [ ] match any single character from the given set.

-- WHERE first_name IS NOT NULL
# Filters rows where the value in first_name is not NULL.

# Order the output
-- ORDER BY state DESC, first_name DESC
# Sorts results by state in descending order, then by first_name in descending order.

-- ORDER BY n
# n represents the position of a column in the SELECT clause.
