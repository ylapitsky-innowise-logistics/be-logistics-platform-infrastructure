// Создаём базы данных для каждого сервиса
db = db.getSiblingDB('logistics_events');
db.createCollection('user_events');
db.createCollection('cargo_events');
db.createCollection('delivery_events');
db.createCollection('payment_events');
db.createCollection('transport_events');

// Создаём индексы
db.user_events.createIndex({ "timestamp": -1 });
db.user_events.createIndex({ "eventType": 1 });

// Создаём пользователя (если нужна аутентификация)
db.createUser({
    user: "mongodb_user",
    pwd: "mongodb_pass",
    roles: [
        { role: "readWrite", db: "logistics_events" }
    ]
});

print("MongoDB initialized successfully");