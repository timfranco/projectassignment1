CREATE TABLE yellevate (
country varchar, 
customer_id varchar,
invoice_number numeric, 
invoice_date date,
due_date date,
invoice_amount numeric,
disputed numeric,
dispute_lost numeric,
settled_date date,
days_settled integer,
days_late integer
);

--1 Processing time in which invoices are settled
SELECT ROUND(AVG(days_settled)) AS avg_days_invoice_settled 
FROM yellevate;

--2 Processing time for the company to settle disputes
SELECT disputed, ROUND(AVG(days_settled)) 
FROM yellevate
WHERE disputed > 0
GROUP BY disputed;

--3 Percentage of disputes received by the company that were lost
SELECT ROUND(SUM(dispute_lost)/SUM(disputed), 2)100 AS percent_dispute_lost 
FROM yellevate;

--4 Percentage of revenue lost from disputes
SELECT ROUND(SUM(invoice_amount)100/(SELECT sum(invoice_amount) FROM yellevate),2) AS percent_revenue_lost
FROM yellevate
GROUP BY dispute_lost
HAVING dispute_lost > 0;

--The country where the company reached the highest losses from lost disputes(in USD)
SELECT country, sum(invoice_amount) AS country_revenue_lost FROM yellevate
WHERE dispute_lost > 0
GROUP BY country
ORDER BY SUM(invoice_amount) DESC;
