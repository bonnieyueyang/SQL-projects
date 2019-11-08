-- join

select * from vendors;
select * from Products;


SELECT vend_name, prod_name, prod_price
	FROM Vendors, Products
    WHERE Vendors.vend_id = Products.vend_id;

SELECT vend_name, prod_name, prod_price
	FROM Vendors INNER JOIN Products
	ON Vendors.vend_id = Products.vend_id;

SELECT vend_name, prod_name, prod_price
	FROM Vendors JOIN Products
	ON Vendors.vend_id = Products.vend_id;

SELECT prod_name, vend_name, prod_price, quantity
	FROM OrderItems, Products, Vendors
	WHERE Products.vend_id = Vendors.vend_id
	AND OrderItems.prod_id = Products.prod_id
	AND order_num = 20007;

SELECT cust_name, cust_contact
	FROM Customers, Orders, OrderItems
	WHERE Customers.cust_id = Orders.cust_id
	AND OrderItems.order_num = Orders.order_num
	AND prod_id = 'RGAN01';


SELECT c.cust_id, cust_name, cust_contact
	FROM Customers as C, Orders AS O, OrderItems AS OI
	WHERE C.cust_id = O.cust_id
	AND OI.order_num = O.order_num
	AND prod_id = 'RGAN01';



SELECT C.*, 
O.order_num, O.order_date, 
OI.prod_id, OI.quantity, OI.item_price
	FROM Customers AS C, Orders AS O, OrderItems AS OI
	WHERE C.cust_id = O.cust_id AND OI.order_num = O.order_num 
	AND prod_id = 'RGAN01';

-- only write the column you need
SELECT C.*, O.*
	FROM Customers AS C, Orders AS O, OrderItems AS OI
	WHERE C.cust_id = O.cust_id AND OI.order_num = O.order_num 
	AND prod_id = 'RGAN01';
    
SELECT C.cust_id, O.order_num
FROM 
customers as C
LEFT JOIN
orders as O
on C.cust_id=O.cust_id
where c.cust_id=1000000001;

-- multiple left joins
SELECT C.cust_id, O.order_num
FROM 
customers as C
LEFT JOIN
orders as O
on C.cust_id=O.cust_id
LEFT JOIN 
OrderItems AS OI
ON
OI.order_num = O.order_num;


SELECT C.cust_id, O.order_num
FROM customers as C
RIGHT JOIN
orders as O
on C.cust_id=O.cust_id;


SELECT Customers.cust_id, COUNT(Orders.order_num) AS num_ord
FROM Customers INNER JOIN Orders
 ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;


SELECT Customers.cust_id, COUNT(Orders.order_num) AS num_ord
FROM Customers LEFT OUTER JOIN Orders
 ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;


-- union

select cust_name, cust_contact, cust_email from customers
where cust_state in ('IL', 'IN','MI')
UNION
select cust_name, cust_contact, cust_email from customers
where cust_name = 'Fun4All';


select cust_name, cust_contact, cust_email from customers
where cust_state in ('IL', 'IN','MI')
UNION ALL
select cust_name, cust_contact, cust_email from customers
where cust_name = 'Fun4All';


select cust_name, cust_contact, cust_email from customers 
where cust_state in ('IL', 'IN','MI')
UNION ALL
select cust_name, cust_contact, cust_email from customers
where cust_name = 'Fun4All'
order by cust_name,cust_contact;



