-- 04-delivery-schema.sql (Delivery Service)

\c logistics_delivery_db;

CREATE SCHEMA IF NOT EXISTS delivery_schema;
GRANT ALL PRIVILEGES ON SCHEMA delivery_schema TO logistics_user;
SET search_path TO delivery_schema;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
