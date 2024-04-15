---MENSAJE DE LA NACION 
---ALERTA ESTO ES IMPORTANTE
---ME SIRVE PARA VER EL LISTADO DE TABLAS PARA UNA BD
SELECT *
FROM INFORMATION_SCHEMA.TABLES
---ME SIRVE PARA VER LAS COLUMNAS DE LAS TABLAS DE UNA BD
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Suppliers'
---schema=.dbo
---creando un schema
create schema JP
create table jp.cliente( cod int, nombre varchar(50))
-------------------------FUNCIONES DE TEXTO 
---CONCAT
--NECESITAMOS EL NOMBRE COMPLETO DE LA PERSONA (APELLIDO,NOMBRE)
SELECT*
FROM Employees
----
select LastName, FirstName, concat(LastName,' ',FirstName) AS Nombre_Completo
FROM Employees
---CHARINDEX
--DEVUELVE LA POSICION DEL VALOR A BUSCAR 

SELECT FirstName, CHARINDEX ('A',Firstname) AS CHAR_INDEX
FROM Employees

SELECT *
FROM Employees
where FirstName LIKE '%A%'

SELECT *
FROM Employees
where  CHARINDEX ('A',Firstname)>=1

----LEFT, RIGHT
----CORTAR LA PALABRA

SELECT FirstName,
       left(FirstName,3) AS Primera_Letra,
	   Right(FirstName,2) AS Dos_ultima_letras,
	   substring(FirstName,2,2) AS Extraer_Excel
FROM Employees

----NECESITO PRIMERO QUE MUESTRES EL NOMBRE HASTA LA LETRA QUE SE NECESITA BUSCAR 
MARIA---ARIA
NANCY---ANCY
SELECT FirstName, CHARINDEX('A', FirstName),
LEFT (FirstName, CHARINDEX('A', FirstName))
FROM Employees
------------------------------------------------------------
---LEN
---DEVUELVE EL TAMAÑO DE UN CAMPO
SELECT FirstName, LEN(FirstName)
FROM employees

---Necesito primero que muestres los nombres cortados desde la letra A

SELECT FirstName, CHARINDEX('A', FirstName) as posicion_campo,
LEN(FirstName) as tamaño_campo,
RIGHT (FirstName,LEN(FirstName)-CHARINDEX('A', FirstName)+1),
SUBSTRING(FirstName, CHARINDEX('A',FirstName), LEN(FirstName)+1)-----similar a la linea de arriba
FROM Employees
WHERE CHARINDEX('A',FirstName)>=1---acotando el mundo que contiene la letra A
--------------------------------------------------------------------------
---REPLACE
---REEMPLAZAR EL VALOR QUE TU LE INDIQUES 

SELECT FirstName , REPLACE(FirstName,'A','12345')
FROM Employees

select Title
FROM Employees

select '   hola'
----trim

select ltrim('   hola') ,
rtrim('hola    '),
ltrim(rtrim('   hola   ')),
replace('ho   la',' ','')
----NVL ,
CREATE TABLE T_CLIENTE ( COD INT NOT NULL , NOMBRE VARCHAR(50))
INSERT  INTO T_CLIENTE VALUES(2,'JOSE2')
INSERT INTO T_CLIENTE VALUES (3,NULL)
---NULOS 
SELECT *
FROM T_CLIENTE 
WHERE NOMBRE IS NULL
---CAMBIAR NULL POR SIN NOMBRE "NVL" ES EN ORACLE
SELECT COD,NOMBRE, ISNULL(NOMBRE, 'SIN NOMBRE') AS NOMBRE_3
FROM T_CLIENTE
---DECODE EN ORACLE ---CASE 
SELECT COD , 
               CASE 
			   WHEN COD = 1 THEN 'BAJO'
			   WHEN COD = 2 THEN 'MEDIANO'
			   WHEN COD = 3 THEN 'ALTO'
			   ELSE 'MUY ALTO' END AS FLG_TAMAÑO
FROM T_CLIENTE
-/*WHERE CASE 
			   WHEN COD = 1 THEN 'BAJO'
			   WHEN COD = 2 THEN 'MEDIANO'
			   WHEN COD = 3 THEN 'ALTO'
			   ELSE 'MUY ALTO' END= 'BAJO'*/
--CAPTURA EL RESUTADO Y LO INGRESE A UNA NUEVA TABLA
SELECT COD , ISNULL(NOMBRE,'SIN NOMBRE') AS NOMBRE3,
               CASE 
			   WHEN COD = 1 THEN 'BAJO'
			   WHEN COD = 2 THEN 'MEDIANO'
			   WHEN COD = 3 THEN 'ALTO'
			   ELSE 'MUY ALTO' END AS FLG_TAMAÑO INTO TP_CLIENTE 
