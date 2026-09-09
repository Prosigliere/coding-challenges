# Raw source data (Senior Analytics Engineer challenge)

These files are the source data for the
[Senior Analytics Engineer challenge](../analytics_engineer.md). They are the same
canonical eCommerce dataset used by the Data Engineer challenges, exported here as a
**mix of CSV and JSON files** — the shape of source system you'll typically ingest as an
analytics engineer, rather than a live operational database.

| File | Source system | Format | Contents |
|---|---|---|---|
| `customers.csv`     | Sales DB      | CSV  | Customer records |
| `orders.csv`        | Sales DB      | CSV  | Orders (header-level: total, currency, status) |
| `order_items.csv`   | Sales DB      | CSV  | Order line items (product, quantity, unit price) |
| `products.json`     | Product DB    | JSON | Product catalogue (name, category, description, base price) |
| `fx_rates.json`     | Currency API  | JSON | Example currency-conversion API responses |

## What is DuckDB?

[DuckDB](https://duckdb.org/) is an **in-process, embedded analytical database** (think
"SQLite, but column-oriented and built for analytics/OLAP instead of transactional
workloads"). There's no server to stand up or connection string to configure — it runs as a
library inside your process (CLI, Python, Node, etc.) and reads/writes a single database file
directly on disk. That makes it a good fit for this exercise: it gives you a real SQL
warehouse with a real dbt adapter, without any infrastructure to provision.

A few things worth knowing before you start:

- It can query CSV, JSON and Parquet files directly (e.g. `SELECT * FROM
  'customers.csv'`, `read_json_auto('products.json')`) — handy for exploring the raw sources
  or for a simple ingestion step, though how you load the data is up to you.
- Point it at a file path (e.g. `duckdb warehouse.duckdb`) and it persists everything to that
  single file between sessions; point it at `:memory:` (or nothing) and it's ephemeral.
- `dbt-duckdb` is a community-maintained dbt adapter that works like any other dbt target —
  `dbt run` / `dbt test` / `dbt docs generate` all work as expected against a DuckDB file.
- **Installation** — there are several ways to install DuckDB (CLI, Python package, various
  OS package managers, etc.). Pick whichever fits your workflow; the official installation
  page has the current options for your platform:
  [duckdb.org/install](https://duckdb.org/install/?platform=linux&environment=cli)

## Notes for candidates

- `orders.order_date` is a full timestamp — the **time-of-day** component powers the
  "optimal promotion time" question.
- Orders and order items carry a `currency` code; normalize revenue to a single reporting
  currency (USD) using `fx_rates.json`.
- `id` columns are surrogate keys assigned on export (matching insertion order); there is no
  change-tracking metadata (no CDC, no `updated_at`) — treat this as a **full snapshot** of
  the source. Full refresh is the expected ingestion pattern for this exercise; note in your
  `design_notes.md` what you'd add (a watermark, CDC, an incremental extract) for a
  production, continuously-refreshed version.
- This is **real-world operational data**: it reflects the kinds of inconsistencies you'd
  meet in production, including:
  - Some `currency` values on `orders` and `order_items` are not real ISO currency codes
    (e.g. `XYZ`, `ABC`, `QWE`) — decide how your models should detect and handle these.
  - `order_items.product_id` is **not** a guaranteed foreign key — some line items reference
    product IDs that don't exist in `products.json`. This mirrors the upstream system, which
    doesn't enforce the relationship.
  - Part of the exercise is showing how your dbt models **detect, handle and document** these
    issues (tests, explicit filtering/flagging logic) rather than silently dropping or
    propagating them.
- The sample volume is modest (a few hundred orders); assume production scale (millions of
  orders) when reasoning about performance and incremental design in `design_notes.md`.
