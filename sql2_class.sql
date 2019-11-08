-- wrong one

SELECT vend_id, prod_name, prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
      AND prod_price >= 10;

-- correct one

SELECT prod_name, prod_price
	FROM Products
	WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01') 
    AND prod_price >= 10;

-- in
SELECT prod_name, prod_price
	FROM Products
	WHERE vend_id IN ('DLL01','BRS01');

SELECT 
    *
FROM
    Products
WHERE NOT vend_id = 'DLL01' ORDER BY prod_name;

SELECT prod_id, prod_name
	FROM Products
	WHERE prod_name LIKE 'Fish%';
    
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%';

SELECT prod_id, prod_name
	FROM Products
	WHERE prod_name LIKE '__inch teddy bear';
-- vs    
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '% inch teddy bear';


-- calculated fields
SELECT Concat(vend_name, ' (', vend_country, ')')
	AS vend_title
	FROM Vendors
	ORDER BY vend_name;

SELECT *, concat(vend_name, '(' , vend_zip, ')')  as vend_detail
FROM Vendors
ORDER BY vend_name;

select * from products;
select concat(prod_id, ' ', prod_price) from products;


    
SELECT prod_id, quantity, item_price, 
quantity*item_price AS total_sales
	FROM orderitems
	WHERE order_num = 20008;
    
    
-- functions:

SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
	FROM Vendors
	ORDER BY vend_name;
    
SELECT vend_name, 
substring(vend_name,1,4) AS first_4_letters_of_vend_name
	FROM Vendors
	ORDER BY vend_name;

SELECT order_num, order_date
	FROM Orders
	WHERE YEAR(order_date) = 2012;

    
SELECT order_num, order_date, NOW() as currentdateandtime
	FROM Orders;

SELECT order_num, order_date,
NOW() as currentdateandtime,
datediff(curdate(), order_date) as dategap
	FROM Orders;

SELECT prod_price,
case when prod_price < 6 then 'low price'
	 else 'high price' end as price_seg
     from products;
     
-- use case when to create a segmentation column
SELECT prod_price,
case when prod_price < 6 then 'low price'
	 when prod_price < 9 then 'medium price'
	 else 'high price' 
     end as price_segment
     from products;
