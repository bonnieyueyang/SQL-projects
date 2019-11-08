SELECT prod_id, prod_name, prod_price FROM Products;

-- do not forget semi-colon in the end of each query

SELECT * FROM Products;
SELECT * FROM Products Limit 5;

SELECT DISTINCT vend_id FROM Products;


SELECT DISTINCT vend_id, prod_price FROM Products;


/*SELECT prod_name, vend_id
FROM Products;*/
SELECT prod_name
FROM Products 
order by prod_name;

SELECT prod_id, prod_price, prod_name
	FROM Products
	ORDER BY 2, 3;


SELECT prod_id, prod_price
	FROM Products
	ORDER BY 2, prod_name;

SELECT prod_id, prod_price, prod_name
	FROM Products
	ORDER BY prod_price DESC;

-- filter

SELECT prod_name, prod_price
	FROM Products
	WHERE prod_price <= 10;


SELECT vend_id, prod_name
	FROM Products
	WHERE vend_id <> 'DLL01';
    
SELECT prod_name, prod_price
	FROM Products
	WHERE prod_price BETWEEN 5 AND 10;

SELECT prod_name
	FROM Products
	WHERE prod_price IS NOT NULL;