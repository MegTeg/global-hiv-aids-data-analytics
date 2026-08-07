/*
Create and populate dim_time table

*/

CREATE TABLE dim_time (
	[Year] INT PRIMARY KEY
);

INSERT INTO dim_time ([Year])
	SELECT DISTINCT [Year]
	FROM [dbo].[clean_aids_dataset]
	WHERE [Year] IS NOT NULL;

SELECT * FROM dim_time;
