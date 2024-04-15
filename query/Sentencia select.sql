-- Ejercicios Clausula SELECT
USE NORTHWND
GO
-- Consulta para conocer todas las columnas
SELECT *
FROM Employees

--Enunciado N°1
--a) Liste las columnas EmployeeID, TitleOfCourtesy, LastName, FirstName,  
--Title de la tabla Employees

SELECT EmployeeID, TitleOfCourtesy, LastName, FirstName
FROM Employees

--b)Liste las columnas OrderID, CustomerID, EmployeeID, 
--OrderDate, RequiredDate, ShippedDate de la tabla Orders.
SELECT *
FROM Orders
SELECT OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate
FROM Orders
--c) Liste las columnas CustomerID, CompanyName, ContactName, ContactTitle, Address, 
--City, Country de la tabla Customers.
SELECT CustomerID, CompanyName, ContactName
FROM Customers