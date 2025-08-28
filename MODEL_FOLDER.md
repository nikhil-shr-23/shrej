# Model Folder Documentation (src/main/java/com/steel/backend/model)

This folder defines the application's domain entities (JPA models) and enums. These classes map directly to database tables and are used across repositories, services, and controllers.

## Files Overview

### 1) User.java
- **Purpose**: Represents an application user who can authenticate and has roles for authorization.
- **Table**: `users`
- **Key Fields**:
  - `id: Long` — Primary key (IDENTITY)
  - `username: String` — Unique, required
  - `password: String` — BCrypt-hashed password, required
  - `roles: Set<RoleType>` — Stored in `user_roles` as an element collection (EAGER), enum values
- **JPA Mapping Details**:
  - `@ElementCollection(fetch = EAGER)` with `@CollectionTable(name = "user_roles")`
  - `@Enumerated(EnumType.STRING)` to store readable role names
- **Used by**: `security.UserDetailsImpl`, `security.UserDetailsServiceImpl`, `repository.UserRepository`

### 2) RoleType.java
- **Purpose**: Enum defining authorization roles.
- **Values**: `ADMIN`, `MANAGER`, `STAFF`
- **Used by**: `User.roles`, security/authorization checks via `@PreAuthorize`

### 3) Product.java
- **Purpose**: Represents a steel product/utensil.
- **Table**: `products`
- **Key Fields**:
  - `id: Long` — PK
  - `name: String` — Required
  - `category: String`
  - `description: String(1000)`
  - `price: BigDecimal` — Required
  - `quantityInStock: Integer` — Required
  - `supplier: Supplier` — Many-to-One, LAZY
- **Relationships**:
  - `ManyToOne Supplier` → `supplier_id`
- **Used by**: `repository.ProductRepository`, `web.ProductController`, `OrderItem`

### 4) Supplier.java
- **Purpose**: Represents a vendor who supplies products.
- **Table**: `suppliers`
- **Key Fields**:
  - `id: Long` — PK
  - `name: String` — Required
  - `contactInfo: String`
  - `suppliedProducts: Set<String>` — Stored in `supplier_products` via `@ElementCollection`
- **Design Note**: `suppliedProducts` is a denormalized list for quick reference; actual product linkage is via `Product.supplier`.
- **Used by**: `Product`

### 5) Client.java
- **Purpose**: Represents a customer/business client.
- **Table**: `clients`
- **Key Fields**:
  - `id: Long` — PK
  - `name: String` — Required
  - `contactInfo: String`
  - `country: String`
  - `businessType: String`
- **Used by**: `Order`, `repository.ClientRepository`, `web.ClientController`

### 6) Order.java
- **Purpose**: Represents an order placed by a client.
- **Table**: `orders`
- **Key Fields**:
  - `id: Long` — PK
  - `client: Client` — Many-to-One, LAZY (`client_id`)
  - `items: List<OrderItem>` — One-to-Many, cascade ALL, orphanRemoval true
  - `totalPrice: BigDecimal` — Required (sum of line items)
  - `status: OrderStatus` — Enum-based lifecycle
- **Relationships**:
  - `OneToMany OrderItem` with `mappedBy = "order"`
- **Lifecycle**: Created as PENDING, then transitions through statuses defined by `OrderStatus`.

### 7) OrderItem.java
- **Purpose**: Represents a single line item within an order.
- **Table**: `order_items`
- **Key Fields**:
  - `id: Long` — PK
  - `order: Order` — Many-to-One, LAZY (`order_id`)
  - `product: Product` — Many-to-One, LAZY (`product_id`)
  - `quantity: Integer` — Required
  - `price: BigDecimal` — Required (unit price snapshot)
- **Computation**: Line total = `quantity * price` (computed in service layer when needed)

### 8) OrderStatus.java
- **Purpose**: Enum tracking order lifecycle.
- **Likely Values**: `PENDING`, `CONFIRMED`, `PROCESSING`, `SHIPPED`, `DELIVERED`, `CANCELLED`
- **Used by**: `Order.status`, `web.OrderController` for status transitions

## Common Patterns & Annotations
- **Lombok**: `@Getter/@Setter/@Data/@Builder/@NoArgsConstructor/@AllArgsConstructor` reduce boilerplate.
- **ID Strategy**: `GenerationType.IDENTITY` for PKs.
- **Fetch Types**: LAZY for `ManyToOne` to avoid N+1 issues; EAGER only where appropriate (roles set).
- **Validation**: Database-level constraints via `@Column(nullable = false)`.

## Interaction Summary
- Entities are persisted/read via Spring Data repositories.
- Controllers accept/return these entities (or DTOs) over REST.
- Security uses `User` + `RoleType` to enforce access control.



