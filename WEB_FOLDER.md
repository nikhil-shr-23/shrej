# Web Folder Documentation (src/main/java/com/steel/backend/web)

This folder exposes the REST API via Spring MVC controllers and centralizes exception handling.

## Files Overview

### 1) ProductController.java
- **Base Path**: `/api/products`
- **Endpoints**:
  - `GET /` — List all products
  - `GET /{id}` — Get product by ID
  - `POST /` — Create product (ADMIN|MANAGER)
  - `PUT /{id}` — Update product (ADMIN|MANAGER)
  - `DELETE /{id}` — Delete product (ADMIN)
  - `GET /low-stock?threshold=10` — List products with low stock (ADMIN|MANAGER|STAFF)
  - `PUT /{id}/stock?quantity=Q` — Update stock quantity (ADMIN|MANAGER)
- **Dependencies**: `ProductRepository`
- **Notes**: Uses method-level security via `@PreAuthorize`.

### 2) OrderController.java
- **Base Path**: `/api/orders`
- **Endpoints**:
  - `GET /` — List all orders
  - `GET /{id}` — Get order by ID
  - `POST /` — Create order (ADMIN|MANAGER|STAFF)
    - Request: `clientId` (query param), body = list of `{ productId, quantity }`
    - Behavior: Validates stock, creates `Order` and `OrderItem`s, decrements inventory, computes total
  - `PUT /{id}/status?status=STATUS` — Update order status (ADMIN|MANAGER)
- **Transactions**: `@Transactional` ensures atomic creation of orders and items.
- **Dependencies**: `OrderRepository`, `ClientRepository`, `ProductRepository`, `OrderItemRepository`

### 3) ClientController.java
- **Base Path**: `/api/clients`
- **Endpoints**:
  - `GET /` — List all clients
  - `GET /{id}` — Get client by ID
  - `POST /` — Create client (ADMIN|MANAGER)
  - `PUT /{id}` — Update client (ADMIN|MANAGER)
  - `DELETE /{id}` — Delete client (ADMIN)
- **Dependencies**: `ClientRepository`

### 4) SupplierController.java
- **Base Path**: `/api/suppliers`
- **Endpoints**:
  - `GET /` — List all suppliers
  - `GET /{id}` — Get supplier by ID
  - `POST /` — Create supplier (ADMIN|MANAGER)
  - `PUT /{id}` — Update supplier (ADMIN|MANAGER)
  - `DELETE /{id}` — Delete supplier (ADMIN)
- **Dependencies**: `SupplierRepository`

### 5) AuthController.java
- **Base Path**: `/api/auth`
- **Endpoints**:
  - `POST /login` — Authenticate user and issue JWT token
    - Body: `{ username, password }`
    - Response: `{ token }`
- **Flow**: Delegates authentication to `AuthenticationManager`; on success, signs token via `JwtService`.
- **Dependencies**: `AuthenticationManager`, `JwtService`, `UserRepository`, `PasswordEncoder`

### 6) GlobalExceptionHandler.java
- **Purpose**: Centralized REST exception handling with consistent response format.
- **Handlers**:
  - `IllegalArgumentException` → HTTP 400 with `{ error }`
  - `MethodArgumentNotValidException` → HTTP 422 with `{ errors: { field: message } }`
- **Notes**: Reduces boilerplate in controllers; improves error observability for clients.

## DTOs
- **Package**: `web/dto`
- **AuthDtos.java**:
  - `LoginRequest(username, password)` — Login payload
  - `JwtResponse(token)` — Token response

## Cross-Cutting Concerns
- **Validation**: Uses `@Valid` and Jakarta Bean Validation annotations.
- **Security**: Method-level security via `@PreAuthorize` requires a valid JWT and proper roles.
- **URI Building**: Uses `ResponseEntity.created(URI)` for resource creation responses.

