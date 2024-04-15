----Necesito las ventas por region, pero la suma por anio 

SELECT top 5 * 
FROM Region 

SELECT top 5 *
FROM Territories 

SELECT top 5 *
FROM EmployeeTerritories

SELECT top 5  *
FROM Employees
/*
SELECT DISTINCT D.RegionDescription, D.RegionID, A.EmployeeID ---INTO DimRegionEmpleado
FROM Employees A
INNER JOIN EmployeeTerritories B ON A.EmployeeID=B.EmployeeID
INNER JOIN Territories C ON B.TerritoryID = C.TerritoryID
INNER JOIN Region D ON C.RegionID=D.RegionID
GROUP BY D.RegionDescription, D.RegionID, A.EmployeeID*/

SELECT D.RegionDescription, D.RegionID, A.EmployeeID INTO DimRegionEmpleado
FROM Employees A
INNER JOIN EmployeeTerritories B ON A.EmployeeID=B.EmployeeID
INNER JOIN Territories C ON B.TerritoryID = C.TerritoryID
INNER JOIN Region D ON C.RegionID=D.RegionID
GROUP BY D.RegionDescription, D.RegionID, A.EmployeeID

SELECT *
FROM DimRegionEmpleado

SELECT B.RegionDescription ,YEAR(A.OrderDate) AS ANIO, SUM(A.Freight) AS Total
FROM Orders A
INNER JOIN DimRegionEmpleado B ON A.EmployeeID=B.EmployeeID
GROUP BY B.RegionDescription, A.OrderDate

------Pivot  
SELECT * --INTO TP_PIVOT--RP.RegionDescription, RP.[1996] AS ANIO_1996
     FROM ( SELECT B.RegionDescription ,YEAR(A.OrderDate) AS ANIO, SUM(A.Freight) AS Total ---QUERY INSUMO
            FROM Orders A
            INNER JOIN DimRegionEmpleado B ON A.EmployeeID=B.EmployeeID
            GROUP BY B.RegionDescription, A.OrderDate ) AS PV
	 pivot ( SUM(Total)---FUNCION AGREGACION
	         FOR ANIO IN ([1996],[1997],[1998])----VALORES DE UNA COLUMNA QUE AHORA SE CONVERTIRAN EN OTRAS COLUMNAS
			 ) AS RP                           ----INDEPENDIENTES

SELECT *---RP.RegionDescription,RP.[1996] AS ANIO_1996
     FROM ( SELECT B.RegionDescription ,MONTH(A.OrderDate) AS MES, SUM(A.Freight) AS Total ---QUERY INSUMO
            FROM Orders A
            INNER JOIN DimRegionEmpleado B ON A.EmployeeID=B.EmployeeID
            GROUP BY B.RegionDescription, A.OrderDate ) AS PV
	 pivot ( SUM(Total)---FUNCION AGREGACION
	         FOR MES IN ([1],[2],[3],[4],[5],[6],[7],[8])----VALORES DE UNA COLUMNA QUE AHORA SE CONVERTIRAN EN OTRAS COLUMNAS
			 ) AS RP                                     ----INDEPENDIENTES

---------- pivot table dinamico

DECLARE @QUERY AS NVARCHAR(max)
DECLARE @COLUMNA AS NVARCHAR(max)

--------obteniendo todos los meses de ventas
      ---DROP TABLE TEMP_MES
	  SELECT MONTH(OrderDate) AS Months --into temp_mes 
	  From Orders
	  GROUP BY MONTH(OrderDate)

------Dando forma a la variable del for 
      select  @COLUMNA = ISNULL(@COLUMNA+',','')+ QUOTENAME(MONTHS)----QUOTENAME ES PARA PONER CORCHETES
	  FROM ( SELECT *
	         FROM TEMP_MES) AS MONTHS

