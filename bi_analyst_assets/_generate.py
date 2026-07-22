#!/usr/bin/env python3
"""Deterministic generator for the BI Analyst challenge seed dataset.

Produces a small eCommerce star schema and writes:
  - seed.sql (CREATE TABLE + INSERT, PostgreSQL & SQLite friendly)
  - fact_orders.csv, dim_product.csv, dim_customer.csv, dim_date.csv

Run: python3 _generate.py
The generated files are committed to the repo; this script documents how they
were built and lets us regenerate them consistently.
"""
import csv
import os
import random
from datetime import date, timedelta

random.seed(42)
HERE = os.path.dirname(os.path.abspath(__file__))

# ---------------------------------------------------------------------------
# dim_product
# ---------------------------------------------------------------------------
# (product_id, product_name, category, unit_cost, list_price)
PRODUCTS = [
    (1,  "Aurora Wireless Headphones",  "Electronics",   38.00,  89.99),
    (2,  "Nimbus Bluetooth Speaker",    "Electronics",   22.50,  59.99),
    (3,  "Vertex 4K Action Camera",     "Electronics",   96.00, 199.99),
    (4,  "Pulse Smartwatch",            "Electronics",   61.00, 149.99),
    (5,  "Lumen Desk Lamp",             "Home & Living", 12.00,  34.99),
    (6,  "Cascade Ceramic Mug Set",     "Home & Living",  8.50,  24.99),
    (7,  "Harbor Cotton Bath Towels",   "Home & Living", 14.00,  39.99),
    (8,  "Meadow Scented Candle",       "Home & Living",  5.00,  16.99),
    (9,  "Trailhead Running Shoes",     "Apparel",       33.00,  79.99),
    (10, "Summit Fleece Jacket",        "Apparel",       28.00,  69.99),
    (11, "Drift Cotton T-Shirt",        "Apparel",        6.00,  19.99),
    (12, "Cobalt Denim Jeans",          "Apparel",       21.00,  54.99),
    (13, "Sprout Organic Green Tea",    "Grocery",        3.20,   9.49),
    (14, "Grove Cold Brew Coffee",      "Grocery",        4.10,  12.99),
    (15, "Orchard Trail Mix",           "Grocery",        2.80,   7.99),
]

# Relative demand weight per product -> makes some clear top performers.
DEMAND = {
    1: 9, 2: 6, 3: 3, 4: 7, 5: 5, 6: 8, 7: 4, 8: 6,
    9: 8, 10: 5, 11: 10, 12: 6, 13: 7, 14: 9, 15: 6,
}

# ---------------------------------------------------------------------------
# dim_customer
# ---------------------------------------------------------------------------
SEGMENTS = ["Consumer", "Corporate", "Home Office"]
REGIONS = ["North", "South", "East", "West"]
FIRST = ["Ava", "Liam", "Mia", "Noah", "Emma", "Ethan", "Sofia", "Lucas",
         "Isla", "Mateo", "Zoe", "Kai", "Nora", "Owen", "Elena", "Hugo",
         "Ruby", "Leo", "Aria", "Finn", "Iris", "Milo", "Luna", "Jack"]
LAST = ["Reyes", "Novak", "Osei", "Kim", "Haddad", "Silva", "Ford", "Ono",
        "Patel", "Cruz", "Bauer", "Diaz", "Mori", "Wolfe", "Costa", "Ahmed",
        "Berg", "Lund", "Romano", "Faber", "Khan", "Vega", "Roy", "Ellis"]

customers = []
for cid in range(1, 25):
    seg = SEGMENTS[(cid * 7) % len(SEGMENTS)]
    region = REGIONS[(cid * 3) % len(REGIONS)]
    name = f"{FIRST[cid - 1]} {LAST[cid - 1]}"
    customers.append((cid, name, seg, region))

# ---------------------------------------------------------------------------
# fact_order_items + dim_date
# ---------------------------------------------------------------------------
START = date(2024, 1, 1)
END = date(2024, 6, 30)

# Month-level revenue trend multiplier (gentle upward trend + seasonality).
MONTH_TREND = {1: 0.80, 2: 0.85, 3: 1.00, 4: 1.10, 5: 1.25, 6: 1.40}

