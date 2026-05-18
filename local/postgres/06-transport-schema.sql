-- 06-transport-schema.sql (Transport Service)

\c logistics_transport_db;

CREATE SCHEMA IF NOT EXISTS transport_schema;
GRANT ALL PRIVILEGES ON SCHEMA transport_schema TO logistics_user;
SET search_path TO transport_schema;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
