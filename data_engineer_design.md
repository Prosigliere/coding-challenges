# Technical Challenge - Senior Data Engineer (Data Platform Design)

# Data Warehouse & Pipeline Design for eCommerce Analytics

## Context

This challenge simulates a real-world scenario in which a company wants to turn raw
operational data into clean, reliable, business-ready data for reporting and analytics.

This is a **design-focused** challenge. We are **not** asking you to build and run a full
pipeline. We want to see how you would **architect** the platform and how you reason about
the key technical decisions, backed by representative SQL where it helps make your design
concrete.

The target platform is defined by the **Target Stack** table below — fill it in for the
position you are interviewing for.

| Layer | Technology (filled in per position) |
|---|---|
| Source systems | e.g. SQL Server / Postgres operational DBs |
| Orchestration & ingestion | e.g. Airflow / ADF / Cloud Composer / Dataflow |
| Data warehouse | e.g. Snowflake / BigQuery / Azure SQL MI |
| SQL dialect | e.g. Snowflake SQL / GoogleSQL / T-SQL |
| Transformation approach | e.g. dbt / stored procedures / views |
| DevOps / IaC & CI-CD | e.g. dbt + GitHub Actions / Terraform + Cloud Build / DacFx-DACPAC + GitHub Actions |
| BI / reporting layer | e.g. Looker / Tableau / Power BI |

Filling in that table is the **only** per-position edit to this challenge. For reference,
here is how it would look for three different roles:

**Example — Azure / SQL Server role**

| Layer | Technology |
|---|---|
| Source systems | SQL Server operational databases |
| Orchestration & ingestion | Azure Data Factory (ADF) |
| Data warehouse | Azure SQL Managed Instance (`ingestion` / `transformation` / `reporting` schemas) |
| SQL dialect | T-SQL |
| Transformation approach | Views, stored procedures and functions |
| DevOps / IaC & CI-CD | DacFx / SQL database project (`Microsoft.Build.Sql`) → DACPAC, deployed via GitHub Actions |
| BI / reporting layer | Tableau |

**Example — GCP / BigQuery / Looker role**

| Layer | Technology |
|---|---|
| Source systems | Postgres (Cloud SQL) operational databases |
| Orchestration & ingestion | Cloud Composer (Airflow) + Dataflow / Datastream |
| Data warehouse | BigQuery (raw / staging / marts datasets) |
| SQL dialect | GoogleSQL |
| Transformation approach | dbt models |
| DevOps / IaC & CI-CD | Terraform + dbt, deployed via Cloud Build |
| BI / reporting layer | Looker |

**Example — Airflow / Snowflake role**

| Layer | Technology |
|---|---|
| Source systems | Postgres / MySQL operational databases |
| Orchestration & ingestion | Apache Airflow (+ Fivetran or custom extractors) |
| Data warehouse | Snowflake (RAW / STAGING / MARTS schemas) |
| SQL dialect | Snowflake SQL |
| Transformation approach | dbt models (with Snowflake streams/tasks where useful) |
| DevOps / IaC & CI-CD | dbt + GitHub Actions (Terraform for warehouse objects) |
| BI / reporting layer | Power BI |

## Objectives

Produce a design that a team could realistically implement. Specifically:

1. **Architecture** — a high-level architecture (diagram + narrative) showing how data flows
   from the source systems through your orchestration/ingestion tool into the warehouse and
   out to the reporting/BI layer.
2. **Dimensional model** — design a star-schema warehouse that answers the business
   questions below. Provide the model (diagram) and representative `CREATE TABLE` **DDL in
   the SQL dialect of your target warehouse** for the key fact and dimension tables (data
   types, keys, constraints).
3. **Ingestion & transformation strategy** — describe how data would be loaded, including an
   **incremental/delta** approach driven by change tracking (temporal tables / CDC / an
   `updated_at` watermark, depending on your stack) and when you'd fall back to a **full bulk
   refresh**. Show representative SQL (a transformation view/model or stored procedure, and a
   watermark/merge pattern) to illustrate the transformation layer.
