# Technical Challenge - Business Intelligence Analyst

# eCommerce Reporting, Validation & Data Storytelling

## Context

This technical challenge aims to simulate a real-world scenario in which a company seeks to answer critical business questions to support strategic decision-making. It is the "consumer" counterpart to our Data Engineer challenge: where the Data Engineer builds the warehouse and pipeline, the Business Intelligence Analyst owns the reporting and analytics layer that stakeholders actually use to make decisions.

- The organization runs an eCommerce platform and has already invested in a dimensional data warehouse (a star schema modeled by the data engineering team).
- As the BI Analyst, you **consume** that modeled data. You do **not** build or run the ingestion pipeline — that boundary belongs to data engineering. Your job starts where the clean, modeled tables end.
- You translate stakeholder questions into reporting requirements, build the dashboards decision-makers rely on, and stand behind the numbers you publish.
- Trust is part of the deliverable: a report is only useful if the people reading it can safely act on it.

## Objectives

Your task is to:

1. Build a business-facing, multi-view **dashboard** that answers the two business questions below with clear data storytelling.
2. Establish **report quality and validation**: define your metrics precisely, set validation thresholds and acceptance criteria, and reconcile at least one KPI total back to the raw source data.

Keep the scope focused — these two pillars are the core of the challenge.

## Deliverable Assets

1. **A published dashboard** — share it as a Tableau Public link, an exported `.twbx`/packaged workbook, or clear screenshots. Tableau (Cloud/Desktop/Public) is preferred, but equivalent modern BI tools (Power BI, Looker Studio, etc.) are fully accepted — we do not want tool licensing to exclude strong candidates.
2. **`reporting_views.sql`** — the SQL views/queries that feed your dashboard. This exercises your SQL skills and the handoff boundary with data engineering: by providing starter SQL logic you make the business intent explicit and reproducible for the engineering team.
3. **`validation.md`** — your metric definitions, validation thresholds, and acceptance criteria for deciding whether a report is "safe to read and act on", plus a reconciliation of at least one KPI against the raw source tables (show the numbers agree, and by how much they may differ).
4. **`design_process.md`** — a brief explanation of your thought process, mirroring the convention used in our Data Engineer challenge (assumptions, tradeoffs, what you would do with more time).

## Technical Setup

This challenge is **self-contained — there is no external repository to fork and no Docker required** (unlike the Data Engineer challenge). A small, seeded eCommerce dataset lives in this repo under [`bi_analyst_assets/`](bi_analyst_assets/):

- [`bi_analyst_assets/seed.sql`](bi_analyst_assets/seed.sql) — `CREATE TABLE` + `INSERT` statements for the star schema, written to run on both PostgreSQL and SQLite.
- [`bi_analyst_assets/fact_orders.csv`](bi_analyst_assets/fact_orders.csv), [`dim_product.csv`](bi_analyst_assets/dim_product.csv), [`dim_customer.csv`](bi_analyst_assets/dim_customer.csv), [`dim_date.csv`](bi_analyst_assets/dim_date.csv) — the same data as flat files.

You have two ways to work, pick whichever fits your toolchain:

- **SQL path:** load `seed.sql` into a local PostgreSQL or SQLite instance, then write and validate your SQL there.
  - PostgreSQL: `psql -d your_db -f bi_analyst_assets/seed.sql`
  - SQLite: `sqlite3 bi.db < bi_analyst_assets/seed.sql`
- **BI-tool path:** connect the CSV files directly to your BI tool (Tableau, Power BI, Looker Studio) and model the joins there.

Either way you should still deliver `reporting_views.sql` so the SQL logic behind your dashboard is explicit.

## Business Case

The company processes large volumes of transactions but currently lacks trustworthy, self-serve insight to guide decisions. These come to you as stakeholder questions — part of the exercise is translating them into concrete reporting requirements (grain, filters, definitions):

- **Which products are the top performers in terms of sales volume and revenue?**
- **How is revenue trending over time, and how does it break down by customer segment?**

(These deliberately echo our Data Engineer challenge so the two roles reason over the same business.)

## Available Data

The star schema in `bi_analyst_assets/` contains:

1. `fact_orders` — one row per order line: `order_item_id`, `order_id`, `date_key`, `customer_id`, `product_id`, `quantity`, `unit_price`, `discount_pct`, `line_revenue`.
2. `dim_product` — `product_id`, `product_name`, `category`, `unit_cost`, `list_price`.
3. `dim_customer` — `customer_id`, `customer_name`, `segment` (Consumer / Corporate / Home Office), `region`.
4. `dim_date` — `date_key` (YYYYMMDD), `full_date`, `year`, `quarter`, `month`, `month_name`, `day_of_month`, `day_of_week`, `day_name`, `is_weekend`.

The data spans roughly six months across multiple products, categories, and customer segments — enough for the two business questions to produce meaningful results.

## Time constraint

Try to keep your development to around 4 hours. We want to see your work, but we also don't want to take up a ton of your time. Use judgement on what will help showcase your skills appropriately.

If you run out of time, it is okay to not implement all of the requested features in the challenge.

## Evaluation Criteria

We will assess your submission based on:

- **Dashboard design & data storytelling** — clarity, layout, and how well the visuals answer the business questions for a non-technical stakeholder.
- **SQL correctness and clarity** — clean, correct `reporting_views.sql` that a data engineer could hand off from.
- **Rigor of metric definitions, validation & reconciliation** — precise definitions, sensible thresholds/acceptance criteria, and a KPI that reconciles to the source.
- **Documentation & communication** — `design_process.md` and `validation.md` reasoning, assumptions, and tradeoffs.
- **Translating business questions into requirements** — how well you turn vague stakeholder asks into concrete, defensible reporting specs.

## Optional Stretch

**Optional and not counted against your time box** — attempt only if you have spare time. These mirror the data-stewardship and report-lifecycle responsibilities of the role:

- **Canonical data dictionary:** [`bi_analyst_assets/field_definitions_raw.csv`](bi_analyst_assets/field_definitions_raw.csv) contains duplicate and conflicting definitions of the same metrics across teams (e.g. two different `revenue` and `aov` definitions). Resolve them into a single canonical data dictionary and note the calls you made.
- **Report governance:** using [`bi_analyst_assets/report_usage_stats.csv`](bi_analyst_assets/report_usage_stats.csv), assign each report a tier, a business owner, and alert recipients where missing.
- **Decommissioning triage:** from the same usage stats, identify reports that are candidates for decommissioning and write a short Jira-style ticket (title + rationale) for retiring them.

Keep this section brief — a paragraph or a short table per item is plenty.

## How to Submit

Because there is no separate base repository to fork, share your work as a single repo/PR containing your SQL and docs plus a link to the dashboard:

1. Create a new Git repository (or fork this one) for your solution.
2. Create a dedicated branch for your work.
3. Commit `reporting_views.sql`, `validation.md`, and `design_process.md` (and any exported dashboard file/screenshots).
4. Open a Pull Request against the `main` branch of your repo.
5. Share the GitHub repo URL or the PR link with us, along with the published dashboard link (or attached workbook/screenshots).
