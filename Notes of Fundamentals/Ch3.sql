-- Use sql_store;

# Inner Join
-- SELECT order_id, o.customer_id, first_name, last_name
# When selecting columns with the same name from multiple joined tables, prefix them with the corresponding table name.
-- FROM orders o 
-- JOIN customers c
	-- ON o.customer_id = c.customer_id 
    # Merge the customers table into orders based on the matching condition.
    -- USING (customer_id) 
    # The USING clause can replace ON.
    -- USING (customer_id, order_id)

# A space followed by a character after a table name represents an alias; you can use the alias instead of the full table name later.
# You can prefix a table name with the database name to reference tables from other databases, e.g., sql_inventory.products.

-- cross join
# Cross join returns the Cartesian product of all rows; it does not require ON or USING.
-- natural join 
# Natural join automatically joins columns with the same name; it does not require ON or USING.
-- UNION 
# UNION combines the results of multiple queries into a single result set.

-- SELECT statements using UNION to classify customers by points
-- SELECT customer_id, first_name, points, "Bronze" AS 'type'
# Customers with points less than 2000 are classified as Bronze.
-- FROM customers
-- WHERE points < 2000 
-- UNION
-- SELECT customer_id, first_name, points, "Silver" AS 'type'
# Customers with points between 2000 and 3000 are classified as Silver.
-- FROM customers
-- WHERE points BETWEEN 2000 AND 3000 
-- UNION
-- SELECT customer_id, first_name, points, "Gold" AS 'type'
# Customers with points greater than 3000 are classified as Gold.
-- FROM customers
-- WHERE points > 3000
-- ORDER BY first_name