CREATE TABLE Time_dim(
    time_key INT PRIMARY KEY ,
    day INT,
    day_of_the_week VARCHAR(10),
    month INT,
    quarter INT,
    year INT
);
CREATE TABLE item_dim (
    item_key INT PRIMARY KEY,
    item_name VARCHAR(100),
    brand VARCHAR(50),
    type VARCHAR(50),
    supplier_type VARCHAR(50)
);
CREATE TABLE branch_dim (
    branch_key INT PRIMARY KEY,
    branch_name VARCHAR(100),
    branch_type VARCHAR(50)
);
CREATE TABLE location_dim (
    location_key INT PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50),
    province_or_state VARCHAR(50),
    country VARCHAR(50)
);
CREATE TABLE sales_fact (
    time_key INT REFERENCES Time_dim(t),
    item_key INT,
    branch_key INT,
    location_key INT,
    dollars_sold Numeric(10,2) NOT NULL,
    units_sold INT NOT NULL,

    
);
