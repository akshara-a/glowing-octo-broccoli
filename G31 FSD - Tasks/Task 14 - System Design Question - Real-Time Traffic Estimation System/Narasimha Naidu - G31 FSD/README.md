# ShopSphere E-Commerce Database

## Project
Advanced SQL Database Assignment using PostgreSQL.

## Files

- `01_schema.sql` - database tables, primary keys, foreign keys and constraints
- `02_sample_data.sql` - sample data
- `03_queries.sql` - assignment queries 1-120
- `04_views.sql` - views and final customer performance report
- `05_materialized_views.sql` - materialized reporting views
- `06_indexes.sql` - indexes and EXPLAIN ANALYZE examples
- `07_procedures.sql` - PostgreSQL stored procedures
- `08_functions.sql` - PostgreSQL functions
- `09_ctes.sql` - CTE and recursive CTE examples

## Software

PostgreSQL + pgAdmin 4.

## Execution Order

1. Create database `shopsphere_db`.
2. Connect to `shopsphere_db`.
3. Run `01_schema.sql`.
4. Run `02_sample_data.sql`.
5. Run `03_queries.sql`.
6. Run `04_views.sql`.
7. Run `05_materialized_views.sql`.
8. Run `06_indexes.sql`.
9. Run `07_procedures.sql`.
10. Run `08_functions.sql`.
11. Run `09_ctes.sql`.

## Important

Some queries are demonstration queries. For example, transaction examples containing
`ROLLBACK` are intentionally rolled back and therefore do not permanently insert data.

The assignment uses PostgreSQL-specific features such as PL/pgSQL procedures,
functions, recursive CTEs and materialized views.