product_ids = [p[0] for p in PRODUCTS]
product_weights = [DEMAND[p[0]] for p in PRODUCTS]
price_by_id = {p[0]: p[4] for p in PRODUCTS}

orders = []           # (order_item_id, order_id, date_key, customer_id, product_id, qty, unit_price, discount, line_revenue)
order_dates = {}      # order_id -> date
order_item_id = 0
order_id = 0

cur = START
while cur <= END:
    # Higher volume later in the range; weekends a bit busier.
    base = 1.4 if cur.weekday() >= 5 else 1.0
    lam = MONTH_TREND[cur.month] * base
    n_orders_today = 1 if random.random() < 0.55 * lam else 0
    if random.random() < 0.35 * lam:
        n_orders_today += 1
    for _ in range(n_orders_today):
        order_id += 1
        order_dates[order_id] = cur
        cust = random.randint(1, 24)
        n_lines = random.choices([1, 2, 3], weights=[5, 3, 2])[0]
        chosen = random.choices(product_ids, weights=product_weights, k=n_lines)
        seen = set()
        for pid in chosen:
            if pid in seen:
                continue
            seen.add(pid)
            order_item_id += 1
            qty = random.choices([1, 2, 3, 4], weights=[6, 3, 2, 1])[0]
            unit_price = price_by_id[pid]
            # occasional promotional discount
            discount = random.choices([0.00, 0.10, 0.15, 0.20],
                                      weights=[70, 12, 10, 8])[0]
            line_rev = round(qty * unit_price * (1 - discount), 2)
            date_key = int(cur.strftime("%Y%m%d"))
            orders.append((order_item_id, order_id, date_key, cust, pid,
                           qty, round(unit_price, 2), discount, line_rev))
    cur += timedelta(days=1)

# dim_date: only dates that actually appear (keeps it compact but joinable).
used_dates = sorted({order_dates[o[1]] for o in orders})
dim_date = []
for d in used_dates:
    dk = int(d.strftime("%Y%m%d"))
    dim_date.append((
        dk,
        d.isoformat(),
        d.year,
        (d.month - 1) // 3 + 1,
        d.month,
        d.strftime("%B"),
        d.day,
        d.isoweekday(),
        d.strftime("%A"),
        1 if d.weekday() >= 5 else 0,
    ))

