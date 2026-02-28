 **Background**

The Nashville Housing dataset represents historical residential property sales across Nashville, Tennessee. Like many operational real-estate datasets, the data was collected over time from multiple sources and systems, resulting in inconsistencies, missing values, duplicate records, and unstructured fields.

For analysts and business stakeholders, raw housing data in this state makes it difficult to perform reliable reporting, geographic analysis, and trend forecasting.

To support future analytics and business intelligence initiatives, a comprehensive SQL data-cleaning workflow was developed to transform the dataset into a trusted, analysis-ready data source.

**Executive Summary**

This project focuses on cleaning and standardizing a real-world housing dataset using T-SQL in SQL Server.

The transformation pipeline resolves key data quality issues by:

Standardizing date formats

Filling missing property addresses

Splitting unstructured address fields into structured columns

Standardizing categorical values

Identifying duplicate records

Removing redundant columns

The final output is a clean, structured dataset ready for dashboards, reporting, and advanced analytics.

Business Problem

Raw datasets often require significant preparation before analysis can begin. The Nashville Housing dataset presented several challenges:

• Sale dates stored as text instead of proper date format
• Missing property addresses across multiple records
• Address data stored in single text fields instead of structured columns
• Inconsistent categorical values (Y/N vs Yes/No)
• Duplicate sales records causing potential double counting
• Redundant columns remaining after transformation

Without cleaning, these issues could lead to:

Inaccurate trend analysis

Inefficient geographic reporting

Misleading business insights

Significant analyst time spent on manual preparation

The business need was to create a reliable and analytics-ready housing dataset.

**Methodology**
1. Date Standardization

A new column SaleDateConverted was created and populated by converting the original text-based sale date into a true SQL DATE format.

This enables accurate time-based analysis and reporting.

2. Missing Address Imputation

Property addresses missing from certain records were populated using a self-join on ParcelID, ensuring properties with shared identifiers inherit valid address data.

This step improved data completeness and reliability.

3. Property Address Structuring

The PropertyAddress column was split into:

PropertySplitAddress — Street address

PropertySplitCity — City

Using string parsing functions:

SUBSTRING()

CHARINDEX()

This transformation enables location-based filtering and aggregation.

4. Owner Address Structuring

The OwnerAddress field was decomposed into:

OwnerSplitAddress

OwnerSplitCity

OwnerSplitState

Using:

REPLACE()

PARSENAME()

This converts unstructured text into structured geographic attributes.

5. Categorical Value Standardization

The SoldAsVacant column contained inconsistent values.
Values were standardized:

Y → Yes

N → No

This ensures clean grouping and reporting.

6. Duplicate Detection

Duplicate records were identified using a CTE with ROW_NUMBER() based on:

ParcelID

PropertyAddress

SalePrice

SaleDate

LegalReference

This prevents double-counting in future analytics workflows.

7. Removal of Redundant Columns

After transformation, unused columns were removed:

OwnerAddress

TaxDistrict

PropertyAddress

SaleDate

This produced a lean and analysis-ready table.

Skills Demonstrated

SQL Server / T-SQL

Data Cleaning & Transformation

Data Quality Improvement

Window Functions (ROW_NUMBER)

Self-Joins for Data Imputation

String Parsing Functions

Schema Modification (ALTER / DROP)

Preparing Data for BI & Analytics

**Results & Solution
**
The dataset was transformed from a raw operational dataset into a trusted analytical dataset:

✔ Date fields standardized
✔ Missing values resolved
✔ Address fields structured
✔ Categorical values cleaned
✔ Duplicate records identified
✔ Redundant columns removed

The data is now ready for:

Power BI / Tableau dashboards

Real estate market analysis

Predictive modeling

Geographic insights

**Next Steps**

Future enhancements could include:

• Building a real estate price trend dashboard
• Adding geospatial enrichment (ZIP codes, lat/long)
• Automating the cleaning pipeline using SQL jobs
• Implementing staging and production tables for ETL workflows
• Creating a data quality monitoring dashboard

**Impact**

📉 Reduced data inconsistencies
📊 Improved reliability of analytics
⏱ Reduced analyst data preparation time
📍 Enabled geographic and time-based insights
📈 Established a foundation for business intelligence and advanced analytics
