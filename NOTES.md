
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

---
## Именование Схем (Schema)
### Формат: {service_name}_schema или просто public

| Сервис 	              | Схема               |
|:----------------------|:--------------------|
| User Service	         | user_schema         |
| Cargo Service	        | cargo_schema        |
| Delivery Service	     | delivery_schema     |
| Payment Service	      | payment_schema      |
| Transport Service	    | transport_schema    |
| Notification Service	 | notification_schema | 

## Все в 1 таблице

| Сервис	               | БД	                       | Порт	           | Пользователь      | Схема               |
|:----------------------|:--------------------------|:----------------|:------------------|:--------------------|
| User Service	         | logistics_user_db         | 5432            | logistics_admin	  | user_schema         |
| Cargo Service	        | logistics_cargo_db	       | 5432 (или 5433)	| logistics_admin	  | cargo_schema        |
| Delivery Service	     | logistics_delivery_db	    | 5432 (или 5434)	| logistics_admin	  | elivery_schema      |
| Payment Service	      | logistics_payment_db	     | 5432	           | logistics_admin	  | payment_schema      |
| Transport Service	    | logistics_transport_db	   | 5432	           | logistics_admin	  | transport_schema    |
| Notification Service	 | logistics_notification_db	| 5432	           | logistics_admin	  | notification_schema | 

















