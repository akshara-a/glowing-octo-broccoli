VIEWS-
A SQL View is a virtual table created from the result of a SELECT query. It does not store data physically but displays data stored in underlying tables. 
Views help simplify complex queries, enhance security, and present data in a cleaner, customized format.
Example: First, we will create a demo SQL database and table, on which we will use the TRUNCATE TABLE command.


Types  of views
Simple View – Based on a single table.

Complex View – Based on multiple tables using joins.

Materialized View – Stores the query result physically and refreshes on schedule.

Inline View – A subquery in the FROM clause.

Partitioned View – Combines multiple tables using partitioning.

System View – Provided by the database (Metadata views).



DIFFRENCE BETWEEN VIEWS AND MATERIALIZED VIEWS

Feature               View                            Materialized View
Definition	      A virtual table based on a SQL query.  	A physical table that stores the query result.
Storage         	No storage (only stores the query).     Consumes storage because data is saved.
Data Freshness   Always shows latest (real-time) datafrom base tables.	Shows old (snapshot) data until refreshed.
Performance	     Slower for large data because query runs every time.	Faster because results are precomputed and stored.
Refresh	         No refresh needed (always live).	        Needs manual or automatic refresh (ON COMMIT / ON DEMAND).
Use Cases	       Good when data changes frequently and needs up-to-date results.	Good for complex queries, heavy joins, reports, analytics.
Triggers	       Cannot have indexes or triggers.	        Can have indexes, constraints, triggers.
Dependency	Strong dependency—if base table changes, view shows it immediately.	Weak dependency—data stays same until refresh occurs.




DIFFERENCE BETWEEN VIEWS AND TABLE-

Feature              	Table                                                      	View
Definition	    A table is a physical database object that stores data permanently.	A view is a virtual table created from a SQL query.
Storage	        Occupies physical storage on disk.                                	No physical storage (except definition of the query).
Data          	Contains actual data.	Contains no datA                              displays data from tables.
Modification	  Supports INSERT, UPDATE, DELETE operations.	                        Usually read-only, though updatable views exist with conditions.
Performance	    Faster because data is stored physically.	                          Slower because query runs every time the view is accessed.
Definition Stored As	Stores data definitions and actual data.                    	Stores only SQL query (SELECT statement).
Usage	Used      to store and manage persistent data.	                              Used to simplify complex queries, security, and abstraction.
Indexes	        Tables can have indexes, primary keys, constraints.	                Views cannot have indexes or constraints (except materialized views).
Dependency    	Independent object.	                                                Depends on underlying table(s).

