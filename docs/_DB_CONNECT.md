## PostgreSQL + MongoDB

---
# DbGate - настройка для логистической платформы

### 🚀 Как пользоваться

1. Открыть в браузере: http://localhost:5051

2. Подключиться к обоим БД (один раз):

## PostgreSQL
> **PostgreSQL**
> - Connection type: **PostgreSQL**
> - Fill database connection details: **выбрать это**
> - Connection mode: **Host and port**
> - Server: **dockerhost**
> - Port: **5433**
> - User: **postgres**
> - Password: **postgres**
> - Password mode: **Save and encrypt**
> - Is read only: **_(не отмечено)_**
> - Default database: **logistics_platform_db**
> - Use only database logistics_platform_db: **_(не отмечено)_**
> - Use schemas separately: **_(не отмечено)_**
> - Display name: **PostgresDB**
- URL: `http://localhost:5051`
- Тип: PostgreSQL
- Server: dockerhost
- Port: 5433
- User: postgres
- Password: postgres
- Database: logistics_platform_db



## MongoDB
> **MongoDB**
> - Connection type: **MongoDB**
> - Fill database connection details: **выбрать это**
> - Server: dockerhost
> - Port: 27018
> - User: **_(пусто)_**
> - Password: **_(пусто)_**
> - Password mode: **Save and encrypt**
> - Is read only: **_(не отмечено)_**
> - Default database: **_(not selected - optional)_**
> - Display name: **MongoDB**
- Тип: MongoDB
- Server: dockerhost
- Port: 27018
- Без аутентификации
- Database: logistics_cargo_mongo_db (выбрать в интерфейсе)- Тип: MongoDB
- Server: dockerhost
- Port: 27018
- Без аутентификации
- Database: logistics_cargo_mongo_db (выбрать в интерфейсе)

---
## Keycloak
Keycloak → http://localhost:8080
> Логин: **admin**  
> Пароль: **admin**

---