------QUERY DINAMICO A EJECUTAR 
      SET @QUERY = 'SELECT *
     FROM ( SELECT B.RegionDescription ,MONTH(A.OrderDate) AS MES, SUM(A.Freight) AS Total ---QUERY INSUMO
            FROM Orders A
            INNER JOIN DimRegionEmpleado B ON A.EmployeeID=B.EmployeeID
            GROUP BY B.RegionDescription, A.OrderDate ) AS PV
	 pivot ( SUM(Total)---FUNCION AGREGACION
	         FOR MES IN ('+@COLUMNA+')----VALORES DE UNA COLUMNA QUE AHORA SE CONVERTIRAN EN OTRAS COLUMNAS
			 ) AS RP'
      PRINT (@QUERY)
	  EXEC SP_EXECUTESQL @QUERY

-----pibot table adicional

SELECT D.RegionDescription,C.TerritoryDescription, D.RegionID, A.EmployeeID INTO DimTerriEmpleado
FROM Employees A
INNER JOIN EmployeeTerritories B ON A.EmployeeID=B.EmployeeID
INNER JOIN Territories C ON B.TerritoryID = C.TerritoryID
INNER JOIN Region D ON C.RegionID=D.RegionID
GROUP BY D.RegionDescription,C.TerritoryDescription, D.RegionID, A.EmployeeID

---query insumo
            SELECT B.RegionDescription ,b.TerritoryDescription,YEAR(A.OrderDate) AS ANIO, SUM(A.Freight) AS Total ---QUERY INSUMO
            FROM Orders A
            INNER JOIN DimTerriEmpleado B ON A.EmployeeID=B.EmployeeID
            GROUP BY B.RegionDescription ,b.TerritoryDescription, A.OrderDate
SELECT * 
     FROM ( SELECT B.RegionDescription ,b.TerritoryDescription,YEAR(A.OrderDate) AS ANIO, SUM(A.Freight) AS Total ---QUERY INSUMO
            FROM Orders A
            INNER JOIN DimTerriEmpleado B ON A.EmployeeID=B.EmployeeID
            GROUP BY B.RegionDescription ,b.TerritoryDescription, A.OrderDate ) AS PV
	 pivot ( SUM(Total)---FUNCION AGREGACION
	         FOR ANIO IN ([1996],[1997],[1998])----VALORES DE UNA COLUMNA QUE AHORA SE CONVERTIRAN EN OTRAS COLUMNAS
			 ) AS RP                           ----INDEPENDIENTES

------------------UNPIVOT 

-----Creando la tabla insumo
SELECT *  
     FROM ( SELECT B.RegionDescription ,YEAR(A.OrderDate) AS ANIO, SUM(A.Freight) AS Total 
            FROM Orders A
            INNER JOIN DimRegionEmpleado B ON A.EmployeeID=B.EmployeeID
            GROUP BY B.RegionDescription, A.OrderDate ) AS PV
	 pivot ( SUM(Total)
	         FOR ANIO IN ([1996],[1997],[1998])
			 ) AS RP      
			 
select*
from TP_PIVOT 

select *
FROM TP_PIVOT
UNPIVOT ( VENTA ----Nombre de columna que alojara los datos numericos cruzados
          FOR ANIO  ----Nombre de la nueva columna que alojara las cabeceras de columna de la tabla 
		  IN ([1996],[1997],[1998])---Lista las columnas de la tabla que seran filas 
              ) AS PVIT

------------FUNCIONES COMPLEMENTARIAS DE GROUP BY

SELECT TOP 5*
FROM [Order Details] 

SELECT TOP 5*
FROM Products 

SELECT TOP 5*
FROM Categories

SELECT C.CategoryName, B.ProductName, sum(A.UNITPRICE*A.QUANTITY) AS VENTA
FROM [Order Details] A
LEFT JOIN Products B ON A.ProductID=B.ProductID
LEFT JOIN Categories C ON B.CategoryID=C.CategoryID
GROUP BY C.CategoryName, B.ProductName
ORDER BY 1 

