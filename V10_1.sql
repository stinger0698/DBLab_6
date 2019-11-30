--TASK 1
USE AdventureWorks2012
GO
CREATE PROCEDURE SalesByRegions @Regions nvarchar(4000)
AS
BEGIN
	DECLARE @SQL varchar(1000)
	SELECT @SQL =
	'SELECT OrderYear,
	' + @Regions + '
	FROM
	(
	SELECT DATEPART(YEAR, OrderDate) as OrderYear, TotalDue, CountryRegionCode
	FROM Sales.SalesOrderHeader SALES
	JOIN Sales.SalesTerritory TERRITOEY ON SALES.TerritoryID = TERRITOEY.TerritoryID
	) p
	PIVOT
	(
		SUM(TotalDue)
		FOR CountryRegionCode IN
		(' + @Regions + ')
	) AS PivotTable'
	EXEC (@SQL)
	RETURN
END
--procedure call
EXECUTE dbo.SalesByRegions '[AU],[CA],[DE],[FR],[GB],[US]'