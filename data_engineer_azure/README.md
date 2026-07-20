# Raw source data (Azure Senior DE challenge)

These files are the **upstream SQL Server operational databases** for the
[Senior Data Engineer (Azure / SQL Server) challenge](../data_engineer_azure.md).

This is the canonical challenge dataset (customers/orders/order_items + product
catalogue) ported to T-SQL. You do **not** have to run anything — the files define the
*shape* and *content* of the source systems so you have concrete, realistic data to model
your warehouse and pipeline against. If you want to load them locally they run on any SQL
Server 2016+ instance (including the free `mcr.microsoft.com/mssql/server` container), but
that is entirely optional for this design-only challenge.

| File | Source system | Contents |
|---|---|---|
| `source_sales.sql`    | Sales DB    | `customers`, `orders` (system-versioned **temporal** table), `order_items` |
| `source_products.sql` | Product DB  | `product_descriptions` (temporal table) |
| `sample_fx_rates.json`| Currency API | Example responses from the currency-conversion API |

## Notes for candidates

- `orders.order_date` is a full timestamp — the **time-of-day** component powers the
  "optimal promotion time" question.
- Orders and order items carry a `currency` code; normalize revenue to a single reporting
  currency (USD) using the FX rates.
- The temporal tables (`SYSTEM_VERSIONING = ON`) let you design an **incremental/delta**
  load driven by row versioning / a watermark, and contrast it with a **full bulk refresh**.
- This is **real-world operational data**: it reflects the kinds of inconsistencies you'd
  meet in production. Part of the exercise is deciding how your design detects, handles and
  reports on data-quality problems rather than silently propagating them.
- The sample volume is modest; assume production scale (millions of orders) when reasoning
  about performance, indexing and partitioning.
