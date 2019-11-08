SELECT AVG(prod_price) AS avg_price
	FROM Products;

SELECT AVG(prod_price) AS avg_price
	FROM Products
	WHERE vend_id = 'DLL01';

SELECT COUNT(*) AS num_cust
	FROM Customers;
    
SELECT COUNT(cust_email) AS num_cust
	FROM Customers;
    
select * from  Customers; 
SELECT count(*), COUNT(cust_email)
	FROM Customers;
    
SELECT MAX(prod_price) AS max_price
	FROM Products;

SELECT MIN(prod_price) AS min_price
	FROM Products;

SELECT SUM(quantity) AS items_ordered
	FROM OrderItems
	WHERE order_num = 20005;

SELECT SUM(item_price*quantity) AS total_sales
	FROM OrderItems
	WHERE order_num = 20005;
    
SELECT AVG(DISTINCT prod_price) AS avg_price
	FROM Products
	WHERE vend_id = 'DLL01';
    
SELECT COUNT(distinct vend_id) FROM products;

-- is used very often in real business cases to check:
	-- 1. number of records
    -- 2. Null values
    -- 3. Duplicated values
SELECT count(*), COUNT(vend_id), 
COUNT(distinct vend_id)
	FROM products;
    
    
select distinct vend_id, prod_price from products;

SELECT COUNT(*) AS num_items,
	MIN(prod_price) AS price_min,
	MAX(prod_price) AS price_max,
	AVG(prod_price) AS price_avg
	FROM Products;


SELECT vend_id, COUNT(*) AS num_prods
	FROM Products
	GROUP BY vend_id
    ORDER by num_prods;
    
SELECT vend_id, 
count(*) as num_prods, 
avg(prod_price) as avg_price
		FROM Products
        Group By vend_id;
        
SELECT vend_id, prod_id, 
COUNT(*) AS num_prods	
FROM Products	
GROUP BY vend_id, prod_id;

SELECT order_num,prod_id, 
sum(quantity)
FROM orderitems
GROUP BY 1,2;

    
SELECT cust_id, COUNT(*) AS orders
	FROM Orders
	GROUP BY cust_id
	HAVING orders >= 2;


SELECT vend_id, COUNT(*) AS num_prods
	FROM Products
	WHERE prod_price >= 4
	GROUP BY vend_id
	HAVING COUNT(*) >= 2
    order by num_prods;
    


SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';

SELECT cust_id
FROM Orders
WHERE order_num IN (20007,20008);

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN ('1000000004','1000000005');

SELECT cust_name, cust_contact
	FROM Customers
	WHERE cust_id IN 
    (SELECT cust_id
				FROM Orders
				WHERE order_num IN 
                (SELECT order_num FROM OrderItems
									WHERE prod_id = 'RGAN01'));

