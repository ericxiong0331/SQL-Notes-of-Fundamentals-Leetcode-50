-- USE sql_store;

-- Insert a single row
-- INSERT INTO customers 
# You can optionally specify column names after the table name.
-- VALUES (
    -- DEFAULT, 
	-- 'Eric',
	-- 'Xiong',
	-- '2003-03-01',
	-- NULL,
	-- 'address',
	-- 'city',
	-- 'DC',
	-- DEFAULT
-- )

-- Insert multiple rows
-- INSERT INTO customers (name)
-- VALUES (a), (b), (c)
# Use commas to separate multiple value groups in one statement.

-- Insert hierarchical rows
-- INSERT INTO customers
-- VALUES (...)
-- INSERT INTO orders
-- VALUES 
    -- (LAST_INSERT_ID(), a, b, c),
    -- (LAST_INSERT_ID(), d, e, f)
# The LAST_INSERT_ID() function retrieves the primary key of the most recently inserted row.

-- Copy a table
-- CREATE TABLE orders_archived AS
-- SELECT * FROM orders
# Note: Primary keys and auto-increment attributes are not copied.
# You can also use the INSERT-SELECT clause to filter and insert specific rows into the new table.

-- Update a single row
-- USE sql_invoicing;
-- UPDATE invoices
-- SET payment_total = 10
-- WHERE invoice_id = 1
# In MySQL safe mode, only one record can be updated at a time.
# To update multiple records, disable Safe Update mode and adjust the WHERE condition.

-- Use a subquery in an UPDATE statement
-- UPDATE invoices
-- SET payment_total = 10
-- WHERE client_id = (
	-- SELECT client_id
	-- FROM clients
	-- WHERE name = 'Myworks'
-- )
# When the subquery returns multiple rows, replace "=" with "IN".
# Before executing the UPDATE, use SELECT to verify which rows will be changed.

-- Delete rows
-- DELETE FROM invoices
-- WHERE client_id = (
	-- SELECT *
    -- FROM clients
    -- WHERE name = 'Myworks'
-- )
# Deletes rows in invoices where the client matches the given subquery.

-- Restore a database
# Execute the CREATE DATABASE file (SQL script) to restore the database.