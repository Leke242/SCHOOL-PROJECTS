CREATE TABLE time_dm (
    time_key INT PRIMARY KEY,
    day INT,
    day_of_the_week VARCHAR(10),
    month INT,
    quarter INT,
    year INT
);
CREATE TABLE item_dm (
    item_key INT PRIMARY KEY,
    item_name VARCHAR(100),
    brand VARCHAR(50),
    type VARCHAR(50),
    supplier_type VARCHAR(50)
);
CREATE TABLE branch_dm (
    branch_key SERIAL PRIMARY KEY ,
    branch_name VARCHAR(100),
    branch_type VARCHAR(50)
);
CREATE TABLE location_dm (
    location_key INT PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50),
    province_or_state VARCHAR(50),
    country VARCHAR(50)
);
CREATE TABLE sales_fact (
    time_key INT REFERENCES time_dm(time_key),
    item_key INT REFERENCES item_dm(item_key),
    branch_key INT REFERENCES branch_dm(branch_key),
    location_key INT REFERENCES location_dm(location_key),
    dollars_sold DECIMAL(10, 2),
      units_sold NUMERIC(14) NOT NULL
	
	);

	INSERT INTO branch_dm (branch_key,branch_name, branch_type)
VALUES
    (001,'CBD Branch', 'Retail'),
    (002,'Westlands Branch', 'Retail'),
    (003,'Industrial Area Branch', 'Wholesale'),
    (004,'Online Fulfillment Center', 'Online'),
    (005,'Regional Distribution Hub', 'Warehouse');

SELECT *
FROM branch_dm
ORDER BY branch_key;