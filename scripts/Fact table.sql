/*
Create and populate fact_HIV_metrics table

*/

CREATE TABLE fact_HIV_metrics (
	fact_ID INT IDENTITY (1,1) PRIMARY KEY,
	Country VARCHAR (150),
	[Year] INT,
	population BIGINT NULL,
	male_population BIGINT NULL,
	female_population BIGINT NULL,
	GDP_per_Capita FLOAT NULL,
	life_expectancy FLOAT NULL,
	health_expenditure FLOAT NULL,
	people_living_with_HIV BIGINT NULL,
	new_HIV_infections BIGINT NULL,
	AIDS_deaths BIGINT NULL
	);

INSERT INTO fact_HIV_metrics (
	Country,
	[Year],
	population,
	male_population,
	female_population,
	GDP_per_Capita,
	life_expectancy,
	health_expenditure,
	people_living_with_HIV,
	new_HIV_infections,
	AIDS_deaths 
)	
SELECT
	Country,
	[Year],
	Population,
	Male_population,
	Female_population,
	GDP_per_Capita,
	Life_Expectancy,
	Health_Expenditure,
	People_Living_With_HIV,
	New_HIV_Infections,
	AIDS_deaths
FROM [dbo].[clean_aids_dataset]
WHERE Country IS NOT NULL
AND [Year] IS NOT NULL
AND new_HIV_infections IS NOT NULL
AND AIDS_Deaths IS NOT NULL;

SELECT * FROM fact_HIV_metrics;