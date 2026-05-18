-- 05-payment-schema.sql (Payment Service)

\c logistics_payment_db;

CREATE SCHEMA IF NOT EXISTS payment_schema;
GRANT ALL PRIVILEGES ON SCHEMA payment_schema TO logistics_user;
SET search_path TO payment_schema;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
