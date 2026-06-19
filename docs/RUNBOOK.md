# 🚀 Runbook: <br>Управление инфраструктурой (Docker Compose)

Ниже приведены основные команды для локального запуска и обслуживания платформы.
Все команды выполняются из **корня репозитория** `infrastructure`. 
Так как файл конфигурации находится в подпапке, 
во всех командах используется флаг `-f local/docker-compose.yml`.

---
### 🟢 1. Базовый запуск  
**Запустить все** сервисы инфраструктуры в фоновом режиме:  
```bash
docker-compose -f local/docker-compose.yml up -d
````

### 🔄 2. Перезагрузка и обновление
**Перезапустить** конкретный сервис (_например, если MongoDB зависла_):
```bash
docker-compose -f local/docker-compose.yml restart mongodb
````

**Перезапустить** вообще **все** контейнеры (_быстрая перезагрузка **без пересоздания**_):
```bash
docker-compose -f local/docker-compose.yml restart
````

**Остановить** и **запустить** заново (_применяет изменения, если был изменен код в `docker-compose.yml`_):
```bash
docker-compose -f local/docker-compose.yml down
docker-compose -f local/docker-compose.yml up -d
````

### ⚠️ 3. Hard Reset (Сброс баз данных)
Используется при смене паролей, конфликтах портов или если нужно начать **с чистого листа**.

Внимание: Флаг **-v** полностью **удалит все** локальные данные баз!
```bash
docker-compose -f local/docker-compose.yml down -v
docker-compose -f local/docker-compose.yml up -d
````

### 🔍 4. Мониторинг и логи
Проверить статус всех запущенных контейнеров и их порты:
```bash
docker-compose -f local/docker-compose.yml ps
````

Посмотреть логи конкретного сервиса в реальном времени (для выхода нажми Ctrl+C):
```bash
docker-compose -f local/docker-compose.yml logs -f postgres
````

### 🔴 5. Остановка системы
Штатная **остановка** инфраструктуры (все данные в базах сохраняются):

```bash
docker-compose -f local/docker-compose.yml down
````

Остановка с полным **уничтожением** данных (_очистка `volume`_):
```bash
docker-compose -f local/docker-compose.yml down -v
````

---
