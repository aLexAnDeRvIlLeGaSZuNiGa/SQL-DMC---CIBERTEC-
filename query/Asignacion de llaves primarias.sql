-- Asignación de Llaves Primarias (Primary KEY)
USE TSQL2022
GO

ALTER TABLE dbo.Region
	ADD CONSTRAINT PK_Region PRIMARY KEY CLUSTERED (RegionID)
GO

ALTER TABLE dbo.Territories
  ADD CONSTRAINT PK_Territories PRIMARY KEY CLUSTERED (TerritoryID)
GO

ALTER TABLE dbo.Employees
    ADD CONSTRAINT PK_Employees PRIMARY KEY CLUSTERED (EmployeeID)
GO
