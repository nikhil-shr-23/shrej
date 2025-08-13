# Steel Utensils Import/Export Backend

Spring Boot backend for managing products, inventory, orders, clients, and suppliers with JWT auth and role-based access control.

## Tech Stack
- Spring Boot 3, Java 17
- JPA/Hibernate
- PostgreSQL (switchable to MySQL)
- Spring Security with JWT
- Swagger/OpenAPI via springdoc

## Getting Started

1. Configure database in `src/main/resources/application.yml` (PostgreSQL default):
```
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/steel_db
    username: steel_user
    password: steel_pass
```

2. Build and run
```
mvn clean package
mvn spring-boot:run
```

3. API docs
- Swagger UI: `/swagger-ui/index.html`
- OpenAPI JSON: `/v3/api-docs`

## Auth
- Seeded users: `admin/admin123`, `manager/manager123`, `staff/staff123`
- Login: `POST /api/auth/login` with `{ "username": "admin", "password": "admin123" }`
- Use `Authorization: Bearer <token>` for protected endpoints

## Modules
- Products: `/api/products` (CRUD, low stock, update stock)
- Clients: `/api/clients` (CRUD)
- Suppliers: `/api/suppliers` (CRUD)
- Orders: `/api/orders` (create, get, list, update status)

## Notes
- Inventory decreases on order creation; low stock endpoint `GET /api/products/low-stock?threshold=10`.
- Adjust `app.jwt.secret` and `app.jwt.expiration-ms` in `application.yml` for production.

