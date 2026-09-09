# Technical Challenge - Senior Analytics Engineer (Data Platform Design)

# Ingestion, dbt Transformation & Analytics for eCommerce

## Context

This challenge simulates a real-world scenario in which a company wants to turn raw
operational data into clean, reliable, business-ready data for reporting and analytics.

This is a **design-and-build** challenge focused on the analytics engineering lifecycle:
getting raw data in, modeling it into something a warehouse and a BI tool can trust, and
proving it out with a reporting layer. We are **not** asking you to design orchestration
infrastructure or a CI/CD deployment pipeline — we want to see how you **ingest data**,
**model and transform it with dbt**, and **turn it into insight**.

The target platform for this challenge is fixed:

| Layer | Technology |
|---|---|
| Source systems | A mix of CSV and JSON files (see [`analytics_engineer_assets/`](./analytics_engineer_assets)) |
| Ingestion | Your choice — a Python/dbt-seed loader, a notebook, whatever gets the data into DuckDB cleanly |
| Data warehouse | [DuckDB](./analytics_engineer_assets/README.md#what-is-duckdb) |
| SQL dialect | DuckDB SQL |
| Transformation | dbt models |
| BI / reporting layer | Your choice of free tool (Metabase, Looker Studio, Tableau Public, Power BI Desktop, Evidence, a Python/Jupyter notebook, etc.) |

## Objectives

Produce a working (or near-working) analytics pipeline and a design that a team could
realistically build on. Specifically:

1. **Ingestion** — load the raw source data (see below) into your target warehouse. Describe
   how you'd get each source in (batch load, API call, file drop) and how you'd handle it
   going forward — a full refresh is fine for this exercise, but say what you'd change for an
   incremental/production setup.
2. **Transformation with dbt** — model the raw data into a clean, well-organized warehouse
   using **dbt**. You decide the architecture (staging → intermediate → marts, star schema,
   snowflake schema, wide denormalized marts, etc.) — we want to see **a good, defensible
   warehouse design**, not a specific schema shape. Whatever you choose, be explicit about
   your reasoning: grain, keys, how facts and dimensions (or their equivalent) relate, and how
   currency normalization and data-quality issues are handled. Use dbt tests (`unique`,
   `not_null`, relationships, and any custom tests you find useful) to enforce the
   assumptions your model relies on.
3. **Analytics & BI layer** — build the final, business-ready tables/views your dbt project
   produces, and use them to answer the business questions below. Visualize the answers —
   this can be a BI tool dashboard (Looker, Power BI, Tableau, Metabase, Looker Studio, etc.)
   connected to your final tables, or static charts/images generated from them (e.g. via
   Python/Jupyter) if standing up a BI tool isn't practical for you.

## Deliverable Assets

- A **dbt project** (or equivalent transformation project) with your models, sources,
  tests, and a `README`/`docs` explaining the layering and key design decisions.
- The persisted **`warehouse.duckdb`** file produced by running your pipeline — i.e. the
  actual DuckDB database with your raw/staging/marts objects materialized in it, not just the
  code that builds it. This lets us open it directly and inspect/query your final tables (see
  the [assets README](./analytics_engineer_assets/README.md) for a DuckDB primer).
- A short **`design_notes.md`** — your architecture choices and rationale: how you structured
  the models (and why), grain and key decisions, how you handled currency normalization and
  data-quality issues, and what you'd do differently for an incremental/production version.
- A **model lineage / architecture diagram** (`dbt docs generate` DAG screenshot, or a diagram
  from Figma, Lucidchart, draw.io, Miro, etc. — an image or PDF is fine).
- **Dashboard(s) or chart(s)** (screenshots, an exported PDF, or a link to a live dashboard)
  answering the two business questions, built on your dbt-produced final tables.

> We are looking for clear analytics-engineering judgment — sound dbt modeling, thoughtful
> handling of messy real-world data, and a reporting layer that actually answers the business
> questions — **not** a production-grade orchestration or deployment setup.

## Business Case

The company runs an eCommerce platform and wants data-driven insight to guide strategic
decisions. Management would like to answer:

- Which products are the top performers in terms of **sales volume and revenue**?
- What is the **optimal time of day** to run sales promotions, based on historical
  transaction patterns?

## Available Data Sources

To keep this self-contained, the **raw source data** is provided as flat files in the
[`analytics_engineer_assets/`](./analytics_engineer_assets) folder — a mix of CSV and JSON,
the shape you'd realistically be handed to ingest:

1. **Sales data (CSV)** — `customers.csv`, `orders.csv`, `order_items.csv`.
2. **Product catalogue (JSON)** — `products.json`.
3. **Currency-conversion API sample (JSON)** — `fx_rates.json`, example responses giving the
   conversion rate between a `date`, `currency_from` and `currency_to`, so revenue can be
   normalized to a single reporting currency.

This is real-world operational data and reflects the kinds of inconsistencies you'd meet in
production — including invalid currency codes and order line items that reference products
outside the catalogue (see the [assets README](./analytics_engineer_assets/README.md) for
details). Part of the exercise is showing how your models **detect, handle and document
data-quality issues** (via dbt tests and/or explicit cleaning logic) rather than silently
propagating them. You may make reasonable assumptions about columns, volumes and update
frequency — note them in `design_notes.md`.

## Time constraint

Please keep your effort to **around 4–5 hours**. Favor a clean, well-reasoned, working dbt
project over exhaustive polish. If you run out of time, prioritize the ingestion, the dbt
staging/marts layers and the business-question answers, and note what you would do next.

## Evaluation Criteria

We will assess your submission on:

- **Data modeling & dbt architecture** — clarity and soundness of the layering (staging →
  marts or equivalent), grain, keys, and how well the model supports both business questions.
- **dbt project quality** — model organization, use of `ref`/`source`, tests, documentation,
  and general project hygiene.
- **Ingestion approach** — how sensibly the raw sources were loaded, and clear thinking about
  what would change for an incremental/production setup.
- **Data-quality & currency handling** — how inconsistencies in the source data are detected,
  handled and documented; correctness of currency normalization.
- **Analytics & BI** — how well the dashboard/charts answer the two business questions, and
  the quality of the final tables/views they're built on.
- **Communication** — clarity of `design_notes.md`, the lineage/architecture diagram,
  assumptions and tradeoffs.

_Nice to have (not required): incremental dbt models (`is_incremental()`), a semantic
layer/metrics definition, exposure documentation, or notes on how you'd orchestrate and
deploy this in production._

## How to Submit

1. Create a repository (or a document/slide deck) containing your deliverables.
2. Organize your work clearly (dbt project, `warehouse.duckdb`, `design_notes.md`, diagram,
   dashboard/charts).
3. Share the repository URL or the documents with us.
