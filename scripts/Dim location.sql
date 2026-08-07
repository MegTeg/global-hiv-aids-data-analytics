/* 
Create and populate dim_location table

*/


CREATE TABLE dim_location (
	Country NVARCHAR(150) PRIMARY KEY,
	ISO_Code NVARCHAR(10) NULL,
	World_Bank_Region NVARCHAR(100) NULL,
	Income_Group VARCHAR(100) NULL
	);

INSERT INTO dim_location (Country,ISO_Code,World_Bank_Region,Income_Group)
	SELECT DISTINCT
			Country,
			ISO_Code,
			World_Bank_Region,
			Income_Group
	FROM [dbo].[clean_aids_dataset]
	WHERE Country IS NOT NULL;

SELECT * FROM dim_location;