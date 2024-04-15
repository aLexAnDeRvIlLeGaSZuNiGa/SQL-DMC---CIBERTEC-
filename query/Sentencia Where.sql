-- Enunciado N°2
--a. Liste las columnas CustomerID, CompanyName, Address, City, PostalCode, Country de 
--la tabla Customers en donde el Country sea igual a 'Spain'.
SELECT *
FROM Customers
WHERE Country = 'Spain'
--b. Liste las columnas CustomerID, CompanyName, Address, City, PostalCode, Country de 
--la tabla Customers en donde el Country sea igual a 'Spain' y el City sea ‘Madrid’ o 
--‘Sevilla’.
SELECT *
FROM Customers
WHERE Country = 'Spain' AND (City = 'Madrid' OR City = 'Sevilla')
--c. Liste todas las columnas de la tabla Products en donde la columna CategoryID sea igual 
--a 1 o 4 o 7.
SELECT * 
FROM Products
WHERE CategoryID = 1
OR CategoryID = 4
OR CategoryID = 7
--d. Liste las columnas ProductID, ProductName, QuantityPerUnit, UnitPrice de la tabla 
--Products en donde el UnitPrice esté entre 15.00 y 38.00
SELECT *
FROM Products
WHERE UnitPrice > 15 AND UnitPrice < 38
--Ejercicio 3: Crear una consulta utilizando la cláusula WHERE / ORDER BY.
--a. Modifique la consulta a) del Ejercicio 6.2 y ordénelo por el campo CompanyName en 
--forma ascendente.
SELECT *
FROM Customers
WHERE Country = 'Spain'
ORDER BY CompanyName ASC
--b. Modifique la consulta b) del Ejercicio 6.2 y ordénelo por el campo City en forma 
--ascendente y el campo PostalCode en forma descendente
SELECT *
FROM Customers
WHERE Country = 'Spain' AND (City = 'Madrid' OR City = 'Sevilla')
ORDER BY City ASC, PostalCode DESC