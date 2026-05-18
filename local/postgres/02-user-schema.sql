-- 02-user-schema.sql (User Service)

-- Подключаемся к БД user-сервиса
\c logistics_user_db;

-- Создаём схему
CREATE SCHEMA IF NOT EXISTS user_schema;

-- Даём права пользователю (если он уже существует)
GRANT ALL PRIVILEGES ON SCHEMA user_schema TO logistics_user;

-- Устанавливаем схему по умолчанию для текущей сессии
SET search_path TO user_schema;

-- Создаём расширения (если нужны)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
