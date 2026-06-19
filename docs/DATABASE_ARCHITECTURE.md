# 🗄️ Архитектура Баз Данных

Инфраструктура локальной разработки построена на изоляции данных. Каждому микросервису выделена своя логическая база данных (внутри единого СУБД-контейнера) и своя схема.

## 🐘 СУБД PostgreSQL (Основная)
Единый инстанс PostgreSQL обслуживает бизнес-микросервисы. Инициализация схем и баз данных происходит через скрипты в папке `./postgres`.

* **Порт:** `5439` (переопределен для избежания локальных конфликтов)
* **Пользователь / Пароль:** `postgres` / `postgres`

### Матрица баз данных и схем
| Микросервис          | Логическая БД (`POSTGRES_DB`) | Схема (`currentSchema`) |
|:---------------------|:------------------------------|:------------------------|
| User Service         | `logistics_user_db`           | `user_schema`           |
| Cargo Service        | `logistics_cargo_db`          | `cargo_schema`          |
| Delivery Service     | `logistics_delivery_db`       | `delivery_schema`       |
| Payment Service      | `logistics_payment_db`        | `payment_schema`        |
| Transport Service    | `logistics_transport_db`      | `transport_schema`      |
| Notification Service | `logistics_notification_db`   | `notification_schema`   |

## 🔐 PostgreSQL (Keycloak)
Изолированная БД исключительно для нужд Identity Provider.
* **Порт:** `5440`
* **База данных:** `keycloak`

## 🍃 MongoDB
Документоориентированная БД для хранения файлов (GridFS), изображений и неструктурированных логов.
* **Порт:** `27020`
* **База данных:** `logistics_cargo_mongo_db` (для каталога)

---
