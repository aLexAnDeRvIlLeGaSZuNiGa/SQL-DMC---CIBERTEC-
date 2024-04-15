----------
-----INSERCCION CAPTURANDO EL RESULTADO(SOLO AGREGAR INTO TEMP_EMPLEADOS)
select *
from TEMP_EMPLEADOS
SELECT EmployeeID, FirstName, [Address], Region INTO TEMP2_EMPLEADOS
FROM [dbo].[Employees]
WHERE Region='WA'

---INSERCCION MASIVA
set IDENTITY_INSERT TEMP_EMPLEADOS on-----si te sale el mensaje de identity_insert of
INSERT INTO TEMP_EMPLEADOS
  (EmployeeID, FirstName,[Address])---se puede insertar en otra columna pero con igual tipo de dato
SELECT EmployeeID, FirstName, [Address]
FROM [dbo].[Employees]
WHERE Region='WA'
set IDENTITY_INSERT TEMP_EMPLEADOS off---si te sale el mensaje de identity_insert of
------------------------------------
-----------conversion de datos -----
-------------------------------------
-------CAST   -- CONVERT
---DE NUMERICO A TEXTO
SELECT CAST(23 AS VARCHAR(30)) AS NUMERO_TEXTO INTO TP_DATO3

SELECT CONVERT( VARCHAR(30),23) AS NUMERO_TEXTO INTO TP_DATO4

-----DE TEXTO A NUMERICO
SELECT CAST('23' AS INT) AS NUMERO, '23' AS DATO
--INTO TP_DATO

SELECT CONVERT(INT, '23') AS NUMERO INTO TP_DATO2
---De fecha a texto 
select*
from employees
select cast(format(getdate(),'dd/MM/yyyy') as varchar(30))---es 'dd/MM/yyyy' no 'dd/mm/yyyy'
select employeeid, birthdate, cast(format( birthdate,'dd/MM/yyyy') as varchar(30)) as fec_dia into tp2_datos
from employees
select* from convert_datos
select* from tp2_datos
----convert es similar al cast solo se cambia el orden 
select convert(varchar(30),format(getdate(),'dd/MM/yyyy'))---es 'dd/MM/yyyy' no 'dd/mm/yyyy'
select employeeid, birthdate, cast(format( birthdate,'dd/MM/yyyy') as varchar(30)) as fec_dia into convert_datos
from employees

---de texto a fecha 
select cast('2020-01-01' as date) as dato into tp_dato7
select convert(DATE,'2020-01-01') as dato into tp_dato8 
select* from tp_dato7

-----------------------------------------------------------------
-------------------restricciones---------------------------------
------------------------------------------------------------------
---------PRIMARI KEY---INTEGRIDAD DE DATO 
   CREATE TABLE TK_CLIENTE (
   COD_CLIENTE INT,
   NOM_CLIENTE VARCHAR(50),
   CONSTRAINT PK_T_CLIENTE PRIMARY KEY (COD_CLIENTE) 
   )
   INSERT INTO TK_CLIENTE
   (COD_CLIENTE, NOM_CLIENTE)
   VALUES(1,'JUAN')
   INSERT INTO TK_CLIENTE
   (COD_CLIENTE, NOM_CLIENTE)
   VALUES(2,'JOSE')
   INSERT INTO TK_CLIENTE
   (COD_CLIENTE, NOM_CLIENTE)
   VALUES(2,'MARIA')---ERROR PORQUE YA EXISTE 2 QUE ES JOSE
   SELECT*
   FROM [dbo].[TEMP2_EMPLEADOS]
   ---SINTAXIS CUANDO LA TABLA SE HA CREADO PERO NO SE DEFINIO EL PRIMARY KEY
   ALTER TABLE [dbo].[TEMP2_EMPLEADOS]
   ADD CONSTRAINT PK_NOMBRE_PK PRIMARY KEY (EmployeeID)----PERO SI HAY DUPLICADOS  
   ----SINTAXIS PARA ELIMINAR UN CONSTRAINT DE UNA TABLA 
   ALTER TABLE TEMP2_EMPLEADOS
   DROP CONSTRAINT PK_NOMBRE_PK;
   ----BUSCAR LOS CONSTRAINT EN LA BASE DE DATOS 
   SELECT *
   FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
   WHERE TABLE_NAME='TK_CLIENTE'
   ---OTRA FORMA 
   SELECT *
   FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
   WHERE TABLE_NAME='TK_CLIENTE'
   ---OTRO CONSTRAINT                  
   ----------------------FOREIGN KEY-----------------------------------
   ----CREAMOS LA TABLA CON EL FOREIGN KEY
   CREATE TABLE T_VENTA
   (ID_VENTA INT PRIMARY KEY,
   COD_CLIENTE INT,
   MONTO DECIMAL(18,2),
   FECHA DATE, 
   CONSTRAINT FK_VENTAS_CLIENTE FOREIGN KEY (COD_CLIENTE)
   REFERENCES TK_CLIENTE (COD_CLIENTE)
   ) 
   ---INSERTAMOS REGISTROS DE VENTA 
   INSERT INTO T_VENTA
   (ID_VENTA, COD_CLIENTE, MONTO, FECHA)
   VALUES(1,1,40,GETDATE())
   INSERT INTO T_VENTA
   (ID_VENTA, COD_CLIENTE, MONTO, FECHA)
   VALUES(2,2,40,GETDATE())
   SELECT *
      FROM T_VENTA
   SELECT *
   FROM TK_CLIENTE

   ------------------------------------------------------------
   ---------INNER JOIN
   --------TE OBTIENE EL CRUCE DE AMBAS TABLAS 
   SELECT CustomerID, ContactName
   FROM [dbo].[Customers]----91
   SELECT *
   FROM [dbo].[Orders]---830
    
   SELECT *  ---select count(*) resulta 830
   FROM CUSTOMERS A
   INNER JOIN Orders B ON A.CustomerID=B.CustomerID
   ----para relacionar algunas columnas 
   SELECT A.CustomerID, A.ContactName, B.*
   FROM CUSTOMERS A
   INNER JOIN Orders B ON A.CustomerID=B.CustomerID
   ORDER BY A.CustomerID

   ----EL MONTO QUE SE HA VENDIDO A CADA CLIENTE 

   SELECT A.CompanyName,SUM(B.Freight) as VENTA
   FROM CUSTOMERS A
   INNER JOIN Orders B ON A.CustomerID=B.CustomerID
   GROUP BY A.CompanyName
   ORDER BY A.CompanyName
   ---la cantidad vendida a cada cliente 
   SELECT A.CompanyName, COUNT(*) AS CNT_VENDIDA
   FROM CUSTOMERS A
   INNER JOIN Orders B ON A.CustomerID=B.CustomerID
   --WHERE A.CustomerID='ALFKI'
   GROUP BY A.CompanyName
 --HAVING COUNT(*)>6----CLIENTES QUE SE VENDIO MAS DE 6 VECES
