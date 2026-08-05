# End-to-End Global HIV/AIDS Analytics Portfolio Project

An end-to-end data analytics project featuring custom table architecture engineered in SSMS and a star schema modeled in Power BI to analyze socioeconomic impacts on global HIV/AIDS outcomes.

### 🎯 Project Overview & Purpose
This project transforms raw, historical global health records into an executive decision-making tool. The data lifecycle begins at the database tier, where a clean and optimized table architecture was engineered using SQL Server Management Studio (SSMS). These structured tables were then imported into Power BI, where an industry-standard **Star Schema** relational model was built to link dimensional attributes seamlessly to transitional health metrics. 

The central purpose of this analysis is to evaluate the relationship between economic development and public health outcomes. By tracking metrics against World Bank Income Groups, this dashboard explicitly illustrates the deep association between national wealth and disease management. It highlights how economic stratification dictates a country's ability to stop new infections, manage disease burden, and keep patients alive.

## 👥 Audience & Project Intent
This repository houses an end-to-end data analytics project engineered explicitly as a technical showcase for **Data Portfolio Reviewers**. It demonstrates production-level proficiency across the full data lifecycle: **Database Engineering (SSMS), Relational Dimensional Modeling (Star Schema), and User-Centric Power BI Dashboard Design.**

## 🏗️ Relational Data Modeling (Star Schema)
To optimize data processing, reduce redundancy, and leverage Power BI's internal VertiPaq engine efficiently, the raw flat dataset was decomposed into an industry-standard **Star Schema** within SQL Server. 

The dimension tables utilize unique primary keys (`Country` and `Year`), mapping natively into the core transactional Fact table without heavy SQL join scripts, intentionally leaving raw text fields intact for agile front-end Power Query transformations.

## 💻 Database Engineering & Schema Definition (SSMS)

```sql
-- 1. Create Location Dimension Table
CREATE TABLE dim_Location (
    Country VARCHAR(150) PRIMARY KEY,
    ISO_Code VARCHAR(10) NULL,
    World_Bank_Region VARCHAR(100) NULL,
    Income_Group VARCHAR(100) NULL
);

-- 2. Create Time Dimension Table
CREATE TABLE dim_Time (
    [Year] INT PRIMARY KEY
);

-- 3. Create Optimized Fact Table (Data Types Managed to Prevent Integer Overflows)
CREATE TABLE fact_HIV_Metrics (
    Fact_ID INT IDENTITY(1,1) PRIMARY KEY,
    Country VARCHAR(150) FOREIGN KEY REFERENCES dim_Location(Country),
    [Year] INT FOREIGN KEY REFERENCES dim_Time([Year]),
    Population BIGINT NULL,
    Male_Population BIGINT NULL,
    Female_Population BIGINT NULL,
    GDP_per_Capita FLOAT NULL,
    Life_Expectancy FLOAT NULL,
    Health_Expenditure FLOAT NULL,
    People_Living_With_HIV BIGINT NULL,
    New_HIV_Infections BIGINT NULL,
    AIDS_Deaths BIGINT NULL
);
```

## 🧮 Advanced DAX Optimization
Calculations strictly leverage modern DAX frameworks. Variables (`VAR`/`RETURN`) are implemented across all calculations to evaluate metrics once, significantly reducing processing overhead during dashboard cross-filtering.

### 1. Total People Living with HIV (PLHIV)
```DAX
Total PLHIV = SUM(fact_HIV_Metrics[People_Living_With_HIV])
```

### 2. Calculated HIV Prevalence Rate %
```DAX
HIV Prevalence Rate % = 
VAR TotalInfected = [Total PLHIV]
VAR TotalPopulation = SUM(fact_HIV_Metrics[Population])
RETURN
    DIVIDE(TotalInfected, TotalPopulation) * 100
```

### 3. Mortality-to-Prevalence Ratio %
```DAX
Mortality to Prevalence Ratio % = 
VAR AnnualDeaths = SUM(fact_HIV_Metrics[AIDS_Deaths])
VAR CurrentCases = [Total PLHIV]
RETURN
    DIVIDE(AnnualDeaths, CurrentCases) * 100
```

### 4. Total AIDS Deaths
```DAX
Total AIDS Deaths = SUM(fact_HIV_Metrics[AIDS_Deaths])
```

### 5. Total New Infections
```DAX
Total New Infections = SUM(fact_HIV_Metrics[New_HIV_Infections])
```
---

## 🎨 User-Centric Dashboard UI/UX Design

The visual application is structured following cognitive load-reduction design principles, adopting a strict geometric grid format.


