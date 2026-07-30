-- ============================================================
-- Project: Superstore Sales Analysis
-- Author:  Shivani Vallakatla
-- Date:    July 2026
-- Tool:    MySQL
-- ============================================================


-- ============================================================
-- QUERY 1: Regional Profit Analysis
-- QUESTION: Which region generates the most revenue and profit?
-- FINDING:  West leads at 14.86% margin; Central weakest at 8.06%
-- ============================================================

SELECT
    region,
    COUNT(DISTINCT order_id)                    AS total_orders,
    ROUND(SUM(sales), 0)                        AS revenue,
    ROUND(SUM(profit), 0)                       AS profit,
    ROUND(SUM(profit)/SUM(sales)*100, 2)        AS profit_margin_pct
FROM superstore
GROUP BY region
ORDER BY profit_margin_pct DESC;


-- ============================================================
-- QUERY 2: Category Profit Margin
-- QUESTION: Which product category is most and least profitable?
-- FINDING:  Technology 17.39%, Office Supplies 17.13%, Furniture 2.32%
-- ============================================================

SELECT
    category,
    COUNT(DISTINCT order_id)                    AS total_orders,
    ROUND(SUM(sales), 0)                        AS revenue,
    ROUND(SUM(profit), 0)                       AS profit,
    ROUND(SUM(profit)/SUM(sales)*100, 2)        AS category_profit_margin_pct
FROM superstore
GROUP BY category
ORDER BY category_profit_margin_pct DESC;


-- ============================================================
-- QUERY 3: Sub-Categories with Negative Profit
-- QUESTION: Which specific product lines are losing money?
-- FINDING:  Tables lost $17,726 | Bookcases lost $3,473 | Supplies lost $1,348
-- ============================================================

SELECT
    category,
    sub_category,
    COUNT(DISTINCT order_id)                    AS total_orders,
    ROUND(SUM(sales), 0)                        AS revenue,
    ROUND(SUM(profit), 0)                       AS profit,
    ROUND(SUM(profit)/SUM(sales)*100, 2)        AS profit_margin_pct
FROM superstore
GROUP BY category, sub_category
HAVING SUM(profit) < 0
ORDER BY profit ASC;


-- ============================================================
-- QUERY 4: Discount Impact on Profit
-- QUESTION: Do heavy discounts increase sales but destroy profit?
-- FINDING:  Discounts above 20% result in net loss per order
--           21-30% = -$45.68 avg loss | 30%+ = -$110.82 avg loss
--           1,344 orders with 20%+ discounts lost $134K combined
-- ============================================================

SELECT
    CASE
        WHEN discount = 0                       THEN '0% — No discount'
        WHEN discount BETWEEN 0.01 AND 0.10     THEN '1-10% — Small'
        WHEN discount BETWEEN 0.11 AND 0.20     THEN '11-20% — Medium'
        WHEN discount BETWEEN 0.21 AND 0.30     THEN '21-30% — Large'
        ELSE '30%+ — Heavy discount'
    END                                         AS discount_bucket,
    COUNT(*)                                    AS total_orders,
    ROUND(SUM(sales), 0)                        AS total_revenue,
    ROUND(SUM(profit), 0)                       AS total_profit,
    ROUND(AVG(profit), 2)                       AS avg_profit_per_order
FROM superstore
GROUP BY discount_bucket
ORDER BY avg_profit_per_order DESC;


-- ============================================================
-- QUERY 5: Customer Segment Value
-- QUESTION: Which customer segment is most profitable?
-- FINDING:  Home Office has fewest customers (148) but highest margin (14.05%) and highest profit per customer ($404)
--           Consumer has most customers (409) but lowest margin (11.53%)
-- ============================================================

SELECT
    segment                                     AS customer_segment,
    COUNT(DISTINCT customer_id)                 AS total_customers,
    COUNT(DISTINCT order_id)                    AS total_orders,
    ROUND(SUM(sales), 0)                        AS total_revenue,
    ROUND(SUM(profit), 0)                       AS total_profit,
    ROUND(SUM(profit)/SUM(sales)*100, 2)        AS profit_margin_pct,
    ROUND(SUM(profit)/COUNT(DISTINCT customer_id), 0) AS profit_per_customer
FROM superstore
GROUP BY segment
ORDER BY profit_margin_pct DESC;


-- ============================================================
-- QUERY 6: Monthly Sales Trend and Growth Rate
-- QUESTION: Is the business growing month over month?
-- FINDING:  Business grew 50% from 2014 to 2017
--           September and November are consistently peak months
--           January always drops sharply after holiday season
-- ============================================================

WITH monthly_data AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m')                        AS year_month,
        COUNT(DISTINCT order_id)                                AS total_orders,
        ROUND(SUM(sales), 0)                                    AS current_sales,
        ROUND(SUM(profit), 0)                                   AS current_profit,
        ROUND(LAG(SUM(sales)) OVER (
              ORDER BY DATE_FORMAT(order_date, '%Y-%m')), 0)    AS previous_month_sales
    FROM superstore
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    year_month,
    total_orders,
    current_sales,
    previous_month_sales,
    ROUND(
        (current_sales - previous_month_sales)
        / previous_month_sales * 100
    , 2)                                                        AS mom_growth_pct,
    current_profit
FROM monthly_data
ORDER BY year_month;
