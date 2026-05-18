-- Создаём отдельные БД для каждого сервиса
CREATE DATABASE logistics_user_db;
CREATE DATABASE logistics_cargo_db;
CREATE DATABASE logistics_delivery_db;
CREATE DATABASE logistics_payment_db;
CREATE DATABASE logistics_transport_db;
-- CREATE DATABASE logistics_notification_db;

-- Подключаемся к каждой БД и создаём схемы
-- (Без \c, через отдельные файлы будет проще)

       -- Даём права пользователю на все БД
GRANT ALL PRIVILEGES ON DATABASE logistics_user_db TO logistics_user;
GRANT ALL PRIVILEGES ON DATABASE logistics_cargo_db TO logistics_user;
GRANT ALL PRIVILEGES ON DATABASE logistics_delivery_db TO logistics_user;
GRANT ALL PRIVILEGES ON DATABASE logistics_payment_db TO logistics_user;
GRANT ALL PRIVILEGES ON DATABASE logistics_transport_db TO logistics_user;
GRANT ALL PRIVILEGES ON DATABASE logistics_notification_db TO logistics_user;
