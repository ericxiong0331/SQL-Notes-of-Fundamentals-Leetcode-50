# Window Functions
# A window is a set of rows, and a window function performs calculations across that set.
# The key difference between aggregate and window functions:
# Aggregate: many-to-one → returns one result per group.
# Window: many-to-many → returns one result per row while keeping group structure.

-- FUNCTION() OVER()
# By default, applies FUNCTION to rows that satisfy the WHERE condition.

-- FUNCTION() OVER(PARTITION BY <columns> ORDER BY <columns> ROWS BETWEEN <range>)
# PARTITION BY = similar to GROUP BY.
# ROWS BETWEEN defines the range for calculation:
# <adj> PRECEDING AND CURRENT ROW AND <adj> FOLLOWING.
# <adj> can be a number or UNBOUNDED.

# Default behavior:
# If ORDER BY is NULL and ROWS BETWEEN is NULL → defaults to UNBOUNDED PRECEDING AND CURRENT ROW.
# If ORDER BY is NOT NULL and ROWS BETWEEN is NULL → defaults to UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING.

# Specialized Window Functions (aggregate functions can also be used)
-- RANK()
# Assigns rank with gaps (e.g., 1, 2, 2, 4).
-- DENSE_RANK()
# Assigns rank without gaps (e.g., 1, 2, 2, 3).
-- ROW_NUMBER()
# Assigns a unique row number to each record in the partition.

# Indexes
# Indexes improve query performance by allowing faster data retrieval.
# However, updates and insertions must also update indexes, adding overhead.
# Internally, indexes are usually implemented as B-trees.
# A table can have multiple indexes on different columns.

-- EXPLAIN SELECT <query>;
# Displays how MySQL executes a query and whether indexes are used.

-- ANALYZE TABLE <table>;
# Shows index statistics such as unique key counts.

# For an index to be effective (“covering index”):
# It must include all columns used in SELECT, WHERE, and ORDER BY.

# Before creating a new index, check for:
# 1. Duplicate indexes (e.g., AB and AB)
# 2. Redundant indexes (e.g., AB covers A)

# Creating an Index
-- CREATE INDEX idx_points ON customers (points);

# Viewing Indexes
-- SHOW INDEXES IN <table>;
# Clustered index vs secondary index:
# A secondary index includes the clustered index’s key values.

# Prefix Index
-- CREATE INDEX <idx_name> ON <table>(column(length));
# Choose an optimal prefix length to balance performance and memory usage.

# Full-Text Index
-- CREATE INDEX <idx_name> ON <table>(column);
-- SELECT *, MATCH(column) AGAINST('word1 word2')
-- FROM <table>;
-- WHERE MATCH(column) AGAINST('word1 word2')
# Natural language mode.

-- WHERE MATCH(column) AGAINST('"phrase" word1 +word2 -word3' IN BOOLEAN MODE)
# Boolean mode:
# +word → must include; 
# -word → must not include; 
# "phrase" → exact phrase match.

# Composite Index
# Used when queries filter by multiple columns.
# Only one index is chosen per query, so multiple conditions can reduce efficiency.

-- CREATE INDEX <idx_name> ON <table>(column1, column2);
# Column order in a composite index matters:
# Priority: (1) Most common in queries, (2) High cardinality first, (3) Query pattern relevance.
# If filtering only by the second column, a single-column index may be needed.

# Deleting an Index
-- DROP INDEX <idx_name> ON <table>;

# Forcing Index Usage
-- SELECT <columns> FROM <table>
-- USE INDEX (<idx_name>)
-- WHERE <conditions>;

# Avoiding Inefficient Index Use
# 1. When WHERE uses OR with multiple conditions, MySQL can use only one index.
#    Solution: split queries with UNION to leverage multiple indexes.
# 2. In WHERE conditions, the indexed column must appear standalone on one side.
#    Expressions or functions around indexed columns will disable index usage.

# Viewing Server Variables
-- SHOW STATUS;

# Using Indexes for Sorting
# 1. Create indexes that match the ORDER BY columns and order.
#    Even if the row count scanned is the same, index traversal reduces memory use.
# 2. Sorting direction (ASC/DESC) must be consistent with the index order.
#    Mixed directions (ASC + DESC) disable index optimization.
