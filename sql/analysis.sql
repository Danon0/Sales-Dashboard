-- Основные KPI
SELECT
    COUNT(DISTINCT order_id) AS orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM orders;

-- Выручка по месяцам
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    ROUND(SUM(revenue), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders
FROM orders
GROUP BY 1
ORDER BY 1;

-- Выручка по категориям
SELECT
    p.category,
    ROUND(SUM(o.revenue), 2) AS revenue,
    SUM(o.quantity) AS units_sold,
    ROUND(SUM(o.revenue) / SUM(SUM(o.revenue)) OVER () * 100, 2) AS revenue_share_pct
FROM orders o
JOIN products p ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Выручка по регионам и сегментам
SELECT
    c.region,
    c.customer_segment,
    ROUND(SUM(o.revenue), 2) AS revenue,
    COUNT(DISTINCT o.order_id) AS orders
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.region, c.customer_segment
ORDER BY revenue DESC;

-- Топ-10 товаров по выручке
SELECT
    p.product_name,
    p.category,
    ROUND(SUM(o.revenue), 2) AS revenue,
    SUM(o.quantity) AS units_sold
FROM orders o
JOIN products p ON p.product_id = o.product_id
GROUP BY p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- Месячный рост выручки
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(revenue) AS revenue
    FROM orders
    GROUP BY 1
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND((revenue / NULLIF(LAG(revenue) OVER (ORDER BY month), 0) - 1) * 100, 2) AS mom_growth_pct
FROM monthly
ORDER BY month;
