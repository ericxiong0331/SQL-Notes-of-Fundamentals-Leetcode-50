# Aggregate functions
-- MAX(), MIN(), AVG(), SUM(), COUNT()
# Aggregate functions do not include NULL values in their calculations.
# COUNT(*) represents the total number of rows.
# COUNT(DISTINCT a) is equivalent to pandas' unique().count() or nunique().

# GROUP BY clause
-- SELECT client_id,
    -- SUM(invoice_total) AS total_sales
-- FROM invoices
-- WHERE conditions
-- GROUP BY columns
-- ORDER BY columns
# You can group by multiple columns.
# You can also perform GROUP BY after a JOIN clause, for example:
# FROM table1 JOIN table2 USING (column).

# HAVING clause
# Used after GROUP BY to filter grouped data, since WHERE cannot filter aggregated results.
-- SELECT columns, aggregate_functions
-- FROM table
-- GROUP BY columns
-- HAVING conditions

# ROLLUP function (MySQL only)
-- GROUP BY columns WITH ROLLUP
# For multi-column grouping, ROLLUP displays subtotals and totals in reverse order (from last to first column).

# Exercise 5-4
-- USE sql_invoicing;
-- SELECT name AS payment_method, SUM(amount) AS total
-- FROM payments p
-- LEFT JOIN payment_methods pm
	-- ON p.payment_method = pm.payment_method_id
-- GROUP BY name WITH ROLLUP
# This query groups payment data by payment method and shows subtotals using ROLLUP.
