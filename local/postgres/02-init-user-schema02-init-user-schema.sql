-- User Service

-- Подключаемся к БД user-сервиса
\c logistics_user_db;

-- Создаём схему
CREATE SCHEMA IF NOT EXISTS user_schema;

-- Даём права на схему
GRANT ALL PRIVILEGES ON SCHEMA user_schema TO logistics_user;

-- Устанавливаем схему по умолчанию
ALTER DATABASE logistics_user_db SET search_path TO user_schema;

-- Создаём расширения
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
