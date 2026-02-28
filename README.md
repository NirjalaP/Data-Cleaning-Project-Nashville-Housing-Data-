# 🏡 Nashville Housing Data Cleaning (SQL Server)

---

## Client Background
The Nashville Housing dataset contains historical residential property sales data from Nashville, Tennessee.  
Like many operational datasets, the data was collected from multiple systems over time, resulting in missing values, inconsistent formats, duplicate records, and unstructured address fields.

To support future analytics and business intelligence initiatives, a SQL-based data cleaning workflow was created to transform the dataset into a **trusted, analysis-ready data source**.

---

## Executive Summary
This project cleans and standardizes a real-world housing dataset using **T-SQL in SQL Server**.

The transformation pipeline:
- Standardizes date formats  
- Fills missing property addresses  
- Splits unstructured address fields  
- Standardizes categorical values  
- Identifies duplicate records  
- Removes redundant columns  

The final output is a **clean and structured dataset** ready for reporting and visualization.

---

## Business Problem
The raw dataset contained several data quality issues:

- Sale dates stored as text instead of date format  
- Missing property addresses  
- Addresses stored in a single text column  
- Inconsistent categorical values (Y/N vs Yes/No)  
- Duplicate sales records  
- Redundant columns after transformation  

These issues could lead to inaccurate reporting and slow analysis.

The goal was to create a **reliable dataset ready for analytics**.

---

## Methodology

### 1️⃣ Standardize Date Format
Created a new column `SaleDateConverted` and converted the original text-based date into SQL `DATE` format.

### 2️⃣ Populate Missing Property Addresses
Used a **self-join on ParcelID** to fill missing address values from matching records.

### 3️⃣ Split Property Address
Created structured columns:
- `PropertySplitAddress`
- `PropertySplitCity`

Used:
- `SUBSTRING()`
- `CHARINDEX()`

### 4️⃣ Split Owner Address
Created:
- `OwnerSplitAddress`
- `OwnerSplitCity`
- `OwnerSplitState`

Used:
- `REPLACE()`
- `PARSENAME()`

### 5️⃣ Standardize Categorical Values
Converted `SoldAsVacant`:
- Y → Yes  
- N → No  

### 6️⃣ Identify Duplicate Records
Used **CTE + ROW_NUMBER()** to detect duplicate sales records.

### 7️⃣ Remove Redundant Columns
Dropped:
- OwnerAddress  
- TaxDistrict  
- PropertyAddress  
- SaleDate  

---

## Skills Demonstrated
- SQL Server / T-SQL  
- Data Cleaning & Transformation  
- Window Functions (ROW_NUMBER)  
- Self-Joins for Data Imputation  
- String Parsing Functions  
- Schema Modification (ALTER / DROP)  
- Preparing Data for BI & Analytics  

---

## Results
The dataset was transformed into an **analysis-ready table**:

✔ Standardized date fields  
✔ Missing values resolved  
✔ Structured address columns created  
✔ Categorical values cleaned  
✔ Duplicate records identified  
✔ Redundant columns removed  

The data is now ready for:
- Power BI / Tableau dashboards  
- Real estate trend analysis  
- Predictive modeling  

---

## Next Steps
Future enhancements:
- Build a real estate price trend dashboard  
- Add geospatial enrichment (ZIP codes / coordinates)  
- Automate the cleaning pipeline using SQL jobs  
- Create staging and production ETL tables  

---

## Impact
This project:
- Improved data reliability  
- Reduced manual data preparation time  
- Enabled geographic and time-based insights  
- Built a foundation for business intelligence