------ROLL UP

SELECT C.CategoryName,isnull(B.ProductName,'-----SUB TOTAL-----') AS Producto, sum(A.UNITPRICE*A.QUANTITY) AS VENTA
FROM [Order Details] A
LEFT JOIN Products B ON A.ProductID=B.ProductID
LEFT JOIN Categories C ON B.CategoryID=C.CategoryID
GROUP BY ROLLUP(C.CategoryName, B.ProductName) 

-----CUBE

SELECT C.CategoryName, B.ProductName,GROUPING_ID(C.CategoryName,b.ProductName) AS ID,
sum(A.UNITPRICE*A.QUANTITY) AS VENTA
FROM [Order Details] A
LEFT JOIN Products B ON A.ProductID=B.ProductID
LEFT JOIN Categories C ON B.CategoryID=C.CategoryID
GROUP BY CUBE(C.CategoryName, B.ProductName)
ORDER BY 3

-----GROUPING SET(CASO PARTICULAR DE CUBE)

SELECT C.CategoryName, B.ProductName, sum(A.UNITPRICE*A.QUANTITY) AS VENTA
FROM [Order Details] A
LEFT JOIN Products B ON A.ProductID=B.ProductID
LEFT JOIN Categories C ON B.CategoryID=C.CategoryID
GROUP BY GROUPING SETS(C.CategoryName, B.ProductName)

-----SUB CONSULTAS
-----OBTENER LOS CLIENTES QUE HAN HECHO UNA COMPRA POR LO MENOS 
SELECT *
FROM Customers
WHERE CustomerID IN ( SELECT CustomerID
FROM Orders )
----exists, not exists
SELECT *
FROM Customers A
WHERE NOT EXISTS (SELECT CustomerID 
                  from Orders B 
			      WHERE B.CustomerID=A.CustomerID) 

----OBTENER LAS ORDENES DEL PRODUCTO 42
----CUANDO LAS UNIDADES SUPEREN LA CANT DE 10

SELECT *
FROM Orders A
WHERE ( SELECT B.Quantity
        FROM [Order Details] B
		WHERE B.ProductID=42 AND A.OrderID=B.OrderID)>10
		---SELECT *
        ---FROM Orders A

------WITCH CTE

WITH ListaOrdenes as(
                     select C.CustomerID, DATEPART(Year,o.OrderDate) Anio,
					         od.Quantity * od.UnitPrice as SubTotal
					 from Customers c
					 join Orders o on c.CustomerID=o.CustomerID
					 join [Order Details] od on od.OrderID=o.OrderID
					 join Products p on p.ProductID = od.ProductID
					 )
select *
from ListaOrdenes
where Anio=1996

-------------VISTAS
CREATE VIEW V_VENTAS AS 
select C.CustomerID, DATEPART(Year,o.OrderDate) Anio,
					         od.Quantity * od.UnitPrice as SubTotal
					 from Customers c
					 join Orders o on c.CustomerID=o.CustomerID
					 join [Order Details] od on od.OrderID=o.OrderID
					 join Products p on p.ProductID = od.ProductID
					 WHERE DATEPART(Year,o.OrderDate)=1996
---ELIMINAR UNA VISTA
DROP VIEW V_VENTAS

---ACTUALIZO UNA VISTA
ALTER VIEW V_VENTAS AS 
select C.CustomerID, DATEPART(Year,o.OrderDate) Anio,
					         od.Quantity * od.UnitPrice as SubTotal
					 from Customers c
					 join Orders o on c.CustomerID=o.CustomerID
					 join [Order Details] od on od.OrderID=o.OrderID
					 join Products p on p.ProductID = od.ProductID
					 WHERE DATEPART(Year,o.OrderDate)=1997

---CONSULTANDO LA VISTA 
SELECT *
FROM V_VENTAS