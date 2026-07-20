/* =====================================================================
   Product operational database (SQL Server) - source system
   Senior Data Engineer (Azure / SQL Server) challenge
   Representative schema + small sample dataset.
   ===================================================================== */

CREATE DATABASE ProductOps;
GO
USE ProductOps;
GO

/* -------------------------------------------------------------------
   product_descriptions
   system-versioned temporal table -> product attributes change over
   time (price, category), relevant for slowly-changing dimension design
   ------------------------------------------------------------------- */
CREATE TABLE dbo.product_descriptions
(
    product_id    INT            NOT NULL PRIMARY KEY,
    product_name  NVARCHAR(200)  NOT NULL,
    category      NVARCHAR(100)  NOT NULL,
    list_price    DECIMAL(12, 2) NOT NULL,   -- reference price in USD
    is_active     BIT            NOT NULL,
    valid_from    DATETIME2(3) GENERATED ALWAYS AS ROW START NOT NULL,
    valid_to      DATETIME2(3) GENERATED ALWAYS AS ROW END   NOT NULL,
    PERIOD FOR SYSTEM_TIME (valid_from, valid_to)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.product_descriptions_history));
GO

/* -------------------------------------------------------------------
   Sample data
   ------------------------------------------------------------------- */
INSERT INTO dbo.product_descriptions
    (product_id, product_name, category, list_price, is_active) VALUES
    (10, N'Wireless Mouse',        N'Electronics',   29.95, 1),
    (11, N'Mechanical Keyboard',   N'Electronics',  120.00, 1),
    (12, N'Ceramic Mug',           N'Home & Kitchen', 45.50, 1),
    (13, N'Noise-Cancel Headset',  N'Electronics',  199.00, 1),
    (14, N'Notebook A5',           N'Stationery',     5.00, 1);
GO
