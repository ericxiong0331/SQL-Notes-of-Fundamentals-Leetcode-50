# Subqueries
# Subqueries can appear not only in WHERE clauses but also in SELECT and FROM clauses.

# The ALL keyword
# Used to check if a condition holds true for all values returned by the subquery.

# The ANY keyword
# Equivalent to using the IN operator; checks if a condition holds true for any of the subquery results.

# Correlated subqueries
# A correlated subquery refers to the outer query's table.
# It retrieves data that is related to each row of the main query, allowing for contextual filtering.

# The EXISTS keyword
# The WHERE EXISTS (subquery) condition checks whether the subquery returns any rows.
# It can significantly reduce query complexity by limiting the number of outer queries executed.

# Using subqueries inside SELECT
-- SELECT a, b,
--     (SELECT AVG(c) FROM table) AS d,
--     b - (SELECT d) AS e 
-- FROM table 
# The subquery result is treated as a column in the main SELECT clause.

# Using subqueries inside FROM
-- SELECT * 
-- FROM (subquery) AS name 
-- WHERE condition
# The AS name part assigns an alias (a temporary name) to the subquery.
# This alias acts as a virtual table (view) within the current query.
