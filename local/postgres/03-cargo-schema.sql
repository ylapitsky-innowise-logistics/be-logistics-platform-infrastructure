-- 03-cargo-schema.sql (Cargo Service)

\c logistics_cargo_db;

CREATE SCHEMA IF NOT EXISTS cargo_schema;
GRANT ALL PRIVILEGES ON SCHEMA cargo_schema TO logistics_user;
SET search_path TO cargo_schema;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
