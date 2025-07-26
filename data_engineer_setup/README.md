# Data Engineer Challenge Setup

This directory contains the complete Docker Compose setup for the Data Engineer coding challenge. The environment provides realistic eCommerce data sources and infrastructure for candidates to build their ETL pipelines and data warehouse solutions.

## Architecture Overview

The setup includes:
- **3 PostgreSQL databases** (source systems + data warehouse)
- **1 Apache Airflow instance** (orchestration)
- **Sample eCommerce data** (orders, customers, products)
- **Currency conversion API documentation** (external dependency)

## Quick Start

1. **Prerequisites**
   - Docker and Docker Compose installed
   - At least 4GB RAM available for containers
   - Ports 5432, 5433, 5434, and 8080 available

2. **Start the environment**
   ```bash
   cd data_engineer_setup
   docker-compose up -d
   ```

3. **Verify services are running**
   ```bash
   docker-compose ps
   ```

4. **Access Airflow Web UI**
   - URL: http://localhost:8080
   - Username: `admin`
   - Password: `admin`

## Database Connections

### Database 1: Orders & Customers
- **Host**: localhost
- **Port**: 5432
- **Database**: ecommerce_orders
- **Username**: postgres
- **Password**: postgres

**Tables:**
- `customers` - Customer information (50 customers from various countries)
- `orders` - Order transactions (83 orders spanning 6 months)
- `order_items` - Individual items within orders (83+ line items)

### Database 2: Product Catalog
- **Host**: localhost
- **Port**: 5433
- **Database**: ecommerce_products
- **Username**: postgres
- **Password**: postgres

**Tables:**
- `product_descriptions` - Product catalog (100 products across 10 categories)

### Database 3: Data Warehouse (Target)
- **Host**: localhost
- **Port**: 5434
- **Database**: data_warehouse
- **Username**: postgres
- **Password**: postgres

**Note**: This database is intentionally empty for you to design your own schema.

## Sample Data Overview

### Business Context
The sample data represents a global eCommerce platform with:
- **50 customers** from 20+ countries
- **100 products** across 10 categories (Electronics, Clothing, Books, etc.)
- **83 orders** with realistic time patterns (more activity during business hours)
- **Multiple currencies** (USD, EUR, GBP) requiring conversion
- **6 months of transaction history** (January - July 2024)

### Key Business Questions to Answer
1. **Product Performance**: Which products are top performers in sales volume and revenue?
2. **Optimal Timing**: What's the best time of day to run sales promotions?

## Currency Conversion API

For currency conversion, you'll need to integrate with an external API. Here's the expected interface:

**Endpoint**: `https://api.exchangerate-api.com/v4/latest/{base_currency}`
**Parameters**:
- `date`: YYYY-MM-DD format
- `currency_from`: 3-letter currency code (USD, EUR, GBP)
- `currency_to`: 3-letter currency code

**Example Response**:
```json
{
  "base": "USD",
  "date": "2024-07-25",
  "rates": {
    "EUR": 0.92,
    "GBP": 0.78
  }
}
```

## Development Workflow

1. **Explore the Data**
   ```sql
   -- Connect to Database 1
   SELECT COUNT(*) FROM customers;
   SELECT COUNT(*) FROM orders;
   SELECT COUNT(*) FROM order_items;
   
   -- Connect to Database 2
   SELECT COUNT(*) FROM product_descriptions;
   SELECT DISTINCT category FROM product_descriptions;
   ```

2. **Design Your Data Warehouse Schema**
   - Consider dimensional modeling (facts and dimensions)
   - Plan for the business questions you need to answer
   - Design for scalability and query performance

3. **Implement ETL Pipeline**
   - Create your DAG in `airflow/dags/`
   - Use the example DAG as a starting point
   - Implement extraction, transformation, and loading logic

4. **Test Your Pipeline**
   - Use Airflow UI to trigger and monitor DAGs
   - Validate data quality and completeness
   - Test your analytics queries

## Useful SQL Queries for Exploration

### Orders by Time of Day
```sql
SELECT 
    EXTRACT(HOUR FROM order_date) as hour_of_day,
    COUNT(*) as order_count,
    SUM(total_amount) as total_revenue
FROM orders 
GROUP BY EXTRACT(HOUR FROM order_date)
ORDER BY hour_of_day;
```

### Top Products by Revenue
```sql
SELECT 
    oi.product_id,
    pd.name,
    pd.category,
    SUM(oi.quantity) as total_quantity,
    SUM(oi.quantity * oi.unit_price) as total_revenue
FROM order_items oi
JOIN product_descriptions pd ON oi.product_id = pd.id
GROUP BY oi.product_id, pd.name, pd.category
ORDER BY total_revenue DESC
LIMIT 10;
```

### Customer Distribution by Country
```sql
SELECT 
    country,
    COUNT(*) as customer_count,
    COUNT(DISTINCT o.id) as total_orders
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY country
ORDER BY customer_count DESC;
```

## Troubleshooting

### Container Issues
```bash
# Check container status
docker-compose ps

# View container logs
docker-compose logs [service_name]

# Restart services
docker-compose restart

# Clean restart
docker-compose down && docker-compose up -d
```

### Database Connection Issues
```bash
# Test database connections
docker exec -it ecommerce_db1 psql -U postgres -d ecommerce_orders -c "SELECT COUNT(*) FROM customers;"
docker exec -it ecommerce_db2 psql -U postgres -d ecommerce_products -c "SELECT COUNT(*) FROM product_descriptions;"
docker exec -it data_warehouse psql -U postgres -d data_warehouse -c "SELECT * FROM connection_test;"
```

### Airflow Issues
- Ensure all containers are running before accessing the web UI
- Check Airflow logs: `docker-compose logs airflow-webserver`
- Restart Airflow: `docker-compose restart airflow-webserver airflow-scheduler`

## File Structure
```
data_engineer_setup/
├── docker-compose.yml          # Main orchestration file
├── database/
│   ├── init_db1.sql           # Orders & customers data
│   ├── init_db2.sql           # Product catalog data
│   └── init_warehouse.sql     # Empty warehouse schema
├── airflow/
│   ├── dags/
│   │   └── example_dag.py     # Example ETL pipeline
│   ├── logs/                  # Airflow logs (auto-generated)
│   └── plugins/               # Custom Airflow plugins
├── requirements.txt           # Python dependencies
└── README.md                  # This file
```

## Success Criteria

Your solution should demonstrate:
- ✅ **Data Modeling**: Well-designed warehouse schema
- ✅ **ETL Pipeline**: Functional Airflow DAG with proper task dependencies
- ✅ **Data Quality**: Handling of data inconsistencies and validation
- ✅ **Business Logic**: Transformations that support the required analytics
- ✅ **Documentation**: Clear code comments and README updates
- ✅ **Dashboard Mockup**: Visual representation of insights (optional)

## Time Management

This is a 5-hour challenge. Suggested time allocation:
- **1 hour**: Environment setup and data exploration
- **2 hours**: Data warehouse schema design and implementation
- **1.5 hours**: ETL pipeline development and testing
- **30 minutes**: Documentation and dashboard mockup

Good luck with your data engineering challenge! 🚀
