-- Database: Telecom_dw

-- DROP DATABASE IF EXISTS "Telecom_dw";

CREATE DATABASE "Telecom_dw"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


	-- Dimension: Customer
CREATE TABLE dim_customer (
    customer_id VARCHAR PRIMARY KEY,
    gender VARCHAR,
    senior_citizen INT
);

-- Dimension: Services
CREATE TABLE dim_services (
    service_id SERIAL PRIMARY KEY,
    internet_service VARCHAR,
    phone_service VARCHAR
);

-- Dimension: Contract
CREATE TABLE dim_contract (
    contract_id SERIAL PRIMARY KEY,
    contract_type VARCHAR,
    payment_method VARCHAR
);

-- Fact Table
CREATE TABLE fact_customer_usage (
    id SERIAL PRIMARY KEY,
    customer_id VARCHAR,
    tenure INT,
    monthly_charges NUMERIC,
    total_charges NUMERIC,
    churn INT
);

