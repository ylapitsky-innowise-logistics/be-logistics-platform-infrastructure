-- 07-notification-schema.sql (Notification Service)

\c logistics_notification_db;

CREATE SCHEMA IF NOT EXISTS notification_schema;
GRANT ALL PRIVILEGES ON SCHEMA notification_schema TO logistics_user;
SET search_path TO notification_schema;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
