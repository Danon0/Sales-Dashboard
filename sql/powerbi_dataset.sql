-- Витрина для Power BI
SELECT
    o.order_id,
    o.order_date,
    o.customer_id,
    c.region,
    c.customer_segment,
    o.product_id,
    p.product_name,
    p.category,
    o.quantity,
    o.discount_pct,
    o.unit_price,
    o.revenue
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = o.product_id;
