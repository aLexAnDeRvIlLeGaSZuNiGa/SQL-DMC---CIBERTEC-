---- Para situarnos en la bd que requerimos 
---sql no es case sensitive(no toma importancia el mayus)

USE Northwind

-------------------------------------------- 
-------------DML-------------
--SELECT
---MOSTRANDO TODOS LO CAMPOS
SELECT *
FROM Employees
---QUIERO LOS CAMPOS DE LAST_NAME, FIRST NAME, EMPLOYEEID
SELECT LastName , FirstName , EmployeeID
FROM Employees
---PARA FILTRAR LOS DATOS 
---WHERE

---FILTRAR EL EMPLEADO QUE TENGA DE ID=5
SELECT *
FROM Employees
WHERE EmployeeID=5
---FILTRAR  EL EMPLEADO QUE TENGA COMO FIRST NAME = STEVEN
SELECT *
FROM Employees
WHERE Firstname ='Steven'
---FILTRAR LAS VENTAS QUE SE HAYAN ENVIADO AL PAIS DE FRANCIA 
SELECT *
FROM Orders 
WHERE ShipCountry = 'France' 
---NECESITO SABER LAS ORDENES QUE FUERON ENVIADAS A FRANCIA Y A LA CIUDAD Lyon
---AND
SELECT *
FROM Orders 
WHERE ShipCountry = 'France' AND ShipCity = 'Lyon'
--- NECESITO SABER LAS ORDENES QUE FUERON ENVIADAS A FRANCIA Y BELGICA 
SELECT * 
FROM Orders 
WHERE ShipCountry= 'France' or Shipcountry= 'Belgium'
---LAS VENTAS QUE SE ENVIARON A FRANCIA O BELGICA Y QUE LO REALIZO EL EMPLEADO 5 
SELECT * 
FROM Orders 
WHERE (ShipCountry= 'France' or Shipcountry= 'Belgium') and EmployeeID= 5
---IN
SELECT *
FROM Orders
WHERE ShipCountry IN('FRANCE','BELGIUM','AUSTRIA','BRAZIL')

SELECT*
FROM Orders
where EmployeeID IN (1,2,3,4)
---LIKE
---NECESITO SABER TODAS LAS PERSONAS QUE COMIENZAN SU CONTACT NAME CON LA LETRA A 
SELECT *
FROM Customers
WHERE ContactName LIKE 'A%'
---NECESITO SABER LAS PERSONAS QUE TERMINAN CON LA LETRA R
SELECT *
FROM Customers
WHERE ContactName LIKE '%R'
---LAS PERSONAS QUE CONTENGAN LA LETRA B EN EL CONTACT NAME 
SELECT *
FROM Customers
WHERE ContactName LIKE '%B%'
---NUMERICOS 
SELECT *
FROM Orders 
where Freight=32.38
---QUE LA VENTA TOTAL SEA MAYOR A 50 

SELECT *
FROM Orders 
WHERE Freight >= 50 
---LAS ORDENES QUE TENGAN COMO VENTA TOTAL ENTRE 50 Y 100 
---Filtrar informacion en rangos de numeros
SELECT *
FROM Orders 
WHERE Freight >= 50 and Freight <= 100 
---BETWEEN
SELECT *
FROM Orders 
WHERE Freight BETWEEN 50 AND 100
---QUIERO LAS VENTAS QUE SE HAYAN REALIZADO ENTRE 01-03-1998 Y 30-03-1998
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '01-03-1998' AND '30-03-1998'
---LAS VENTAS HASTA LA FECHA DE HOY
SELECT *
FROM Orders
WHERE ORDERDATE BETWEEN '1998-03-01' AND GETDATE()
---FECHA DE HOY GETDATE() 
SELECT GETDATE ()
----COUNT(*), SUM(), AVG(), MAX() , MIN()
SELECT count(*) AS cantidad, sum(Freight) as suma, AVG(Freight) as promedio, Max(Freight) as maxima, MIN(freight) as minimo
FROM Orders 
---PROFESOR, que hariamos si hubiera una fila repetida y no queremos que sea contada 
---distinct ---funcion para obtener un unico valor a mostrar 
SELECT COUNT(distinct EmployeeID)---830
from Orders
select distinct Employeeid
from orders 
select employeeid
from orders 
---------------------
SELECT count(*) AS cantidad, sum(Freight) as suma, AVG(Freight) as promedio, Max(Freight) as maxima, MIN(freight) as minimo
FROM Orders 
----La cantidad de ordenes vendidas por cada empleado
---group by(agrupa por campo)
select EmployeeID, count(*) as cantidad, sum(freight) as venta_empleado,
                    MAX(Freight) as venta_maxima_empleado , min(freight) as venta_minima_por_empleado
from Orders
group by Employeeid
SELECT *
FROM Orders 
select EmployeeID, count(employeeid) as cantidad, sum(freight) as venta_empleado,
                    MAX(Freight) as venta_maxima_empleado , min(freight) as venta_minima_por_empleado
from Orders
group by EmployeeID
---CORTE DE INFORMACION POR EMPLEADO Y PAIS DE ENVIO 
select ShipCountry,EmployeeID, count(*) as cantidad, sum(freight) as venta_empleado,
                    MAX(Freight) as venta_maxima_empleado , min(freight) as venta_minima_por_empleado
from Orders
group by ShipCountry, EmployeeID
---ORDER BY 
select ShipCountry,EmployeeID, count(*) as cantidad, sum(freight) as venta_empleado,
                    MAX(Freight) as venta_maxima_empleado , min(freight) as venta_minima_por_empleado
from Orders
group by ShipCountry, EmployeeID
ORDER BY 3,ShipCountry, employeeid desc
---top
select top 10 *
 from orders 
 ------El top 3 de los mas vendidos 
select top 3 EmployeeID, count(*) as cantidad
from Orders
group by Employeeid
order by 2 desc
---having siempre va acompañado del group by 
---necesito saber los empleados que han tenido mas de 50 ventas 
select EmployeeID, count(*) as cantidad
from Orders
group by Employeeid

select EmployeeID, count(*) as cantidad
from Orders
group by Employeeid
having count(*)>50