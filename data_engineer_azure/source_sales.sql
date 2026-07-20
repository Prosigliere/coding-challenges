/* =====================================================================
   Sales operational database (SQL Server) - source system
   Senior Data Engineer (Azure / SQL Server) challenge
   Representative schema + small sample dataset.
   ===================================================================== */

CREATE DATABASE SalesOps;
GO
USE SalesOps;
GO

/* -------------------------------------------------------------------
   customers
   ------------------------------------------------------------------- */
CREATE TABLE dbo.customers
(
    customer_id   INT           NOT NULL PRIMARY KEY,
    full_name     NVARCHAR(200) NOT NULL,
    email         NVARCHAR(256) NULL,
    country       NVARCHAR(100) NOT NULL,
    signup_date   DATE          NOT NULL
);
GO

/* -------------------------------------------------------------------
   orders  (system-versioned temporal table -> drives delta loads)
   order_ts keeps the time-of-day used for the "promotion timing" question
   currency is the transaction currency (normalized downstream via FX API)
   ------------------------------------------------------------------- */
CREATE TABLE dbo.orders
(
    order_id     INT            NOT NULL PRIMARY KEY,
    customer_id  INT            NOT NULL
        REFERENCES dbo.customers (customer_id),
    order_ts     DATETIME2(0)   NOT NULL,
    status       VARCHAR(20)    NOT NULL,   -- placed | shipped | cancelled | refunded
    currency     CHAR(3)        NOT NULL,   -- ISO 4217, e.g. USD, EUR, GBP
    order_total  DECIMAL(12, 2) NOT NULL,   -- in transaction currency
    valid_from   DATETIME2(3) GENERATED ALWAYS AS ROW START NOT NULL,
    valid_to     DATETIME2(3) GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (valid_from, valid_to)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.orders_history));
GO

/* -------------------------------------------------------------------
   order_items  (one row per product line on an order)
   ------------------------------------------------------------------- */
CREATE TABLE dbo.order_items
(
    order_item_id INT            NOT NULL PRIMARY KEY,
    order_id      INT            NOT NULL
        REFERENCES dbo.orders (order_id),
    product_id    INT            NOT NULL,
    quantity      INT            NOT NULL,
    unit_price    DECIMAL(12, 2) NOT NULL   -- in the order's currency
);
GO

/* -------------------------------------------------------------------
   Sample data
   ------------------------------------------------------------------- */
INSERT INTO dbo.customers (customer_id, full_name, email, country, signup_date) VALUES
    (1, N'Ana Torres',    N'ana@example.com',    N'Argentina',      '2023-11-02'),
    (2, N'Liam Smith',    N'liam@example.com',   N'United Kingdom', '2024-01-15'),
    (3, N'Marie Dubois',  N'marie@example.com',  N'France',         '2024-02-20'),
    (4, N'Kenji Tanaka',  N'kenji@example.com',  N'Japan',          '2024-03-05'),
    (5, N'Sara Cohen',    N'sara@example.com',   N'United States',  '2024-03-28');
GO

INSERT INTO dbo.orders (order_id, customer_id, order_ts, status, currency, order_total) VALUES
    (1001, 1, '2024-06-01 09:14:00', 'placed',   'USD',  59.90),
    (1002, 2, '2024-06-01 20:47:00', 'placed',   'GBP', 120.00),
    (1003, 3, '2024-06-02 21:05:00', 'shipped',  'EUR',  45.50),
    (1004, 4, '2024-06-02 13:30:00', 'placed',   'JPY', 8800.00),
    (1005, 5, '2024-06-03 19:58:00', 'placed',   'USD',  15.00),
    (1006, 1, '2024-06-04 22:11:00', 'refunded', 'USD',  59.90),
    (1007, 2, '2024-06-05 21:40:00', 'placed',   'GBP',  30.00);
GO

INSERT INTO dbo.order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
    (1, 1001, 10, 2, 29.95),
    (2, 1002, 11, 1, 120.00),
    (3, 1003, 12, 1, 45.50),
    (4, 1004, 10, 1, 4400.00),
    (5, 1004, 13, 1, 4400.00),
    (6, 1005, 14, 3,  5.00),
    (7, 1006, 10, 2, 29.95),
    (8, 1007, 14, 6,  5.00);
GO
