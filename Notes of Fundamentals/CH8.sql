# Creating Views
-- CREATE VIEW sales_by_client AS
-- CREATE TABLE sales_by_client AS
# CREATE TABLE creates a new physical table, while CREATE VIEW creates a logical view.
# A view does not store actual data but behaves like a table in queries.

# Deleting or Modifying a View
-- DROP VIEW sales_by_client
-- CREATE OR REPLACE VIEW sales_by_client AS
# When a view is saved, MySQL automatically generates the corresponding SQL code.
# Keeping the original source definition is better for transparency and open-source control.

# Updatable Views
# A view can be updatable only if it does NOT contain:
# DISTINCT, aggregate functions, GROUP BY, HAVING, or UNION clauses.
# Updatable views are useful when users lack direct permission to modify the underlying table.
# The view must include all columns from the base table involved in the update.

# WITH CHECK OPTION
# Adding WITH CHECK OPTION at the end of a CREATE VIEW statement prevents:
# 1. Deleting rows directly through the view.
# 2. Updates that would cause rows to fall outside the view's filter condition.

# Three Key Advantages of Views
# 1. Simplify complex queries.
# 2. Reduce query maintenance when base tables change (only update the view definition).
# 3. Restrict access to base tables, improving data security.