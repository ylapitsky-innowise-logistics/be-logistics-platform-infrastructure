Для нотификаций - использую `TransactionOutbox` на основе `Namastack Outbox`

---
### **Почему Poller (Планировщик) лучше Debezium в вашем случае**

| Критерий      | Poller (Ваш выбор)                                                                                                                                                                                                                                                                      | Debezium (CDC)                                                                                                                                                                                                                                                                                                                    |
|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Ресурсы**   | **Минимальные** (одна таблица, один `@Scheduled`-метод)[](https://dev.to/eragoo/outbox-pattern-rabbitmq-publishing-strategies-for-high-performance-systems-3haf)[](https://systemweakness.com/kafka-outbox-pattern-done-right-with-real-spring-boot-code-9b56bb55a8b3?gi=d0762337c754). | **Тяжелые** (требует Kafka, Kafka Connect, Zookeeper)[](https://dev.to/raedobh/outbox-pattern-with-spring-boot-and-debezium-1od7#comments)[](https://nitinkc.github.io/Microservices-Design-Architecture/04.06-outbox-pattern/).                                                                                                  |
| **Сложность** | **Низкая** (реализуется на чистом Spring Boot, код полностью под вашим контролем)[](https://github.com/ChintaHari/springboot-transactional-outbox-pattern).                                                                                                                             | **Высокая** (настройка коннекторов, управление слотами репликации, мониторинг)[](https://kingmusung.tistory.com/entry/%EB%B6%84%EC%82%B0-%ED%8A%B8%EB%9E%9C%EC%9E%AD%EC%85%98-%EB%AC%B8%EC%A0%9C-Transactional-Outbox%EC%99%80-Debezium-%EB%8F%84%EC%9E%85%EA%B8%B0?category=1247473)[](https://github.com/mgmetehan/outbox-poc). |
| **Контроль**  | **Полный** (легко добавить ретраи, мониторинг, логику пагинации)[](https://github.com/whiskels/outbox-example)[](https://systemweakness.com/kafka-outbox-pattern-done-right-with-real-spring-boot-code-9b56bb55a8b3?gi=d0762337c754).                                                   | Ограничен настройками коннектора.                                                                                                                                                                                                                                                                                                 |
| **Задержка**  | Зависит от частоты опроса (можно настроить на 1-2 секунды, что для вашего проекта критично)[](https://nitinkc.github.io/Microservices-Design-Architecture/04.06-outbox-pattern/).                                                                                                       | Миллисекунды[](https://nitinkc.github.io/Microservices-Design-Architecture/04.06-outbox-pattern/).                                                                                                                                                                                                                                |

**Вывод:** Для вашего проекта, где критичны ресурсы системы и важна управляемость, **Poller** — это золотая середина. Вы не будете расходовать драгоценные ресурсы на поддержку Debezium, а код останется понятным для вас.

---

### **Легковесные библиотеки для реализации Poller в Spring Boot**

Чтобы не писать всё с нуля, рекомендую обратить внимание на эти библиотеки.

#### **1. Namastack Outbox (Настоятельно рекомендую)**

Это **самая современная и богатая возможностями библиотека** для Outbox в экосистеме Spring, которая при этом остается легковесной благодаря использованию **JDBC Template** вместо тяжелого JPA/Hibernate[](https://github.com/namastack/namastack-outbox).

**Ключевые фичи для вас:**

- **Адаптивный Polling**: Библиотека сама регулирует частоту опроса БД в зависимости от нагрузки, что **экономит ресурсы CPU**[](https://github.com/namastack/namastack-outbox).
    
- **Атомарность**: Событие сохраняется в той же транзакции, что и бизнес-данные[](https://github.com/namastack/namastack-outbox).
    
- **Работа с Kafka**: Есть готовые обработчики для отправки в Kafka[](https://github.com/namastack/namastack-outbox).
    
- **Горизонтальное масштабирование**: Поддерживает работу нескольких экземпляров, если в будущем это понадобится[](https://github.com/namastack/namastack-outbox).    

**Как это выглядит в коде:**

1. **Добавьте зависимость:**
```xml
<dependency>
	<groupId>io.namastack</groupId>
	<artifactId>namastack-outbox-starter-jdbc</artifactId>
	<version>1.7.1</version>
</dependency>
```
    
_Это автоматически создаст таблицу `outbox` в вашей БД[](https://github.com/namastack/namastack-outbox)._
    
2. **В вашем `@Service` сохраняйте событие в Outbox:**
```java
@Service
public class OrderService {
    private final Outbox outbox; // <-- Внедряем
    private final OrderRepository orderRepository;
	
    @Transactional
    public void createOrder(CreateOrderCommand command) {
        Order order = Order.create(command);
        orderRepository.save(order);
		
        outbox.schedule(
            payload: new OrderCreatedEvent(order.getId()),
            key: "order-" + order.getId()
        ); // <-- Событие сохранится в таблицу `outbox` в той же транзакции
    }
}
```
    
3. **Создайте обработчик для событий:**
```java
@Service
public class OrderService {
    private final Outbox outbox; // <-- Внедряем
    private final OrderRepository orderRepository;
	
    @Transactional
    public void createOrder(CreateOrderCommand command) {
        Order order = Order.create(command);
        orderRepository.save(order);
		
        outbox.schedule(
            payload: new OrderCreatedEvent(order.getId()),
            key: "order-" + order.getId()
        ); // <-- Событие сохранится в таблицу `outbox` в той же транзакции
    }
}
```

Библиотека сама запустит фоновый Poller, который будет читать записи из таблицы `outbox` и вызывать ваш `handleOrderCreated` метод[](https://github.com/namastack/namastack-outbox).

#### **2. Spring Modulith (Если хотите следовать стандартам)**

Это подход, который использует возможности самого Spring и его модуля `spring-modulith`. Он гарантирует, что событие будет сохранено в специальном реестре внутри той же транзакции, что и основные данные[](https://springbuilders.dev/ivangsa/implementing-a-transactional-outbox-with-asyncapi-springmodulith-and-zenwavesdk-13fp#comments).

**Как это выглядит в коде:**

1. **Включите внешнюю публикацию событий:**
```yaml
spring:
  modulith.events.externalization.enabled: true
```
    
2. **Публикуйте событие внутри `@Transactional` метода:**
```java
@Service
public class CustomerService {
    @Autowired
    ApplicationEventPublisher events;

    @Transactional
    public Customer createCustomer(Customer input) {
        Customer customer = customerRepository.save(input);
        events.publishEvent(new CustomerCreatedEvent(customer)); // <-- Сохраняется в БД
        return customer;
    }
}
```

Событие будет автоматически сохранено в `event_publication` таблицу. Для отправки в Kafka потребуется добавить внешний модуль, например, `spring-modulith-events-kafka` или `spring-modulith-events-scs`[](https://springbuilders.dev/ivangsa/implementing-a-transactional-outbox-with-asyncapi-springmodulith-and-zenwavesdk-13fp#comments).

### **Какой путь выбрать?**

| Библиотека           | Преимущество                                                                                                                                                                                                                                                               | Для кого                                                                                                      |
|:---------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------|
| **Namastack Outbox** | **Максимальная «легковесность»** за счет JDBC Template, адаптивный Polling, широкие возможности по кастомизации. Это **готовое, production-grade решение**, которое **не будет грузить ваш компьютер**[](https://github.com/namastack/namastack-outbox).                   | Если хотите **мощную, но легкую** библиотеку «под ключ», которая сама управляет почти всем.                   |
| **Spring Modulith**  | **Нативная интеграция** с экосистемой Spring. Отличный вариант, если вы строите модульный монолит и придерживаетесь стандартов Spring[](https://springbuilders.dev/ivangsa/implementing-a-transactional-outbox-with-asyncapi-springmodulith-and-zenwavesdk-13fp#comments). | Если вы предпочитаете **стандартные подходы Spring** и хотите, чтобы всё работало «как задумано» экосистемой. |

Для вашей задачи, с оглядкой на ресурсы и «минимальную нагрузку», я бы посоветовал начать с **Namastack Outbox**. Он специально разработан, чтобы быть эффективным, и возьмет на себя всю рутину по опросу БД, оставив вам только бизнес-логику[](https://github.com/namastack/namastack-outbox).

**Важно:** любой Outbox дает гарантию **«at-least-once»** (доставка как минимум один раз)[](https://github.com/whiskels/outbox-example)[](https://nitinkc.github.io/Microservices-Design-Architecture/04.06-outbox-pattern/). Это значит, что ваш потребитель (Consumer) должен быть **идемпотентным**, чтобы случайно не обработать одно событие дважды[](https://blog.stackademic.com/kafka-exactly-once-delivery-in-spring-boot-7fbb0df1feda?gi=231b06250364)[](https://systemweakness.com/kafka-outbox-pattern-done-right-with-real-spring-boot-code-9b56bb55a8b3?gi=d0762337c754).

---
### 📊 Требуется ли Outbox каждому из ваших сервисов?

Давайте пройдем по вашим микросервисам:

|Сервис|Генерирует ли он бизнес-события?|Нужен ли ему Outbox?|Почему?|
|---|---|---|---|
|**Delivery Service**|**ДА** (Создание доставки, смена статуса)|**✅ Да**|**Это ваш оркестратор.** Когда создается доставка, об этом должны узнать другие сервисы. Outbox здесь критичен.|
|**Payment Service**|**ДА** (Оплата прошла успешно / отклонена)|**✅ Да**|Когда оплата подтверждена, Delivery Service должен узнать об этом и запустить процесс доставки.|
|**Cargo Service**|**ДА** (Товар зарезервирован, списан)|**✅ Да**|Владелец данных о товарах. При резервировании товара об этом должен узнать Delivery Service и другие сервисы.|
|**Transport Service**|**ДА** (Транспорт назначен, статус изменен)|**✅ Да**|Если транспорт стал недоступен (например, сломался), об этом должен узнать оркестратор.|
|**User Service**|**ДА** (Пользователь зарегистрирован, роль изменена)|**✅ Да**|Например, при регистрации нового пользователя сервису нотификации нужно отправить приветственное письмо.|
|**Notification Service**|**НЕТ** (Он только **потребляет** события)|**❌ Нет**|Notification Service не генерирует доменные события, которые нужны другим сервисам. Он реагирует на события от других.|
|**Reporting Service**|**НЕТ** (Он только **потребляет** события)|**❌ Нет**|Аналогично. Он слушает события для аналитики, но сам не создает события для других.|

**Вывод:** Outbox нужен **во всех сервисах, которые являются "источниками данных" и инициируют бизнес-процессы**. В вашем случае это **Delivery, Payment, Cargo, Transport, User Service**.


Для вашей логистической платформы и старого компьютера лучший путь:

1. **Реализовать Outbox в каждом сервисе-источнике** (Delivery, Payment, Cargo, Transport, User).
    
2. **Использовать Namastack Outbox** как самую легкую и ресурсоэффективную библиотеку, которая не будет грузить ваш старый компьютер (адаптивный Polling, JDBC вместо тяжелого Hibernate).
    
3. **Notification Service и Reporting Service** оставить как "потребителей" — они **читают события из Kafka** и не генерируют собственные.
    

**Как это упростит вашу жизнь:**

- **Снижение нагрузки:** Благодаря адаптивному Polling, библиотека не будет постоянно опрашивать БД, когда событий нет.
    
- **Гарантия доставки:** Каждый сервис гарантированно доставит свое событие, даже если Kafka недоступна в момент сохранения данных.
    
- **Масштабируемость:** Вы можете масштабировать каждый сервис независимо.
    

Как только вы настроите Outbox в оркестраторе (Delivery Service) и платежном сервисе (Payment Service), ваша система станет значительно более надежной и готовой к росту


---