-- ORDER BY 2

--Saber los duplicados de la tabla
SELECT OrderID
FROM [dbo].[Order Details]
select OrderID, COUNT(*)
from [dbo].[Order Details]
GROUP BY OrderID
HAVING COUNT(*)>1   
-----La cantidad vendida a cada cliente e indicar si compro o no compro 
SELECT A.* , B.*
FROM CUSTOMERS A
LEFT JOIN Orders B ON A.CustomerID=B.CustomerID
ORDER BY OrderID

 SELECT A.CompanyName,ISNULL(SUM(B.Freight),0) as VENTA
 FROM CUSTOMERS A
 LEFT JOIN Orders B ON A.CustomerID=B.CustomerID
 GROUP BY A.CompanyName
 ORDER BY VENTA
---------------
 SELECT A.* , B.*
FROM  Orders  A
LEFT JOIN CUSTOMERS B ON A.CustomerID=B.CustomerID
ORDER BY OrderID
---los clientes a los cuales no les he vendido 
SELECT A.* , B.*
FROM CUSTOMERS A
LEFT JOIN Orders B ON A.CustomerID=B.CustomerID
WHERE B.CustomerID is null
ORDER BY OrderID

------right join
SELECT A.* , B.*
FROM CUSTOMERS A
RIGHT JOIN Orders B ON A.CustomerID=B.CustomerID

------Full outer join 
SELECT A.* , B.*
FROM CUSTOMERS A
FULL OUTER JOIN Orders B ON A.CustomerID=B.CustomerID
-----------------------------------------------------
---SABER LA LISTA DE EMPLEADOS Y CANTIDAD DE VENTAS POR CADA CLIENTES ATENDIDO 

SELECT TOP 5 *
FROM Customers

SELECT TOP 5 *
FROM Orders

SELECT TOP 5 *
FROM Employees
------------------------------------------------------------------------------
---SABER LA LISTA DE EMPLEADOS Y CANTIDAD DE VENTAS POR CADA CLIENTES ATENDIDO 
SELECT C.FirstName, A.CompanyName,COUNT(*) AS CANT ,SUM(B.Freight) AS VENTA 
FROM CUSTOMERS A
INNER JOIN Orders B ON A.CustomerID=B.CustomerID
INNER JOIN Employees C ON C.EmployeeID=B.EmployeeID
GROUP BY C.FirstName, A.CompanyName
ORDER BY 1

-------SUBQUERY

SELECT *
FROM [dbo].[Order Details] A
WHERE OrderID IN ( select OrderID
                   FROM [dbo].[Order Details]
                   GROUP BY OrderID
                   HAVING COUNT(*)>1 )
Order by A.OrderID
-----SUBQUERY LEFT INNER JOIN

 select *
 from [dbo].[Order Details] A
 inner join  (
select OrderID, COUNT(*) AS CANT
 FROM [dbo].[Order Details]
 GROUP BY OrderID
 HAVING COUNT(*)>1) B on A.OrderID=B.OrderID
 ORDER BY A.OrderID

-----CON UN SOLO REGISTRO 
SELECT *
FROM [dbo].[Order Details] A
WHERE OrderID = ( select TOP 1 OrderID
                   FROM [dbo].[Order Details]
                   GROUP BY OrderID
                   HAVING COUNT(*)>1 )
Order by A.OrderID
