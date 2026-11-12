# ShopSphere Advanced SQL Assignment — Answer Files

This folder contains PostgreSQL solutions for the ShopSphere e-commerce database assignment.

## Files

| File | Contents |
|---|---|
| `01_schema.sql` | Database tables, primary keys, foreign keys and constraints |
| `02_sample_data.sql` | Sample INSERT statements (22 customers, 11 categories, 32 products, 42 orders, 100+ order items, 36 payments, 27 reviews) |
| `03_queries.sql` | Query answers and demonstrations |
| `04_views.sql` | Normal views and updatable-view example |
| `05_materialized_views.sql` | Monthly and executive dashboard materialized views |
| `06_indexes.sql` | Indexes, EXPLAIN ANALYZE and index discussion |
| `07_procedures.sql` | Stored procedures for stock, cancellation, payment and delayed orders |
| `08_functions.sql` | Four user-defined functions and usage examples |
| `09_ctes.sql` | CTE and recursive CTE answers |

## Run order

1. Create the database in PostgreSQL:
   ```sql
   CREATE DATABASE shopsphere_db;
   ```
2. Connect to `shopsphere_db`.
3. Run `01_schema.sql`.
4. Run `02_sample_data.sql`.
5. Run `04_views.sql`, `05_materialized_views.sql`, `06_indexes.sql`, `07_procedures.sql`, `08_functions.sql`, and `09_ctes.sql`.
6. Run `03_queries.sql` for the query exercises. Some statements create objects already created by the dedicated files; run only one copy if PostgreSQL reports an object already exists.

## Important notes

- The assignment asks for 120 numbered queries, followed by case studies and documentation. The answers use PostgreSQL syntax.
- Query 73 requires adding `Delayed` to the `orders.order_status` CHECK constraint before running the procedure. The provided procedure assumes that extension.
- Query 57 demonstrates that a simple single-table view can be updatable, while the grouped/joined summary view is not automatically updatable.
- Materialized views do not update automatically. Run `REFRESH MATERIALIZED VIEW`.
- `EXPLAIN ANALYZE` timings depend on the local database size, hardware, cache and PostgreSQL version. A small sample database may use a sequential scan even when an index exists.
- The sample rows are synthetic practice data. Query results depend on the sample data and current date.
- For transaction task 102, use a fresh transaction reference if you execute it more than once. The order item insert and stock update should be checked together in a production-grade transaction.
