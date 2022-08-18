-- Show all customer records
SELECT * FROM sales.customers;

-- Show total number of customers
SELECT count(*) FROM sales.customers;


-- Show all market records
SELECT * FROM sales.markets;

-- Show total number of markets
SELECT count(*) FROM sales.markets;


-- Show all product records
SELECT * FROM sales.products;

-- Show total number of products
SELECT count(*) FROM sales.products;


-- Show all transaction records
SELECT * FROM sales.transactions;

-- Show total number of transactions
SELECT count(*) FROM sales.transactions;


-- Get the count of items bought by each customer
SELECT custmer_name, SUM(sales_qty) AS count_of_items
FROM sales.transactions
INNER JOIN sales.customers
ON (transactions.customer_code = customers.customer_code)
GROUP BY custmer_name
ORDER BY count_of_items DESC;


-- Show products sold in every market alongwith the market names
SELECT markets_code, markets_name, product_code
FROM sales.transactions
INNER JOIN sales.markets
ON (transactions.market_code = markets.markets_code);


-- Show product types sold in every market
SELECT market_code, product_type
FROM sales.transactions
INNER JOIN sales.products
ON (transactions.product_code = products.product_code);


-- Show transactions for Chennai market
SELECT * FROM sales.transactions 
WHERE market_code='Mark001';

-- How many transactions were done in Chennai?
SELECT count(*) FROM sales.transactions 
WHERE market_code='Mark001';

-- Show distinct products that were sold in Chennai
SELECT DISTINCT product_code
FROM sales.transactions
WHERE market_code = 'Mark001';


-- Show the transactions where currency is US dollars
SELECT * FROM sales.transactions 
WHERE currency="USD";


-- Show all date records
SELECT * FROM sales.date;

-- What is the observation period?
SELECT DATE_FORMAT(MIN(cy_date), "%M %Y") AS starting_date, 
DATE_FORMAT(MAX(cy_date), "%M %Y") AS ending_date
FROM sales.date;


-- Show the transactions made in 2020
SELECT transactions.*, date.* 
FROM sales.transactions
INNER JOIN sales.date
ON transactions.order_date = date.date 
WHERE date.year=2020;


-- Show total revenue made in the year 2019
SELECT SUM(transactions.sales_amount) AS 2019_total_revenue 
FROM sales.transactions 
INNER JOIN sales.date 
ON transactions.order_date = date.date 
WHERE date.year=2019 AND (transactions.currency="INR" or transactions.currency="USD");


-- Show total revenue made in the year 2020
SELECT SUM(transactions.sales_amount) AS 2020_total_revenue 
FROM sales.transactions 
INNER JOIN sales.date 
ON transactions.order_date = date.date 
WHERE date.year=2020 AND (transactions.currency="INR" or transactions.currency="USD");

-- Clearly total revenue has decreased from 2019 to 2020 --


-- Show total revenue made in the year 2020 in the month of January
SELECT SUM(transactions.sales_amount) AS 2020_Jan_total_revenue 
FROM sales.transactions 
INNER JOIN sales.date 
ON transactions.order_date = date.date 
WHERE date.year=2020 AND date.month_name="January" AND
(transactions.currency="INR" or transactions.currency="USD");


-- Show total revenue made in the year 2020 in Chennai
SELECT SUM(transactions.sales_amount) AS 2020_Chennai_total_revenue 
FROM sales.transactions 
INNER JOIN sales.date 
ON transactions.order_date = date.date 
WHERE date.year=2020 AND transactions.market_code="Mark001";