CREATE DATABASE Testing;

USE Testing;

-- QUESTION 1: LIST ALL SUPPLIERS IN THE UK

SELECT 
	Id, 
	CompanyName, 
	ContactName, 
	City, 
	Country, 
	Phone, 
	Fax 

FROM 
	Supplier

WHERE 
	Country = 'UK'

GROUP BY 
	Id,
	CompanyName, 
	ContactName, 
	City, 
	Country, 
	Phone, 
	Fax;

-- QUESTION 2: LIST THE FIRST NAME, LAST NAME AND CITY FOR ALL CUSTOMERS. 
-- CONCATENATE THE FIRST AND LAST NAME SEPARATED BY A SPACE AND COMMA AS A SINGLE COLUMN

SELECT 
	CONCAT 
		(FirstName, ', ', LastName) 
	AS CustomerName, 
	City 

FROM 
	Customer;

-- QUESTION 3: LIST ALL CUSTOMERS IN SWEDEN

SELECT 
	* 

FROM 
	Customer

WHERE 
	Country = 'Sweden';

-- QUESTION 4: LIST ALL SUPPLIERS IN ALPHABETICAL ORDER

SELECT 
	* 

FROM 
	Supplier

ORDER BY 
	CompanyName ASC;

-- QUESTION 5: LIST ALL SUPPLIERS WITH THEIR PRODUCTS

SELECT 
	S.CompanyName,
	S.Country,
	P.ProductName

FROM 
	Supplier S

JOIN 
	Product P ON S.Id = P.SupplierId;

-- QUESTION 6: LIST ALL ORDERS WITH CUSTOMERS' INFORMATION

SELECT 
	O.Id,
	O.OrderDate,
	O.OrderNumber,
	O.TotalAmount,
	C.FirstName,
	C.LastName,
	C.City,
	C.Country,
	C.Phone

FROM 
	[Order] O

JOIN 
	Customer C ON O.CustomerId = C.Id;

-- QUESTION 7: LIST ALL ORDERS WITH PRODUCT NAME, QUANTITY AND PRICE, SORTED BY ORDER NUMBER

SELECT
	O.OrderDate,
	O.OrderNumber,
	P.ProductName,
	OI.Quantity,
	OI.UnitPrice

FROM 
	[Order] O

JOIN 
	OrderItem OI ON O.Id = OI.OrderId

JOIN 
	Product P ON OI.ProductId = P.Id

ORDER BY
	O.OrderNumber;

-- QUESTION 8:USING A CASE STATEMENT, LIST ALL THE AVAILABILITY OF PRODUCTS. WHEN 0 THEN NOT AVAILABLE, ELSE AVAILABLE.

SELECT 
    ProductName,
       
	CASE 
        WHEN 
			IsDiscontinued = 0 THEN 'Not Available'
        ELSE 
			'Available'
    END AS Availability

FROM 
	Product;

-- QUESTION 9: USING CASE STATEMENT, LIST ALL THE SUPPLIERS AND THE LANGUAGE THEY SPEAK. 
-- THE LANGUAGE THEY SPEAK SHOULD BE THEIR COUNTRY.

SELECT 
	CompanyName,

    CASE Country
        WHEN 'Australia' THEN 'English'
        WHEN 'Brazil' THEN 'Portuguese'
        WHEN 'Canada' THEN 'English and French'
        WHEN 'Denmark' THEN 'Danish'
        WHEN 'Finland' THEN 'Finnish and Swedish'
        WHEN 'France' THEN 'French'
        WHEN 'Germany' THEN 'German'
        WHEN 'Italy' THEN 'Italian'
        WHEN 'Japan' THEN 'Japanese'
        WHEN 'Netherlands' THEN 'Dutch'
        WHEN 'Norway' THEN 'Norwegian'
        WHEN 'Singapore' THEN 'English, Malay, Mandarin, Tamil'
        WHEN 'Spain' THEN 'Spanish'
        WHEN 'Sweden' THEN 'Swedish'
        WHEN 'UK' THEN 'English'
        WHEN 'USA' THEN 'English'
        ELSE 'Unknown'
    END AS LanguageSpoken

FROM 
	Supplier;

-- QUESTION 10: LIST ALL PRODUCTS THAT ARE PACKAGED IN JARS

SELECT 
	*

FROM
	Product

WHERE 
	Package LIKE '%jars%';

-- QUESTION 11: LIST PRODUCT NAME, UNITPRICES AND PACKAGES FOR PRODUCTS THAT START WITH CA

SELECT
	ProductName,
	UnitPrice,
	Package

FROM
	Product

WHERE
	ProductName LIKE 'Ca%';

-- QUESTION 12: LIST THE NUMBER OF PRODUCTS FOR EACH SUPPLIER FROM HIGH TO LOW

SELECT 
    S.CompanyName,
    COUNT(P.Id) AS NumberOfProducts

FROM 
	Supplier S

JOIN 
	Product P ON S.Id = P.SupplierId

GROUP BY 
	S.CompanyName

ORDER BY 
	NumberOfProducts DESC;
	
-- QUESTION 13: LIST THE NUMBER OF CUSTOMERS IN EACH COUNTRY

SELECT
	Country,
	COUNT (*) AS NumberOfCustomers

FROM 
	Customer

GROUP BY
	Country;