# ---------------------------------------------------------------------------
# Write CSVs
# ---------------------------------------------------------------------------
def write_csv(name, header, rows):
    with open(os.path.join(HERE, name), "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(header)
        w.writerows(rows)

write_csv("dim_product.csv",
          ["product_id", "product_name", "category", "unit_cost", "list_price"],
          [(p[0], p[1], p[2], f"{p[3]:.2f}", f"{p[4]:.2f}") for p in PRODUCTS])

write_csv("dim_customer.csv",
          ["customer_id", "customer_name", "segment", "region"],
          customers)

write_csv("dim_date.csv",
          ["date_key", "full_date", "year", "quarter", "month",
           "month_name", "day_of_month", "day_of_week", "day_name", "is_weekend"],
          dim_date)

write_csv("fact_orders.csv",
          ["order_item_id", "order_id", "date_key", "customer_id", "product_id",
           "quantity", "unit_price", "discount_pct", "line_revenue"],
          [(r[0], r[1], r[2], r[3], r[4], r[5], f"{r[6]:.2f}",
            f"{r[7]:.2f}", f"{r[8]:.2f}") for r in orders])

# ---------------------------------------------------------------------------
# Write seed.sql
# ---------------------------------------------------------------------------
def sql_str(s):
    return "'" + s.replace("'", "''") + "'"

lines = []
lines.append("-- BI Analyst challenge seed dataset")
lines.append("-- Simple eCommerce star schema. Portable across PostgreSQL and SQLite.")
lines.append("-- Load with:  psql -f seed.sql   OR   sqlite3 bi.db < seed.sql")
lines.append("")
for t in ["fact_orders", "dim_product", "dim_customer", "dim_date"]:
    lines.append(f"DROP TABLE IF EXISTS {t};")
lines.append("")
lines.append("""CREATE TABLE dim_product (
    product_id   INTEGER PRIMARY KEY,
    product_name VARCHAR(80)  NOT NULL,
    category     VARCHAR(40)  NOT NULL,
    unit_cost    NUMERIC(10,2) NOT NULL,
    list_price   NUMERIC(10,2) NOT NULL
);""")
lines.append("")
lines.append("""CREATE TABLE dim_customer (
    customer_id   INTEGER PRIMARY KEY,
    customer_name VARCHAR(80) NOT NULL,
    segment       VARCHAR(20) NOT NULL,
    region        VARCHAR(20) NOT NULL
);""")
lines.append("")
lines.append("""CREATE TABLE dim_date (
    date_key     INTEGER PRIMARY KEY,   -- YYYYMMDD
    full_date    DATE    NOT NULL,
    year         INTEGER NOT NULL,
    quarter      INTEGER NOT NULL,
    month        INTEGER NOT NULL,
    month_name   VARCHAR(12) NOT NULL,
    day_of_month INTEGER NOT NULL,
    day_of_week  INTEGER NOT NULL,      -- 1=Mon .. 7=Sun
    day_name     VARCHAR(12) NOT NULL,
    is_weekend   INTEGER NOT NULL       -- 0/1
);""")
lines.append("")
lines.append("""CREATE TABLE fact_orders (
    order_item_id INTEGER PRIMARY KEY,
    order_id      INTEGER NOT NULL,
    date_key      INTEGER NOT NULL REFERENCES dim_date(date_key),
    customer_id   INTEGER NOT NULL REFERENCES dim_customer(customer_id),
    product_id    INTEGER NOT NULL REFERENCES dim_product(product_id),
    quantity      INTEGER NOT NULL,
    unit_price    NUMERIC(10,2) NOT NULL,
    discount_pct  NUMERIC(4,2)  NOT NULL,  -- 0.00 .. 1.00
    line_revenue  NUMERIC(12,2) NOT NULL   -- quantity * unit_price * (1 - discount_pct)
);""")
lines.append("")

lines.append("INSERT INTO dim_product (product_id, product_name, category, unit_cost, list_price) VALUES")
vals = [f"  ({p[0]}, {sql_str(p[1])}, {sql_str(p[2])}, {p[3]:.2f}, {p[4]:.2f})" for p in PRODUCTS]
lines.append(",\n".join(vals) + ";")
lines.append("")

lines.append("INSERT INTO dim_customer (customer_id, customer_name, segment, region) VALUES")
vals = [f"  ({c[0]}, {sql_str(c[1])}, {sql_str(c[2])}, {sql_str(c[3])})" for c in customers]
lines.append(",\n".join(vals) + ";")
lines.append("")

lines.append("INSERT INTO dim_date (date_key, full_date, year, quarter, month, month_name, day_of_month, day_of_week, day_name, is_weekend) VALUES")
vals = [f"  ({d[0]}, {sql_str(d[1])}, {d[2]}, {d[3]}, {d[4]}, {sql_str(d[5])}, {d[6]}, {d[7]}, {sql_str(d[8])}, {d[9]})" for d in dim_date]
lines.append(",\n".join(vals) + ";")
lines.append("")

lines.append("INSERT INTO fact_orders (order_item_id, order_id, date_key, customer_id, product_id, quantity, unit_price, discount_pct, line_revenue) VALUES")
vals = [f"  ({r[0]}, {r[1]}, {r[2]}, {r[3]}, {r[4]}, {r[5]}, {r[6]:.2f}, {r[7]:.2f}, {r[8]:.2f})" for r in orders]
lines.append(",\n".join(vals) + ";")
lines.append("")

with open(os.path.join(HERE, "seed.sql"), "w") as f:
    f.write("\n".join(lines))

print(f"products={len(PRODUCTS)} customers={len(customers)} "
      f"order_items={len(orders)} orders={order_id} dates={len(dim_date)}")
total_rev = sum(r[8] for r in orders)
print(f"total_line_revenue={total_rev:.2f}")
