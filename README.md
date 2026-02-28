Executive Summary

This project focuses on cleaning and transforming the Nashville Housing dataset using T-SQL in SQL Server. The original dataset contained inconsistent formats, missing values, duplicate records, and unstructured address fields.

The objective was to convert the raw dataset into a clean, structured, and analysis-ready table suitable for reporting, visualization, and real estate market analysis.

Business Problem

Raw real-estate datasets often contain inconsistencies that make analysis unreliable or time-consuming. In this dataset:

• Dates were stored as text instead of proper date format
• Property addresses were missing in several records
• Address fields were stored as a single string instead of structured columns
• Boolean/categorical values were inconsistent (Y/N vs Yes/No)
• Duplicate property sales existed
• Several columns were redundant after transformation

Without cleaning, analysts could:

Misinterpret time trends

Double-count property sales

Struggle with geographic analysis

Spend unnecessary time preparing data instead of analyzing it

The business need was to create a reliable, analytics-ready dataset.

Methodology
1️⃣ Standardize Date Format

Created a new column SaleDateConverted and converted the original SaleDate into SQL DATE format.

This enables:

Time series analysis

Monthly/quarterly grouping

Accurate filtering and reporting

2️⃣ Populate Missing Property Addresses

Used a self-join on ParcelID to fill missing PropertyAddress values from other rows representing the same property.

This step reduced null values and preserved data completeness.

3️⃣ Split Property Address into Structured Columns

Extracted:

Street Address → PropertySplitAddress

City → PropertySplitCity

Used string parsing functions:

SUBSTRING()

CHARINDEX()

This enables location-based analysis and easier filtering.

4️⃣ Split Owner Address into Address, City, State

Created:

OwnerSplitAddress

OwnerSplitCity

OwnerSplitState

Used:

REPLACE()

PARSENAME()

This converts an unstructured text field into structured geographic attributes.

5️⃣ Standardize Categorical Values

Converted inconsistent values in SoldAsVacant:

Y → Yes

N → No

Ensures clean grouping and reporting.

6️⃣ Identify Duplicate Records

Used a CTE + ROW_NUMBER() window function to detect duplicates based on:

ParcelID

PropertyAddress

SalePrice

SaleDate

LegalReference

This prevents double-counting in future analytics.

7️⃣ Remove Redundant Columns

Dropped columns no longer needed after transformation:

OwnerAddress

TaxDistrict

PropertyAddress

SaleDate

This produces a cleaner, more efficient dataset.

Skills Demonstrated

SQL Server • T-SQL
Data Cleaning & Transformation
Data Quality Improvement
Window Functions (ROW_NUMBER)
Self-Joins for Data Imputation
String Parsing Functions
Schema Modification (ALTER / DROP)
Analytical Data Preparation

Result / Solution

The dataset was transformed from a raw operational dataset into an analysis-ready table:

✔ Standardized date format
✔ Missing addresses populated
✔ Addresses converted into structured columns
✔ Categorical values standardized
✔ Duplicate records identified
✔ Redundant columns removed

The final dataset is now ready for:

Power BI / Tableau dashboards

Real estate trend analysis

Predictive modeling

Geographic analysis

Next Steps

Future improvements that could extend this project:

• Create a data quality dashboard to monitor nulls & duplicates
• Build a real estate price trend dashboard (Power BI / Tableau)
• Add ZIP code / geospatial enrichment
• Automate the cleaning pipeline using SQL jobs
• Build staging and production tables for ETL workflow

Impact

This cleaning process:

📉 Reduced data inconsistencies
📊 Improved data reliability for analytics
⏱ Saved analyst time spent on data preparation
📍 Enabled geographic and time-based insights
📈 Created a strong foundation for BI and advanced analytics