-- QUESTION 14: LIST THE NUMBER OF CUSTOMERS IN EACH COUNTRY, SORTED HIGH TO LOW

SELECT
	Country,
	COUNT (*) AS NumberOfCustomers

FROM 
	Customer

GROUP BY
	Country

ORDER BY 
	NumberOfCustomers DESC;

-- QUESTION 15: LIST THE TOTAL ORDER AMOUNT FOR EACH CUSTOMERS, SORTED HIGH TO LOW

SELECT 
	C.FirstName,
	C.LastName,
	SUM(O.TotalAmount) AS TotalOrderAmount

FROM 
	Customer C

JOIN 
	[Order] O ON C.Id = O.CustomerId

GROUP BY 
	C.FirstName,
	C.LastName

ORDER BY
	TotalOrderAmount DESC;

-- QUESTION 16: LIST ALL COUNTRIES WITH MORE THAN 2 SUPPLIERS

SELECT Country,
	COUNT(CompanyName) AS NumberOfSuppliers

FROM 
	Supplier

GROUP BY 
	Country
	
HAVING 
		COUNT(CompanyName) > 2;

-- QUESTION 17: LIST THE NUMBER OF CUSTOMERS IN EACH COUNTRY. ONLY INCLUDE COUNTRIES WITH MORE THAN 10 CUSTOMERS

SELECT
	Country,
	COUNT (*) AS NumberOfCustomers

FROM 
	Customer

GROUP BY
	Country

HAVING
	COUNT (*) > 10;

-- QUESTION 18: LIST THE NUMBER OF CUSTOMERS IN EACH COUNTRY, EXCEPT THE USA, SORTED HIGH TO LOW. 
-- ONLY INCLUDE COUNTRIES WITH 9 OR MORE CUSTOMERS

SELECT
	Country,
	COUNT (*) AS NumberOfCustomers

FROM 
	Customer

WHERE
	Country != 'USA'

GROUP BY
	Country

HAVING
	COUNT (*) >= 9
	
ORDER BY
	NumberOfCustomers DESC;

-- QUESTION 19: LIST CUSTOMERS WITH AVERAGE ORDERS BETWEEN $1000 AND $1200

SELECT
	C.FirstName,
	C.LastName,
	FORMAT(AVG (O.TotalAmount), 'C', 'en-US') AS AverageOrders

FROM 
	Customer C

JOIN
	[Order] O ON C.Id = O.CustomerId

GROUP BY
	C.FirstName,
	C.LastName

HAVING
	AVG(O.TotalAmount) BETWEEN $1000 AND $1200;

-- QUESTION 20: GET THE NUMBER OF ORDERS AND TOTAL AMOUNT SOLD BETWEEN JAN 1, 2013 AND JAN 31, 2013

SELECT
	COUNT(OrderNumber) AS NumberOfOrders,
	FORMAT(SUM(TotalAmount), 'C', 'en-US') AS TotalAmount
	
FROM
	[Order]

WHERE
	OrderDate BETWEEN '2013-01-01' AND '2013-01-31';

	
--SQL Capstone Project: Business Insights Report

--Introduction
--This report summarizes the insights derived from a SQL Capstone Project. The objective was to query a business database to 
--extract meaningful information about customers, suppliers, products, and sales trends using SQL. 
--The queries focused on key performance indicators relevant to operations, marketing, and strategic planning.

--Methodology
--The analysis was conducted using a set of 20 SQL queries designed to answer specific business questions. 
--Each query targeted a unique aspect of the dataset such as customer demographics, product availability, supplier 
--relationships, and revenue performance. SQL Server syntax was used to execute queries on a test database.

--Insights from Queries
--•	Q1: The business maintains multiple active suppliers in the UK, which can support reliable distribution in the region.
--•	Q2: Formatting customer names improves readability and supports dashboard integration or CRM exports.
--•	Q3: Sweden has a measurable customer base suggesting potential for targeted marketing in the region.
--•	Q4: Alphabetical supplier listing supports quick access and better data organization.
--•	Q5: Mapping suppliers to their products helps monitor dependencies and plan inventory.
--•	Q6: Combines customer and order data for full transaction analysis.
--•	Q7: Useful for tracking itemized sales and evaluating product-level trends.
--•	Q8: Clearly identifies discontinued products for inventory and sales teams.
--•	Q9: Helps in managing communication and expectations across regions.
--•	Q10: Helps track packaging-specific inventory and marketing.
--•	Q11: Useful for grouping similar products or analyzing product naming trends.
--•	Q12: Identifies top contributing suppliers for better supplier management.
--•	Q13: Highlights geographical distribution of customers for market focus.
--•	Q14: Shows which countries have the largest customer bases.
--•	Q15: Useful for identifying high-value customers.
--•	Q16: Identifies regions with a strong supplier base for logistics planning.
--•	Q17: Helps narrow down to strong markets.
--•	Q18: Focuses on secondary markets with strong customer presence.
--•	Q19: Helps identify a mid-tier segment ideal for upselling strategies.
--•	Q20: Provides a monthly sales snapshot for trend or campaign analysis.

--Conclusion
--The SQL Capstone Project successfully demonstrated how structured queries can be used to extract key insights from business 
--data. The findings reveal valuable information about customer distribution, supplier engagement, and product trends. 
--These insights can inform better business decisions, from marketing strategies to supply chain optimization.
