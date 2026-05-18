
## Три БД - при разработке будет так^
1. `postgres-keycloak` _(порт 5433)_ — отдельный PostgreSQL только для Keycloak. Keycloak использует свою собственную базу, не смешиваясь с другими сервисами.
2. `postgres` _(порт 5432)_ — ещё один PostgreSQL, вероятно, для ваших приложений/микросервисов. У него подключена папка ./postgres с инициализационными скриптами.
3. `mongodb` _(порт 27017)_ — MongoDB, документоориентированная БД, для других задач.

---
# БД **`postgres`:**
## Именование Схем (Schema)
### Формат: {service_name}_schema

| Сервис 	              | Схема                 |
|:----------------------|:----------------------|
| User Service	         | user_schema          |
| Transport Service	    | transport_schema     |
| Delivery Service	     | delivery_schema      |
| Cargo Service	        | cargo_schema         |
| Payment Service	      | payment_schema       |
| Notification Service	 | notification_schema  | 

### Порт: 5432
- POSTGRES_DB: postgres
- POTGRES_USER: postgres
- POSTGRES_PASSWORD: postgres

---
# Далее, 2-я часть проекта:

## Именование Баз Данных (Database)
### Формат: logistics_{service_name}_db

| Сервис               | Название БД               |
|:---------------------|:--------------------------|
| User Service	        | logistics_user_db         |
| Cargo Service	       | logistics_cargo_db        |
| Delivery Service	    | logistics_delivery_db     |
| Payment Service	     | logistics_payment_db      |
| Transport Service	   | logistics_transport_db    |
| Notification Service	| logistics_notification_db | 

---
#### 1 cсервис = 1 БД;
#### Один PostgreSQL контейнер с разными БД;



