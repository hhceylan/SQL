/*1. How many customers are in each city? 
Your solution should include the city name 
and the number of customers sorted from highest to lowest.*/

SELECT city, count(*) as "number of customers"
FROM SampleRetail.sale.customer
GROUP BY city
ORDER BY count(*) DESC

/*2. Find the total product quantity of the orders. 
Your solution should include order ids and quantity of products.*/

SELECT order_id, quantity
FROM SampleRetail.sale.order_item

SELECT SUM(quantity) as "total product quantity"
FROM SampleRetail.sale.order_item

/*3. Find the cheapest product id for each order id. 
Your solution should include order id, product id and list price sorted from highest to lowest.*/

SELECT order_id, product_id
FROM SampleRetail.sale.order_item
GROUP BY order_id, product_id, list_price
ORDER BY MIN(list_price) ASC

SELECT order_id, product_id, list_price, MIN(list_price) as "cheapest product id"
FROM SampleRetail.sale.order_item
GROUP BY order_id, product_id, list_price
ORDER BY list_price DESC

/*SELECT order_id, product_id, list_price
FROM SampleRetail.sale.order_item
GROUP BY order_id, product_id, list_price,
ORDER BY count(*) DESC*/

/*4. Find the total amount of each order. 
Your solution should include order id and total amount sorted from highest to lowest.*/

SELECT order_id, SUM(list_price) as "total amount"
FROM SampleRetail.sale.order_item
GROUP BY order_id
ORDER BY SUM(list_price) DESC

/*5. Find the order id that has the maximum average product price. 
Your solution should include only one row with the order id and average product price.*/

SELECT TOP(1) order_id, AVG(list_price) as "average product price"
FROM SampleRetail.sale.order_item
GROUP BY order_id
ORDER BY AVG(list_price) DESC

/*6. Write a query that displays brand_id, product_id and list_price 
sorted first by brand_id (in ascending order), and then by list_price  (in descending order).*/

SELECT brand_id, list_price, product_id
FROM SampleRetail.product.product
ORDER BY brand_id ASC, list_price DESC

/*7. Write a query that displays brand_id, product_id and list_price, 
but this time sorted first by list_price (in descending order), and then by brand_id (in ascending order).*/

SELECT list_price, brand_id, product_id
FROM SampleRetail.product.product
ORDER BY brand_id ASC, list_price DESC


/*8. Compare the results of these two queries above. 
How are the results different when you switch the column you sort on first? 
(Explain it in your own words.)*/

/*In the result, the first sorted column is located to the left of the the second sorted column.*/


/*9. Write a query to pull the first 10 rows and all columns from the product table that have a list_price greater than or equal to 3000.*/

SELECT TOP(10)*
FROM SampleRetail.product.product
WHERE list_price >= 3000

/*10. Write a query to pull the first 5 rows and all columns from the product table that have a list_price less than 3000.*/

SELECT TOP(5)*
FROM SampleRetail.product.product
WHERE list_price < 3000

/*11. Find all customer last names that start with 'B' and end with 's'.*/

SELECT last_name
FROM SampleRetail.sale.customer
WHERE last_name LIKE 'B%s'

/*12. Use the customer table to find all information regarding customers whose address is Allen or Buffalo or Boston or Berkeley.*/

SELECT *
FROM SampleRetail.sale.customer
WHERE city = 'Allen' OR city = 'Buffalo' OR city = 'Boston' OR city = 'Berkeley'






