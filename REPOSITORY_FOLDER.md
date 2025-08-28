# Repository Folder Documentation (src/main/java/com/steel/backend/repository)

This folder contains Spring Data JPA repositories responsible for data access. Repositories abstract SQL and provide CRUD and query methods.

## Files Overview

### 1) ProductRepository.java
- **Purpose**: Data access for `Product` entities.
- **Extends**: `JpaRepository<Product, Long>` — inherits CRUD and pagination/sorting.
- **Custom Methods**:
  - `findByQuantityInStockLessThanEqual(Integer threshold)` — Returns products at/under stock threshold (low stock endpoint uses this).
- **Used by**: `web.ProductController` (list, low-stock, updates), services.

### 2) OrderRepository.java
- **Purpose**: Data access for `Order` entities.
- **Extends**: `JpaRepository<Order, Long>`.
- **Notes**: Used for creating orders, fetching order details, and updating status.

### 3) OrderItemRepository.java
- **Purpose**: Data access for `OrderItem` entities.
- **Extends**: `JpaRepository<OrderItem, Long>`.
- **Notes**: Usually accessed indirectly when managing `Order.items` (cascade), but available for direct queries if needed.

### 4) ClientRepository.java
- **Purpose**: Data access for `Client` entities.
- **Extends**: `JpaRepository<Client, Long>`.
- **Notes**: Supports client CRUD and search/pagination.

### 5) SupplierRepository.java
- **Purpose**: Data access for `Supplier` entities.
- **Extends**: `JpaRepository<Supplier, Long>`.
- **Notes**: Used by product seeding and supplier CRUD.

### 6) UserRepository.java
- **Purpose**: Data access for `User` entities (authentication/authorization).
- **Extends**: `JpaRepository<User, Long>`.
- **Custom Methods**:
  - `findByUsername(String username)` — Loads users during authentication.
- **Used by**: `security.UserDetailsServiceImpl` for Spring Security auth.

## Common Patterns
- **Spring Data Query Derivation**: Method names parsed to generate queries.
- **Transactions**: Typically managed at the service layer; `@Transactional` can be applied as needed.
- **Pagination & Sorting**: Available via `Pageable`/`Sort` in inherited methods.
- **Exception Handling**: `Optional<T>` for safe null handling; 404 mapping in controllers when missing.



