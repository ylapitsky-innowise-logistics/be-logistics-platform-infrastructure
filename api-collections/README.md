# Hoppscotch коллекции

## Импорт

1. Откройте **Hoppscotch**
2. Нажмите **Import**
3. Выберите `hoppscotch-cargo.json`
4. (Опционально) Импортируйте `hoppscotch-cargo-env.json` как Environment

## Переменные окружения

- `{{baseUrl}}` — `http://localhost:8085`
- `{{token}}` — JWT-токен (получить через Keycloak)

## Запросы

- `GET /api/v1/catalog/skus` — получить все SKU
- `GET /api/v1/catalog/cargos` — получить все грузы
- `POST /api/v1/catalog/reservations` — создать резервирование
- 