SELECT * FROM order_details;
SELECT * FROM menu_items;

--Objective 1 - Exploring the menu_items table: 
--1. View the menu_items table.
SELECT * FROM menu_items;

--2. Find the number of items in the menu.
SELECT count(*) as no_of_items
FROM menu_items;
--3. What are the least and most expensive items on the menu?
--Most expensive
SELECT * FROM menu_items
ORDER BY price DESC 
LIMIT 1;
--Least expensive
SELECT * FROM menu_items
ORDER BY price 
LIMIT 1;

--4. How many italian dishes in the menu?
SELECT count(*) as count_Italian
FROM menu_items
WHERE category = 'Italian';

--5. What are the laest and most expensive italian dishes in the menu?
--Least expensive
SELECT * 
FROM menu_items
WHERE category = 'Italian'
ORDER BY price
LIMIT 1;

--Most expensive
SELECT * 
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;

--6. How many dishes are in each category?
SELECT category, count(*) as dishes_count 
FROM menu_items
GROUP BY category;

--7. Average dish price in each category?

SELECT category, round(avg(price),2) as avg_price 
FROM menu_items
GROUP BY category
ORDER BY avg_price DESC;


--Objective 2 - Exploring the order_details table: 
--1. View Order_details table
SELECT * FROM order_details;

--2. What is the date range of the table?
SELECT Min(order_date) as min_date, Max(order_date) as max_date
FROM order_details;

--3. How many orders were made within this date range?
SELECT count(DISTINCT order_id) as count_orders 
FROM order_details;

--4. How many items were ordered within this date range?
SELECT count(item_id) as count_items
FROM order_details;

--5. Which orders have most number of items?
SELECT order_id, count(item_id) as number_of_items
FROM order_details
GROUP BY order_id
ORDER BY number_of_items DESC;


--5. How many orders have more than 12 items?
SELECT COUNT(O.order_id) AS order_count
FROM
(SELECT order_id, count(item_id) as number_of_items
FROM order_details
GROUP BY order_id
HAVING count(item_id) > 12
ORDER BY number_of_items DESC) AS O;


-- Analyze customer behavior.

--1. Combine menu_items and order_details table into single table

SELECT M.*, O.*
FROM order_details as O
LEFT JOIN menu_items as M
ON M.menu_item_id = O.item_id;

--2. What are the most and least ordered items? What categories they are in?
SELECT M.item_name, M.category, Count(O.order_id) as order_count
FROM order_details as O
LEFT JOIN menu_items as M
ON M.menu_item_id = O.item_id
GROUP BY M.item_name,M.category
ORDER BY order_count; --Least ordered 



SELECT M.item_name, M.category, Count(O.order_id) as order_count
FROM order_details as O
LEFT JOIN menu_items as M
ON M.menu_item_id = O.item_id
GROUP BY M.item_name,M.category
ORDER BY order_count DESC --Most ordered 

--3. What were the top 5 orders that spent most money?

SELECT O.order_id, COALESCE(sum(M.price),0) as total_spent
FROM order_details as O
LEFT JOIN menu_items as M
ON M.menu_item_id = O.item_id
GROUP BY O.order_id
ORDER BY total_spent DESC
LIMIT 5;

--4. View the details of highest spend Order?
SELECT *
FROM order_details as O
LEFT JOIN menu_items as M
ON M.menu_item_id = O.item_id
WHERE order_id = 440;


SELECT M.category, SUM(M.price) AS TOTAL_SPENT, count(item_id) AS ORDER_COUNT
FROM order_details as O
LEFT JOIN menu_items as M
ON M.menu_item_id = O.item_id
WHERE order_id = 440
GROUP BY M.category
ORDER BY TOTAL_SPENT DESC;

--5. View the details of Top 5 highest spend Orders?

SELECT *
FROM order_details as O
LEFT JOIN menu_items as M
ON M.menu_item_id = O.item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675);

SELECT M.category, SUM(M.price) AS TOTAL_SPENT, count(item_id) AS ORDER_COUNT
FROM order_details as O
LEFT JOIN menu_items as M
ON M.menu_item_id = O.item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY M.category
ORDER BY TOTAL_SPENT DESC;




















