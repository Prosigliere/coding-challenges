from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator

default_args = {
    'owner': 'data_engineer_candidate',
    'depends_on_past': False,
    'start_date': datetime(2024, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'example_etl_pipeline',
    default_args=default_args,
    description='Example ETL pipeline for eCommerce data',
    schedule_interval=timedelta(days=1),
    catchup=False,
    tags=['example', 'etl', 'ecommerce'],
)

def extract_data():
    """
    Example function to extract data from source databases.
    Replace this with your actual extraction logic.
    """
    print("Extracting data from source databases...")
    print("Database 1 (Orders): postgresql://postgres:postgres@postgres_db1:5432/ecommerce_orders")
    print("Database 2 (Products): postgresql://postgres:postgres@postgres_db2:5432/ecommerce_products")
    print("Currency API: External API for currency conversion rates")
    return "Data extracted successfully"

def transform_data():
    """
    Example function to transform the extracted data.
    Replace this with your actual transformation logic.
    """
    print("Transforming data...")
    print("- Joining orders with customer and product information")
    print("- Converting currencies using exchange rates")
    print("- Calculating sales metrics")
    print("- Aggregating data for analytics")
    return "Data transformed successfully"

def load_data():
    """
    Example function to load data into the data warehouse.
    Replace this with your actual loading logic.
    """
    print("Loading data into data warehouse...")
    print("Target: postgresql://postgres:postgres@postgres_warehouse:5432/data_warehouse")
    print("- Loading dimension tables")
    print("- Loading fact tables")
    print("- Updating data quality metrics")
    return "Data loaded successfully"

extract_task = PythonOperator(
    task_id='extract_data',
    python_callable=extract_data,
    dag=dag,
)

transform_task = PythonOperator(
    task_id='transform_data',
    python_callable=transform_data,
    dag=dag,
)

load_task = PythonOperator(
    task_id='load_data',
    python_callable=load_data,
    dag=dag,
)

test_connection = BashOperator(
    task_id='test_connections',
    bash_command='echo "Testing database connections..." && echo "All connections successful!"',
    dag=dag,
)

test_connection >> extract_task >> transform_task >> load_task
