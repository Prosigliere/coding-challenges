# Technical Challenge - Senior Data Engineer (Azure / SQL Server)

# Azure Data Warehouse & Pipeline Design for eCommerce Analytics

## Context

This challenge simulates a real-world scenario in which a company wants to turn raw
operational data into clean, reliable, business-ready data for reporting and analytics.

This is a **design-focused** challenge. We are **not** asking you to build and run a full
pipeline. We want to see how you would **architect** the platform and how you reason about
the key technical decisions, backed by representative SQL where it helps make your design
concrete.

The target platform mirrors our production stack:

- Source data lives in **SQL Server** operational databases.
- Ingestion and transformation are orchestrated with **Azure Data Factory (ADF)**, using
  **incremental/delta loads** (via SQL Server temporal tables) plus **full bulk-refresh**
  patterns.
- The data warehouse runs on **Azure SQL Managed Instance**, organized into `ingestion`,
  `transformation` and `reporting` schemas with views, stored procedures and functions.
- The warehouse database is managed as code with a **DacFx / SQL database project**
  (`Microsoft.Build.Sql`), built to a **DACPAC** and deployed via **GitHub Actions**.
- The `reporting` layer feeds a BI tool such as **Tableau**.

## Objectives

Produce a design that a team could realistically implement. Specifically:

1. **Architecture** — a high-level architecture (diagram + narrative) showing how data flows
   from the SQL Server sources through ADF into the Azure SQL MI warehouse and out to the
   reporting/BI layer.
2. **Dimensional model** — design a star-schema warehouse that answers the business
   questions below. Provide the model (diagram) and representative `CREATE TABLE` **T-SQL**
   for the key fact and dimension tables (data types, keys, constraints).
3. **Ingestion & transformation strategy** — describe how ADF would load the data, including
   the **incremental/delta approach using temporal tables** and when you'd fall back to a
   **full bulk refresh**. Show representative T-SQL (e.g. a transformation view or stored
   procedure, and a watermark/merge pattern) to illustrate the transformation layer.
4. **DevOps / CI-CD** — describe how the warehouse would be delivered as a DacFx database
   project (schemas → DACPAC) and deployed through GitHub Actions. A sketch of the workflow
   and folder layout is enough; you do not need a runnable pipeline.

## Deliverable Assets

- **`design_process.md`** — the heart of the submission: architecture overview, the
  dimensional model, ingestion/transformation strategy, DevOps approach, and the answers to
  the business questions. Include your rationale, assumptions and tradeoffs.
- An **architecture diagram** and a **dimensional-model diagram** (Figma, Lucidchart,
  draw.io, PowerPoint, Miro, etc. — an image or PDF is fine).
- A **`.sql` file** with representative T-SQL: the warehouse schema (fact/dimension tables)
  and at least one transformation object (view or stored procedure) and an incremental-load
  pattern.
- A short **BI mockup** (sketch or wireframe) showing how you'd visualize the answers to the
  two business questions.

> We are looking for clear design thinking and solid T-SQL / dimensional-modeling
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
infrastructure — treat these as the shape and content of the upstream SQL Server databases:

1. **Sales database (SQL Server)** — `customers`, `orders`, `order_items`
   (see `source_sales.sql`).
2. **Product database (SQL Server)** — `product_descriptions`
   (see `source_products.sql`).
3. **Currency-conversion API** — accepts `date`, `currency_from`, `currency_to` and returns
   the conversion rate, so revenue can be normalized to a single reporting currency
   (sample responses are in `sample_fx_rates.json`).

The provided DDL includes SQL Server **system-versioned temporal tables** so you can design
your incremental/delta strategy against a realistic source. This is real-world operational
data and reflects the kinds of inconsistencies you'd meet in production — part of the
exercise is showing how your design **detects, handles and reports on data-quality issues**
rather than silently propagating them. You may make reasonable assumptions about columns,
volumes and update frequency.

## Time constraint

Please keep your effort to **around 4–5 hours**. This is a design exercise — favor clear,
well-reasoned decisions over exhaustive detail. If you run out of time, prioritize the
architecture, the dimensional model and the ingestion strategy, and note what you would do
next.

## Evaluation Criteria

We will assess your submission on:

- **Dimensional modeling & schema design** — star schema, grain, keys/constraints, data
  types, support for both business questions.
- **T-SQL quality** — correctness and clarity of the representative DDL and transformation
  logic.
- **Ingestion & transformation strategy** — sound use of ADF, incremental/delta loading with
  temporal tables vs. full refresh, currency normalization, data-quality thinking.
- **DevOps / CI-CD design** — coherent DacFx/DACPAC + GitHub Actions approach and schema
  organization (`ingestion` / `transformation` / `reporting`).
- **Architecture & communication** — clarity of diagrams, `design_process.md`, assumptions
  and tradeoffs.
- **BI mockup** — how well the visualization answers the two business questions.

_Nice to have (not required): experience notes on Azure SQL MI specifics, Entra/OIDC deploy
identities, Tableau, or legacy SSIS/SSAS migration considerations._

## How to Submit

1. Create a repository (or a document/slide deck) containing your deliverables.
2. Organize your work clearly (`design_process.md`, diagrams, `.sql` file, BI mockup).
3. Share the repository URL or the documents with us.
