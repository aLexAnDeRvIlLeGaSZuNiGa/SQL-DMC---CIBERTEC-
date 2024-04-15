select *
from [Purchasing].[ProductVendor]

----personas que han recibido incompleto sus pedidos en la tabla [Purchasing].[ProductVendor]
select *
from [Purchasing].[ProductVendor]
where onorderqty>0
-----personas que recibieron sus productos en los años 2013 y 2014
select *
from [Purchasing].[ProductVendor]
where LastReceiptDate between '01-01-2013' and '31-12-2014'
----actualiza la tabla person cambiando la fecha del año 2010 en adelante con la actual 
select*
from [Sales].[SalesPerson]
update [Person].[Person]
set ModifiedDate=GETDATE()
WHERE ModifiedDate>'01-01-2010'
----insertar nuevos registros 
INSERT INTO [Sales].[SalesPerson](BusinessEntityID,TerritoryID,SalesQuota,Bonus,CommissionPct,SalesYTD,SalesLastYear,rowguid,ModifiedDate)
VALUES (273,null,null,10000,1,5454645,1656465,'6F9619FF-8B86-D011-B42D-00C04FC964FF',getdate())
select *
from [Person].[Address]
delete from [Person].[Address] into new_tabla
where AddressID>=10