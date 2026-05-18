-- Создаём отдельные БД для каждого сервиса
CREATE DATABASE logistics_user_db;
CREATE DATABASE logistics_cargo_db;
CREATE DATABASE logistics_delivery_db;
CREATE DATABASE logistics_payment_db;
CREATE DATABASE logistics_transport_db;
-- CREATE DATABASE logistics_notification_db;

       -- Создаём схемы в каждой БД (нужно подключаться к каждой БД отдельно)
-- User Service
\c logistics_user_db
CREATE SCHEMA IF NOT EXISTS user_schema;
GRANT ALL PRIVILEGES ON SCHEMA user_schema TO logistics_user;

-- Transport Service
\c logistics_transport_db
CREATE SCHEMA IF NOT EXISTS transport_schema;
GRANT ALL PRIVILEGES ON SCHEMA transport_schema TO logistics_user;

-- Delivery Service
\c logistics_delivery_db
CREATE SCHEMA IF NOT EXISTS delivery_schema;
GRANT ALL PRIVILEGES ON SCHEMA delivery_schema TO logistics_user;

-- Cargo Service
\c logistics_cargo_db
CREATE SCHEMA IF NOT EXISTS cargo_schema;
GRANT ALL PRIVILEGES ON SCHEMA cargo_schema TO logistics_user;

-- Payment Service
\c logistics_payment_db
CREATE SCHEMA IF NOT EXISTS payment_schema;
GRANT ALL PRIVILEGES ON SCHEMA payment_schema TO logistics_user;

-- Notification Service
-- \c logistics_notification_db
-- CREATE SCHEMA IF NOT EXISTS notification_schema;
-- GRANT ALL PRIVILEGES ON SCHEMA notification_schema TO logistics_user;

-- Дополнительно: назначить права
\c logistics_user_db
GRANT ALL PRIVILEGES ON SCHEMA user_schema TO logistics_user;
