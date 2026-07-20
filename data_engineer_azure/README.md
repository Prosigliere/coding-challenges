# Raw source data (Azure Senior DE challenge)

These files describe the **upstream SQL Server operational databases** for the
[Senior Data Engineer (Azure / SQL Server) challenge](../data_engineer_azure.md).

You do **not** need to run these — they define the *shape* and provide *sample content* of
the source systems so you have something concrete to model your warehouse against. If you
want to load them locally, they run on any SQL Server 2016+ instance (including the free
`mcr.microsoft.com/mssql/server` container), but that is entirely optional for this
design-only challenge.

| File | Source system | Contents |
|---|---|---|
| `source_sales.sql`    | Sales DB    | `customers`, `orders`, `order_items` (orders is a system-versioned **temporal table**) + sample rows |
| `source_products.sql` | Product DB  | `product_descriptions` (temporal table) + sample rows |
| `sample_fx_rates.json`| Currency API | Example responses from the currency-conversion API |

## Notes for candidates

- `orders.order_ts` is a full timestamp — the **time-of-day** component is what powers the
  "optimal promotion time" question.
- Orders carry a `currency` code; normalize revenue to a single reporting currency using the
  FX rates.
- The temporal tables (`SYSTEM_VERSIONING = ON`) exist so you can design an
  **incremental/delta** load driven by row versioning / a watermark, and contrast it with a
  **full bulk refresh**.
- Sample data is intentionally small; assume production volumes (millions of orders) when
  reasoning about performance, indexing and partitioning.
