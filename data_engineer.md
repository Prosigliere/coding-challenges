# Technical Challenge - Senior Data Engineer 

# Warehouse and Pipeline Design for eCommerce Analytics

## Context

This technical challenge aims to simulate a real-world scenario in which a company seeks to answer critical business questions to support strategic decision-making.

- The organization relies on multiple PostgreSQL databases as sources of transactional data.
- Additional data is available via a public API.
- Data pipelines are orchestrated using Apache Airflow DAGs.
- Processed and transformed data is loaded into a dedicated PostgreSQL instance acting as the Data Warehouse, which feeds a reporting tool such as Tableau.

## Objectives

Your task is to: 

1. Design the appropriate Data Warehouse schema to support the requested business questions.
2. Develop the necessary ETL pipeline in Python, implemented as an Airflow DAG, to extract, transform, and load the data into the Data Warehouse.
3. We would love to see a mockup (e.g., in Figma, PowerPoint, Miro, Lucidchart, etc.) illustrating how you would visualize the results in a dashboard.

## Technical Setup

- Clone the following GitHub repository: ""
- Running the included docker-compose.yml file will provision [You'll have specific instructions in the Repository's Readme]:
	- 3 PostgreSQL containers
	- 1 Apache Airflow instance
- You will implement the required DAGs and Python transformations inside the airflow/dags folder.

## Business Case

The company runs an eCommerce platform and processes large volumes of transactions. However, it currently lacks data-driven insights to guide strategic decisions. Management would like to answer the following business questions:

- Which products are the top performers in terms of sales volume and revenue?
- What is the optimal time of day to run sales promotions, based on historical transaction patterns?

## Available Data Sources

1. Database 1: Contains orders, customers, and order_items.
2. Database 2: Contains product_descriptions.
3. API: Provides currency conversion rates. It accepts parameters such as date, currency_from, and currency_to, and returns the corresponding conversion rate.

## Time constraint

Try to keep your development to around 5 hours.  We want to see your work, but we also don’t want to take up a ton of your time.  Use judgement on what will help showcase your skills appropriately. 

If you run out of time, it is okay to not implement all of the requested features in the challenge

## Evaluation Criteria 

We will assess your submission based on:

- Data modeling and schema design
- Code quality and structure
- Proper use of Airflow (DAGs, tasks, operators)
- Clarity of transformation logic
- Thoughtfulness of the proposed dashboard mockup (if submitted)
- Documentation and overall communication

## How to Submit

1. Fork the base Github repository. 
2. Create a dedicated branch for your solution. 
3. Implement your changes and commit your work. 
4. Create a PullRequest from your branch to the ´main´ branch of your fork. 
5. Share the Github repo URL or the PR link with us.