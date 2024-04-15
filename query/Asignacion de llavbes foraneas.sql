--Asignación de llaves foraneas (FOREIGN KEY)
USE TSQL2022
GO

ALTER TABLE dbo.Territories
     ADD CONSTRAINT FK_Territories_Region FOREIGN KEY (RegionID)
	 REFERENCES dbo.Region (RegionID)
GO
