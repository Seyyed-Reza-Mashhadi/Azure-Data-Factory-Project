# 🚀 Azure Data Factory ETL Project

This project demonstrates a complete ETL pipeline using Azure Data Factory (ADF), Azure Data Lake Storage Gen2 (ADLS), and Azure SQL Database, with validation in Power BI.

It showcases how raw CSV data can be ingested, transformed into a star schema, stored in an optimized format (Parquet), and finally loaded into a relational database for analytics.

This project is part of a broader workflow, connected with SQL and Power BI projects on the same dataset (see Related Projects below).

# 📂 Project Architecture

The pipeline consists of the following main components:

Azure Resource Group – Logical container for all services.

Azure Data Lake Storage Gen2 (ADLS) – Stores raw CSV files and processed Parquet files.

Azure Data Factory (ADF) – Orchestration of ETL process with pipelines and data flows.

Azure SQL Database – Target system for processed and structured data.

Power BI – Data visualization and schema validation (via DirectQuery).

📌 (Insert your ADF architecture screenshot here)

# ⚙️ Step-by-Step Implementation
## 1️⃣ Resource Setup

Created a Resource Group in Azure.

Provisioned ADLS Gen2 with:

LRS (Locally Redundant Storage) for cost efficiency.

Hot access tier (frequent writes/reads).

Soft delete enabled at both container and blob levels for data protection.

IP-restricted access for security.

## 📌 Note on Versioning & Snapshots:
In enterprise-scale projects, ADLS supports versioning and snapshots at the container level. These allow point-in-time recovery and auditability of data (useful for compliance or rollback scenarios).
For this demo project, versioning was not required as the dataset was simple and static.

Uploaded raw CSV files into the raw-data container using Azure Storage Explorer.

Created a separate processed-data container to store transformed Parquet files.

## 2️⃣ Data Factory Setup

Created an Azure Data Factory (ADF) instance.

Set up an Integration Runtime (IR) with:

Default IR for basic operations.

Custom IR connected to a Virtual Network (VNet) for secure managed private endpoints.

Configured Managed Private Endpoints for:

ADLS Gen2

Azure SQL Database

Approved/validated private endpoints in the Azure Portal.

## 3️⃣ Linked Services & Datasets

Created Linked Services for:

ADLS Gen2 (both raw and processed data containers).

Azure SQL Database.

Defined Datasets for:

CSV input files (schema, delimiter, file path).

Parquet output files.

SQL tables (sink schema).

## 4️⃣ Pipeline & Data Flow Design

Built an ADF Pipeline containing:

Data Flow:

Performed joins, column drops/renames, and schema refinements.

Converted raw transactional data into a Star Schema.

Output stored as Parquet files in processed-data container.

Copy Activity inside a ForEach Loop:

Implemented parameterization so the activity dynamically loads different tables.

Pipeline runs four iterations (one for each target table) without hardcoding paths or dataset names.

Delete Activity:

Cleans up incomplete files in case of data flow failure.

⚡ Performance Note:
By default, Parquet sink writes data in partitioned files (parallelized). The key validation file is _SUCCESS.
One-file outputs are possible but less efficient and may fail on large datasets.

📌 (Insert screenshot of your pipeline and data flow here)

## 5️⃣ SQL Database Preparation

Connected to Azure SQL Database via VS Code.

Created tables manually using SQL scripts:

Defined correct data types.

Established Primary Keys and Foreign Keys for the star schema.

Ensured schema alignment with processed Parquet data.

## 6️⃣ Loading Data into SQL Database

Used ADF Copy Activity within ForEach to dynamically load multiple tables.

Executed with TriggerNow (instead of debug) to avoid inconsistencies.

Load time: ~1 hour for ~7M rows.

Verified data correctness with SQL queries in VS Code.

## 7️⃣ Validation in Power BI

Connected Power BI Desktop to Azure SQL Database using DirectQuery (not Import, due to dataset size).

Verified schema and tested simple visualizations.

Confirmed data integrity and usability for reporting.

📌 (Insert screenshot of Power BI schema/visual here)

## 💰 Cost Considerations in Azure

Since this project was deployed under a Pay-As-You-Go (PAYG) subscription, cost control was important.

To keep expenses in check:

Set up a budget in Azure Cost Management.

Configured email alerts for threshold breaches.

Chose LRS (Locally Redundant Storage) and hot tier for balancing performance with cost.

📌 Different Azure services have different pricing models, and cost awareness is a critical part of cloud projects. While this was a small-scale demo, the same principle applies to enterprise-scale deployments.

## ✅ Key Features of This Project

Secure private networking using Managed Private Endpoints.

Data protection with soft delete and IP restrictions.

Awareness of versioning & snapshots in ADLS (not applied here but relevant in real-world scenarios).

Optimized storage format via Parquet.

Schema transformation from raw transactional data to Star Schema.

Pipeline Parameterization with ForEach + dynamic datasets for scalability.

Automated error handling with Delete Activity on pipeline failures.

End-to-end validation using SQL queries and Power BI.

## 📊 Tools & Technologies

Azure Data Factory

Azure Data Lake Storage Gen2

Azure SQL Database

Power BI

Visual Studio Code (SQL scripting)

## 🔗 Related Projects

This project is part of a larger workflow for the same dataset:

SQL Project – Database schema design, query development, and data analysis.
[Link to SQL project on GitHub]

Power BI Project – Dashboard creation and visualization of processed data.
[Link to Power BI project on GitHub]

These related projects complement the ADF ETL workflow by showing end-to-end data processing, storage, and visualization.
