-- Creaciones de tablas
USE TSQL2022
GO

CREATE TABLE dbo.Region
(
  RegionID				int					NOT NULL,
  RegionDescription		varchar(100)		NOT NULL,
  )
GO

CREATE TABLE dbo.Territories
(
  TerritoryID			char(05)			NOT NULL,
  TerritoryDescription	varchar(100)		NOT NULL,
  RegionID				int					NOT NULL
)
GO 
DROP TABLE dbo.Employees
CREATE TABLE dbo.Employees
(
   EmployeeID			int			NOT NULL,
   LastName				varchar(20)	NOT NULL,
   FirstName			varchar(10)	NOT NULL,
   Title				varchar(30)	 NULL,
   TitleOfCourtesy		varchar(25)  NULL,
   BirthDate			datetime     NULL,
   HireDate				datetime	 NULL,
   Address				varchar(60)	 NULL,
   City					varchar(15)	 NULL,
   Region				varchar(15)  NULL,
   PostalCode			varchar(10)  NULL,
   Country				varchar(15)	 NULL,
   HomePhone			varchar(24)	 NULL,
   Extension			varchar(4)	 NULL,
   Photo				image		 NULL,
   Notes				varchar(max) NULL,
   ReportsTo			int			 NULL,
   PhotoPath			varchar(255) NULL
)
GO
