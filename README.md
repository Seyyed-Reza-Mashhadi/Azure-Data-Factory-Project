# 🚀 Azure Data Factory ETL Project

This project demonstrates a complete ETL pipeline using Azure Cloud Services, including Azure Data Factory (ADF), Azure Data Lake Storage Gen2 (ADLS), and Azure SQL Database. The goal was to process and clean raw OLTP data, transforming a highly normalized transactional schema into an analytics-friendly star schema, ready for efficient querying in SQL and reporting in Power BI. The project showcases how raw tabular data can be ingested, transformed into a star schema, stored in optimized formats such as Parquet, and loaded into a relational database for scalable analytics.

🔗 **Dataset:** The data is available on [Kaggle](https://www.kaggle.com/datasets/155a87ba8d7e92c5896ddc7f3ca3e3fa9c799207ed8dbf9a1cedf2e2e03e3c14). 


# ⚙️ Step-by-Step Implementation

## 1️⃣ Azure Resources & Resource Group
Cloud computing provides flexibility, scalability, and cost efficiency for data projects. Among the major providers (AWS, GCP, Azure), this project leverages Microsoft Azure. In Azure, the starting point for deploying services is a Resource Group — a logical container that holds all related resources (e.g., storage, compute, networking) so they can be managed, monitored, and billed together. 

For this project, the provisioned resources within our resource group `azure-project` included:  
- **Azure Data Factory (ADF)**  
- **Azure Data Lake Storage Gen2 (ADLS)**  
- **Azure SQL Database**  
- **Azure SQL Server**

<p align="center">
  <img src="https://github.com/user-attachments/assets/50dc25b7-ac4b-45e7-bb01-4cd3bc0e54a5" width="350">
</p>

## 2️⃣ Azure Data Lake Storage Service
Provisioned ADLS Gen2 with:
- **Storage Redundancy:** LRS (Locally Redundant Storage) for cost efficiency.
- **Access Tier:** Hot tier to support frequent reads and writes.
- **Data Protection:** Soft delete enabled at both container and blob levels.
- **Security:** IP-restricted access to ensure controlled connectivity.
- **Logical Organization:**
    - `rawdata` container → holds ingested raw CSV files (uploaded via Azure Storage Explorer).
    - `processeddata` container → stores transformed Parquet outputs.
- **Note on Versioning & Snapshots:** ADLS supports versioning and snapshots. These allow point-in-time recovery and auditability of data (useful for compliance or rollback scenarios). These options were not required for this demo project as the dataset was simple and static.

## 3️⃣ Data Factory Setup

- Created an Azure Data Factory (ADF) instance.
- Set up an Integration Runtime (IR) with:
  - Default IR for basic operations.
  - Custom IR connected to a Virtual Network (VNet) for secure managed private endpoints.
- Configured and then approved/validated Managed Private Endpoints for:
  - ADLS Gen2
  - Azure SQL Database

## 4️⃣ Linked Services & Datasets

- Created Linked Services for:
  - ADLS Gen2 (both raw and processed data containers).
  - Azure SQL Database.
- Defined Datasets for:
  - CSV input files (schema, delimiter, file path).
  - Parquet output files.
  - SQL tables.

## 5️⃣ SQL Database Preparation

- Connected to **Azure SQL Database** via VS Code.  
- Created tables manually using SQL scripts to match the processed Parquet data:  
  - Defined proper column names and data types for each table.  
  - Established Primary Keys and Foreign Keys for the **Star Schema**.  
This ensures the database has empty tables with a defined star schema, ready for data to be loaded.

## 5️⃣ Pipeline & Data Flow Design

The ADF pipeline included three main components:  

- **Data Flow**  
  - Cleaned and refined data (joins, drops, renames).  
  - Transformed raw transactional data into a **Star Schema**.  
  - Stored output as **Parquet files** in the `processeddata` container.  

- **Copy Activity (within ForEach Activity)**  
  - Parameterized to dynamically load multiple tables.  
  - Ran four iterations without hardcoding paths or dataset names.  

- **Delete Activity**  
  - Removed incomplete/corrupted files on failure.  


⚡ **Design Note**  
Data could have been written directly into Azure SQL Database, but an intermediate Parquet layer was added to:  
- Keep a **backup** of cleaned data.  
- Demonstrate use of **optimized columnar storage**.  
- Ensure **cost-efficient resilience** for moderate data volumes.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e3db54c5-f27c-4b97-82e4-5fb73c4300db" width="700">
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/3e2c90cf-9abe-4335-a806-314243555efe" width="700">
</p>

## 6️⃣ Pipeline Execution & SQL Database Validation

- Executed the pipeline to produce final outcomes:  
  - Used **TriggerNow** for consistent results.  
  - **Debug** mode was only used during pipeline design for testing, as outputs may vary between runs.
 
- Verified that data was correctly loaded into SQL tables using **SQL queries in VS Code**.  
- Connected the SQL Database to **Power BI Desktop** to confirm that the schema was recognized and the data was ready for reporting.  

⚡ **Note:** This project focuses on **Azure Data Factory ETL/ELT processes**. For dedicated SQL queries and Power BI analytics using the same dataset, please refer to the related projects below.  

<p align="center">
  <img src="https://github.com/user-attachments/assets/461f6cf8-3e8c-4eb0-8478-8a9bd2695e16" width="900">
</p>



## 💰 Cost Considerations in Azure

Since this project was deployed under a Pay-As-You-Go (PAYG) subscription, cost control was important. To keep expenses in check:
- Set up a budget in Azure Cost Management.
- Configured email alerts for threshold breaches.
- Chose LRS (Locally Redundant Storage) and hot tier for balancing performance with cost.

📌 Different Azure services have different pricing models, and cost awareness is a critical part of cloud projects. While this was a small-scale demo, the same principle applies to enterprise-scale deployments. Of course, for long term usage of azure cloud services better subscription options are available.

## ✅ Key Features of This Project

- Secure private networking using Managed Private Endpoints.
- Data protection with soft delete and IP restrictions.
- Awareness of versioning & snapshots in ADLS (not applied here but relevant in real-world scenarios).
- Optimized storage format via Parquet.
- Schema transformation from raw transactional data to Star Schema for data analytics purposes.
- Pipeline Parameterization with ForEach + dynamic datasets for scalability.
- Automated error handling with Delete Activity on pipeline failures.
- End-to-end validation using SQL queries and Power BI.


## 🔁 Related Projects

The same dataset has been explored in two additional projects, each with a different focus:  

- 📊 [SQL Project – Grocery Sales](https://github.com/Seyyed-Reza-Mashhadi/SQL-Project_Grocery-Sales): This companion project presents the PostgreSQL database design and extensive analytical SQL queries underpinning the Power BI dashboard insights. It provides deep dives into revenue trends, customer segmentation, product performance, and employee effectiveness.
- 📊 [Power BI Dashboard – Grocery Sales](https://github.com/Seyyed-Reza-Mashhadi/Power-BI-Project_Grocery-Sales): An interactive dashboard that visually explores key trends from this SQL project — including sales performance, product demand, customer spending metrics, employee highlights, and regional insights.