4. **DevOps / CI-CD** — describe how the warehouse would be delivered as code (IaC / a SQL or
   dbt project) and deployed through a CI/CD pipeline for your chosen stack. A sketch of the
   workflow and folder layout is enough; you do not need a runnable pipeline.

## Deliverable Assets

- **`design_process.md`** — the heart of the submission: architecture overview, the
  dimensional model, ingestion/transformation strategy, DevOps approach, and the answers to
  the business questions. Include your rationale, assumptions and tradeoffs.
- An **architecture diagram** and a **dimensional-model diagram** (Figma, Lucidchart,
  draw.io, PowerPoint, Miro, etc. — an image or PDF is fine).
- A **`.sql` (or dbt model) file** with representative DDL **in your target warehouse's
  dialect**: the warehouse schema (fact/dimension tables), at least one transformation object
  (view, model or stored procedure), and an incremental-load pattern.
- A short **BI mockup** (sketch or wireframe) showing how you'd visualize the answers to the
  two business questions.

> We are looking for clear design thinking and solid SQL / dimensional-modeling
> fundamentals — **not** a fully implemented, deployable system.

## Business Case

The company runs an eCommerce platform and wants data-driven insight to guide strategic
decisions. Management would like to answer:

- Which products are the top performers in terms of **sales volume and revenue**?
- What is the **optimal time of day** to run sales promotions, based on historical
  transaction patterns?

## Available Data Sources

To keep this self-contained, the **raw source data** is provided in the
[`data_engineer_assets/`](./data_engineer_assets) folder. You do **not** need to stand up any
infrastructure — treat these as the shape and content of the upstream operational source
databases (provided here in T-SQL as a concrete reference — the shape/content is what
matters, not the dialect):

1. **Sales database** — `customers`, `orders`, `order_items`
   (see `source_sales.sql`).
2. **Product database** — `product_descriptions`
   (see `source_products.sql`).
3. **Currency-conversion API** — accepts `date`, `currency_from`, `currency_to` and returns
   the conversion rate, so revenue can be normalized to a single reporting currency
   (sample responses are in `sample_fx_rates.json`).

The provided DDL includes change-tracking columns / temporal tables so you can design your
incremental strategy against a realistic source; adapt the mechanism to your target stack
(CDC, streams, watermark, etc.). This is real-world operational data and reflects the kinds
of inconsistencies you'd meet in production — part of the exercise is showing how your design
**detects, handles and reports on data-quality issues** rather than silently propagating
them. You may make reasonable assumptions about columns, volumes and update frequency.

## Time constraint

Please keep your effort to **around 4–5 hours**. This is a design exercise — favor clear,
well-reasoned decisions over exhaustive detail. If you run out of time, prioritize the
architecture, the dimensional model and the ingestion strategy, and note what you would do
next.

## Evaluation Criteria

We will assess your submission on:

- **Dimensional modeling & schema design** — star schema, grain, keys/constraints, data
  types, support for both business questions.
- **SQL quality** — correctness and clarity of the representative DDL and transformation
  logic in the chosen dialect.
- **Ingestion & transformation strategy** — sound use of your orchestration/ingestion tool,
  incremental/delta loading (change tracking / CDC / watermark) vs. full refresh, currency
  normalization, data-quality thinking.
- **DevOps / CI-CD design** — coherent IaC/CI-CD approach for the chosen warehouse and
  schema/layer organization (ingestion / transformation / reporting).
- **Architecture & communication** — clarity of diagrams, `design_process.md`, assumptions
  and tradeoffs.
- **BI mockup** — how well the visualization answers the two business questions.

_Nice to have (not required): experience notes on the specifics of your target warehouse and
deploy tooling (e.g. managed-instance internals, federated/OIDC least-privilege deploy
identities, your BI tool of choice, or legacy-platform migration considerations)._

## How to Submit

1. Create a repository (or a document/slide deck) containing your deliverables.
2. Organize your work clearly (`design_process.md`, diagrams, `.sql` file, BI mockup).
3. Share the repository URL or the documents with us.
