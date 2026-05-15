CREATE SCHEMA IF NOT EXISTS user_service;

-- CREATE SCHEMA IF NOT EXISTS logistics-transport_service;
--
-- CREATE SCHEMA IF NOT EXISTS delivery-transport_service;
--
-- CREATE SCHEMA IF NOT EXISTS cargo-transport_service;
--
-- CREATE SCHEMA IF NOT EXISTS payment-transport_service;

-- Дополнительно: назначить права
GRANT ALL PRIVILEGES ON SCHEMA user_service TO logistics_user;