FROM T_CLIENTE
--DROP TABLE TP_CLIENTE (PARA ELIMINAR TABLA)
SELECT*
FROM TP_CLIENTE 
---INGRESANDO MAS INFORMACION DE UNA TABLA CREADA 
---INSERCCION MASIVA 
insert into TP_CLIENTE (COD,NOMBRE3,FLG_TAMAÑO)
SELECT COD , ISNULL(NOMBRE,'SIN NOMBRE') AS NOMBRE2,
               CASE 
			   WHEN COD = 1 THEN 'BAJO'
			   WHEN COD = 2 THEN 'MEDIANO'
			   WHEN COD = 3 THEN 'ALTO'
			   ELSE 'MUY ALTO' END AS FLG_TAMAÑO 
FROM T_CLIENTE
SELECT *
FROM TP_CLIENTE
SELECT *
FROM [Order Details]

---CREATE TABLE NOMBRE (TABLA PERMANENTE)
---CREATE TABLE #NOMBRE (TABLA TEMPORAL) SE BORRA CUANDO SE CIERRA LA SESION
-------------------------------------------------------------------------------
---------FUNCIONES DE FECHA
----OBTENER LA FECHA DEL MOMENTO 
SELECT GETDATE()
----poner un alias a la tabla para diferenciar cuando se trabajen con multitablas
SELECT A.FirstName ,A.LastName, A.Adress, GETDATE() AS Fecha
FROM Employees A
---DATEDIFF
--DIFERENCIA DE FECHAS , EN EL INTERVALO QUE DESEES
---NECESITO SABER LA EDAD DE LA PERSONA 
SELECT B.FirstName, B.LastName, B.BirthDate, B.Hiredate,
      DATEDIFF(YEAR , B.BirthDate, GETDATE()) AS EDAD,
	  DATEDIFF(MONTH , B.BirthDate, GETDATE()) AS MESES,
	  DATEDIFF(DAY , B.BirthDate, GETDATE()) AS EDAD_DIAS,
	  DATEDIFF(HOUR , B.BirthDate, GETDATE()) AS EDAD_HORAS,
	  ----LA EDAD QUE EMPEZO A TRABAJAR 
	  DATEDIFF(YEAR,B.BirthDate, B.HireDate) AS EDAD_QUE_EMPEZO_TRABAJANDO,
	  ---LA EDAD EN LA EMPRESA
	  DATEDIFF(YEAR,B.HireDate, GETDATE()) AS EDAD_TIEMPO_EN_EMPRESA
FROM Employees B
---DATEADD
---ME PERMITE AGREGAR O QUITAR EN UN INTERVALO DEFINIDO  
---OBTENIENDO LA FECHA DEL MES SIGUIENTE DE SU CUMPLEAÑOS
SELECT B.FirstName, B.LastName, B.BirthDate, B.Hiredate,
       DATEADD(MONTH,1,B.BirthDate) AS RPT1
FROM Employees B
SELECT GETDATE() AS HOY,
       DATEADD(DAY,1,GETDATE()) AS MAÑANA,
	   DATEADD(DAY,-1,GETDATE()) AS AYER,
	   DATEADD(HOUR,3,GETDATE()) AS HORA_BRAZIL
---FECHAS, YEAR , MONTH , DAY
SELECT GETDATE(), YEAR (GETDATE()) AS NUM_ANIO, MONTH(GETDATE()) AS NUM_MES, DAY(GETDATE())
---Mostrar en el formato de fecha que yo necesite 
SELECT GETDATE(), FORMAT( GETDATE(),'dd/MM/yyyy')

SELECT BirthDate,FORMAT( Birthdate,'dd/MM/yyyy')
from Employees
where format(BirthDate,'dd/MM/yyyy')='08/12/1948'


----DATENAME
SET LANGUAGE SPANISH  --TRADUCIR
SELECT GETDATE() AS HOY,
       DATENAME(YEAR,GETDATE()) AS AÑIO,
	   YEAR(GETDATE()) AS AÑIO2,
	   MONTH(GETDATE()) AS NUM_MES,---DA EL NUMERO DEL MES 
	   DATENAME(MONTH,GETDATE()) AS MES, ---DETALLA EL NOMBRE
	   DATENAME(DAYOFYEAR,GETDATE()) AS DIA_DEL_ANIO, ---DETALLA EL NOMBRE
	   DATENAME(WEEK, GETDATE()) AS SEMANA_DEL_ANIO,---DETALLA EL NOMBRE
	   DATENAME(WEEKDAY,GETDATE()) AS NOMBRE_DIA_SEMANA---DETALLA EL NOMBRE
--EOMONTH(EL ULTIMO DIA DEL MES QUE LE PROPORCIONASTE)

SELECT GETDATE() , EOMONTH(GETDATE())

--FUNCIONES NUMERICAS 
---+, - , * ,/

SELECT A.*,
A.UnitPrice*A.Quantity AS PXQ,
A.UnitPrice+A.Quantity AS sumar,
A.UnitPrice-A.Quantity AS restar,
A.UnitPrice/A.Quantity AS dividir,
case 
     when A.Quantity IS NULL OR A.Quantity = 0 THEN 0
	 Else A.UnitPrice / A.Quantity END AS DIVIDIR,
	 ---Para comtrolar Nulos
	 ----FUNCION COALESCE PARA CONTROL
	 COALESCE(A.Discount,0) as NUM 
FROM [Order Details] A