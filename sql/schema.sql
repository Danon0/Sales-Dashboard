CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    base_price NUMERIC(12,2) NOT NULL
);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    region VARCHAR(50) NOT NULL,
    customer_segment VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    discount_pct NUMERIC(5,2) NOT NULL,
    unit_price NUMERIC(12,2) NOT NULL,
    revenue NUMERIC(14,2) NOT NULL
);
