SELECT current_database();

CREATE TABLE dim_date (
    date_key SERIAL PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT,
    month INT,
    year INT
);

CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id VARCHAR(10),
    product_name VARCHAR(100),
    category VARCHAR(50),
    start_date DATE,
    end_date DATE,
    is_current BOOLEAN
);

CREATE TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_email VARCHAR(100)
);

CREATE TABLE dim_channel (
    channel_key SERIAL PRIMARY KEY,
    channel_name VARCHAR(50)
);

CREATE TABLE fact_sales (
    sales_key SERIAL PRIMARY KEY,
    date_key INT REFERENCES dim_date(date_key),
    product_key INT REFERENCES dim_product(product_key),
    customer_key INT REFERENCES dim_customer(customer_key),
    channel_key INT REFERENCES dim_channel(channel_key),
    quantity INT,
    revenue NUMERIC(12,2)
);

INSERT INTO dim_channel (channel_name)
VALUES ('Store'), ('Online'), ('Partner');

INSERT INTO dim_product
(product_id, product_name, category, start_date, end_date, is_current)
VALUES
('P101','Smartphone A','Phones', CURRENT_DATE, NULL, TRUE),
('P102','Headphones B','Accessories', CURRENT_DATE, NULL, TRUE);



INSERT INTO dim_date (full_date, day, month, year)
SELECT DISTINCT
    CAST(orderdate AS DATE),
    EXTRACT(DAY FROM CAST(orderdate AS DATE)),
    EXTRACT(MONTH FROM CAST(orderdate AS DATE)),
    EXTRACT(YEAR FROM CAST(orderdate AS DATE))
FROM staging_store_sales;



INSERT INTO dim_customer (customer_email)
VALUES ('aleke@gmail.com');

INSERT INTO fact_sales
(date_key, product_key, customer_key, channel_key, quantity, revenue)
VALUES
(1, 1, 1, 2, 2, 2400);



SELECT * FROM fact_sales;
SELECT
    d.full_date,
    p.product_name,
    c.customer_email,
    ch.channel_name,
    f.quantity,
    f.revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_customer c ON f.customer_key = c.customer_key
JOIN dim_channel ch ON f.channel_key = ch.channel_key;


DROP TABLE IF EXISTS staging_store_sales;

CREATE TABLE staging_store_sales (
    ordernumber INT,
    quantityordered INT,
    priceeach NUMERIC,
    orderlinenumber INT,
    sales NUMERIC,
    orderdate TEXT,
    status TEXT,
    qtr_id INT,
    month_id INT,
    year_id INT,
    productline TEXT,
    msrp NUMERIC,
    productcode TEXT,
    customername TEXT,
    phone TEXT,
    addressline1 TEXT,
    addressline2 TEXT,
    city TEXT,
    state TEXT,
    postalcode TEXT,
    country TEXT,
    territory TEXT,
    contactlastname TEXT,
    contactfirstname TEXT,
    dealsize TEXT
);



CREATE TABLE staging_online_sales (
    order_id TEXT,
    order_timestamp TEXT,
    product_code TEXT,
    units_sold INT,
    price_per_unit NUMERIC,
    customer_email TEXT
);

CREATE TABLE staging_partner_sales (
    transaction_no TEXT,
    date_of_sale TEXT,
    item_id TEXT,
    total_amount NUMERIC,
    partner_name TEXT
);

SELECT
    tc.constraint_name,
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_name = 'fact_sales';





SELECT * FROM dim_date LIMIT 10;


