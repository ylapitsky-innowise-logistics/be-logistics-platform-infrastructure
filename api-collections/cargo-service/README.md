# 🚀 Быстрый старт: `Hoppscotch` для `Cargo-Service`

## 1. Открыть Hoppscotch
[hoppscotch.io](https://hoppscotch.io/)

## 2. Импортировать коллекцию
- `Import` → `Import from file`
- Выбрать _(например)_: `api-collections/cargo-service/Cargo-Service.json`

##  3. Настроить переменную `base_url`
- Через окружение (рекомендуется):
- Создать `Cargo-Service-env.json`:

```json
{
    "v": 1,
    "name": "Local",
    "variables": [
        {
            "key": "base_url",
            "value": "http://localhost:8085",
            "type": "default",
            "secret": false
        }
    ]
}
```

- `Import` → `Import as Environment`

- В выпадающем списке рядом с адресной строкой выбрать `Local`

**Или прямо в коллекции:**

- Навести на коллекцию → три точки → `Edit` → вкладка `Variables` → добавить `base_url = http://localhost:8085`

## 4. Запустить микросервис
   Убедиться, что сервис слушает порт `8085`

## 5. Отправить запрос
- Выбрать любой запрос из коллекции
- Нажать `Send`

### 📁 Структура коллекции
```text
Cargo-Service
├── Резервирование      (GET/POST /reservations)
├── Images
│   ├── Cargo           (картинки грузов)
│   └── Sku             (картинки SKU)
├── Sku                 (GET /skus)
├── Cargo               (GET /cargos)
└── [корень]            (POST /test-data/generate)
```

### ⚠️ Важно
В запросе "**Просмотреть все активные - Дублировать**" endpoint указан 
как `http://<<base_url>>/...` — исправить на `<<base_url>>/...` (дублируется протокол).
