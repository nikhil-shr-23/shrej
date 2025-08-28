# Steel Backend - Frequently Asked Questions (FAQ)

## 🔧 Technical Questions

### **Q: How are we connecting to the database?**
**A:** The application uses Spring Boot with JPA/Hibernate to connect to PostgreSQL:
- **Database**: PostgreSQL 15+
- **Connection**: JDBC via `jdbc:postgresql://127.0.0.1:5432/steel_db`
- **Credentials**: `steel_user` / `steel_pass`
- **Configuration**: Located in `src/main/resources/application.yml`
- **Connection Pool**: HikariCP (default Spring Boot connection pool)
- **ORM**: Hibernate 6 with Spring Data JPA

```yaml
spring:
  datasource:
    url: jdbc:postgresql://127.0.0.1:5432/steel_db
    username: steel_user
    password: steel_pass
  jpa:
    hibernate:
      ddl-auto: update
    database-platform: org.hibernate.dialect.PostgreSQLDialect
```

### **Q: What authentication system are we using?**
**A:** JWT (JSON Web Token) based authentication:
- **Token Type**: HS256 (HMAC with SHA-256)
- **Token Lifetime**: 24 hours (configurable)
- **Secret**: Base64 encoded secret stored in `application.yml`
- **Password Hashing**: BCrypt with cost factor 10
- **Stateless**: No server-side session storage

```yaml
app:
  jwt:
    secret: "dGhpc19pc19hX3ZlcnlfbG9uZ19iYXNlNjRfc2VjcmV0X3N0cmluZw=="
    expiration-ms: 86400000
```

### **Q: How does role-based access control work?**
**A:** Three-tier role system with method-level security:
- **ADMIN**: Full system access (users, products, orders, clients, suppliers)
- **MANAGER**: Product and order management, client/supplier management
- **STAFF**: Basic operations, order creation, product viewing

```java
@PreAuthorize("hasRole('ADMIN') or hasRole('MANAGER')")
@PreAuthorize("hasRole('ADMIN')")
```

### **Q: What's the project structure?**
**A:** Standard Spring Boot layered architecture:
```
src/main/java/com/steel/backend/
├── config/           # Configuration classes
├── model/            # JPA entities (User, Product, Order, etc.)
├── repository/       # Data access layer (Spring Data JPA)
├── security/         # JWT and security configuration
├── web/             # REST controllers and DTOs
└── SteelBackendApplication.java
```

### **Q: How do we handle database migrations?**
**A:** Currently using Hibernate's `ddl-auto: update`:
- **Development**: Automatic schema updates
- **Production**: Should use Flyway or Liquibase (planned)
- **Manual**: Direct SQL execution for user management

### **Q: What's the API documentation setup?**
**A:** OpenAPI 3.0 with Swagger UI:
- **URL**: http://localhost:8080/swagger-ui/index.html
- **OpenAPI JSON**: http://localhost:8080/v3/api-docs
- **Auto-generated**: From controller annotations
- **Interactive**: Test endpoints directly from browser

## 🚀 Getting Started Questions

### **Q: How do I start the application?**
**A:** Multiple ways to run the project:

```bash
# Option 1: Maven Spring Boot plugin
mvn spring-boot:run

# Option 2: Build and run JAR
mvn clean package
java -jar target/steel-backend-0.0.1-SNAPSHOT.jar

# Option 3: IDE
# Run SteelBackendApplication.java
```

### **Q: What are the prerequisites?**
**A:** Required software:
- **Java**: 17 or higher (tested with Java 22)
- **Maven**: 3.6+ for dependency management
- **PostgreSQL**: 15+ database server
- **IDE**: IntelliJ IDEA, Eclipse, or VS Code (optional)

### **Q: How do I set up the database?**
**A:** Database setup steps:

```sql
-- 1. Create database
CREATE DATABASE steel_db;

-- 2. Create user
CREATE USER steel_user WITH PASSWORD 'steel_pass';

-- 3. Grant privileges
GRANT ALL PRIVILEGES ON DATABASE steel_db TO steel_user;
```

### **Q: What are the default users?**
**A:** Pre-configured test users:

| Username | Password | Role | Description |
|----------|----------|------|-------------|
| `admin` | `admin123` | ADMIN | Full system access |
| `manager` | `manager123` | MANAGER | Product and order management |
| `staff` | `staff123` | STAFF | Basic operations |

## 📊 Data & Business Questions

### **Q: What data models are available?**
**A:** Core business entities:

**Users & Security:**
- `User`: Authentication and authorization
- `RoleType`: ADMIN, MANAGER, STAFF

**Business Entities:**
- `Product`: Steel utensils with SKU, pricing, stock
- `Supplier`: Vendor information and ratings
- `Client`: Customer data and credit limits
- `Order`: Purchase orders with status tracking
- `OrderItem`: Individual items within orders

### **Q: How does inventory management work?**
**A:** Real-time stock tracking:
- **Stock Updates**: Automatic on order creation/status changes
- **Low Stock Alerts**: Configurable threshold monitoring
- **Stock Reservation**: Temporary holds during order processing
- **Stock Validation**: Prevents overselling

### **Q: What order statuses are supported?**
**A:** Complete order lifecycle:
- **PENDING**: Initial order creation
- **CONFIRMED**: Stock verified and reserved
- **PROCESSING**: Order being prepared
- **SHIPPED**: Order dispatched
- **DELIVERED**: Order completed
- **CANCELLED**: Order cancelled (stock released)

## 🔒 Security Questions

### **Q: How secure is the application?**
**A:** Enterprise-grade security measures:
- **JWT Tokens**: Tamper-proof with expiration
- **Password Hashing**: BCrypt with salt
- **Role-Based Access**: Method-level security
- **Input Validation**: Bean validation annotations
- **SQL Injection Protection**: Parameterized queries via JPA
- **CORS Configuration**: Configurable cross-origin settings

### **Q: How do I change the JWT secret?**
**A:** Update the secret in `application.yml`:

```yaml
app:
  jwt:
    secret: "your-new-base64-encoded-secret"
```

**Generate a new secret:**
```bash
echo -n "your-secret-string" | base64
```

### **Q: How do I add new users?**
**A:** Currently via direct database insertion:

```sql
-- Add user
INSERT INTO users (username, password) VALUES ('newuser', '$2a$10$hashedPassword');

-- Add role
INSERT INTO user_roles (user_id, role) VALUES (user_id, 'STAFF');
```

*Note: Future versions will include user management endpoints*

## 🛠️ Development Questions

### **Q: How do I add new API endpoints?**
**A:** Follow the existing pattern:

```java
@RestController
@RequestMapping("/api/your-resource")
public class YourController {
    
    @GetMapping
    public List<YourEntity> list() {
        // Implementation
    }
    
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<YourEntity> create(@RequestBody @Valid YourEntity entity) {
        // Implementation
    }
}
```

### **Q: How do I run tests?**
**A:** Maven test commands:

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=YourTestClass

# Run with coverage
mvn test jacoco:report
```

### **Q: How do I add new database entities?**
**A:** Create JPA entity and repository:

```java
@Entity
@Table(name = "your_entity")
public class YourEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    // Other fields with annotations
}

@Repository
public interface YourRepository extends JpaRepository<YourEntity, Long> {
    // Custom query methods
}
```

## 📈 Performance Questions

### **Q: How scalable is the application?**
**A:** Designed for horizontal scaling:
- **Stateless**: JWT authentication enables multiple instances
- **Connection Pooling**: HikariCP for efficient DB connections
- **Lazy Loading**: Optimized memory usage
- **Caching Ready**: Infrastructure prepared for Redis integration

### **Q: What's the expected performance?**
**A:** Performance targets:
- **Response Time**: <200ms average (p50), <300ms (p95)
- **Concurrent Users**: 100+ active users
- **Throughput**: 20+ orders per minute
- **Uptime**: 99.9% availability

### **Q: How do I monitor the application?**
**A:** Built-in monitoring:
- **Health Check**: http://localhost:8080/actuator/health
- **Metrics**: JVM, HTTP, database metrics
- **Logging**: JSON format with correlation IDs
- **Swagger**: API documentation and testing

## 🚀 Deployment Questions

### **Q: How do I deploy to production?**
**A:** Production deployment steps:

```bash
# 1. Build production JAR
mvn clean package -Pprod

# 2. Configure production database
# Update application-prod.yml

# 3. Set environment variables
export SPRING_PROFILES_ACTIVE=prod
export DB_PASSWORD=secure_password
export JWT_SECRET=secure_jwt_secret

# 4. Run application
java -jar steel-backend.jar
```

### **Q: What's the recommended deployment architecture?**
**A:** Production setup:
- **Load Balancer**: Nginx or AWS ALB
- **Application**: Multiple Spring Boot instances
- **Database**: PostgreSQL with read replicas
- **Caching**: Redis for session/token storage
- **Monitoring**: Prometheus + Grafana

### **Q: How do I backup the database?**
**A:** PostgreSQL backup strategies:

```bash
# Full backup
pg_dump -U steel_user -d steel_db > backup.sql

# Automated backup (cron)
0 2 * * * pg_dump -U steel_user -d steel_db | gzip > /backups/steel_db_$(date +%Y%m%d).sql.gz
```

## 🔧 Troubleshooting Questions

### **Q: Application won't start - what do I check?**
**A:** Common startup issues:

1. **Database Connection**:
   ```bash
   psql -U steel_user -d steel_db -h localhost
   ```

2. **Port Conflicts**:
   ```bash
   lsof -i :8080
   ```

3. **Java Version**:
   ```bash
   java --version
   ```

4. **Application Logs**:
   ```bash
   tail -f logs/application.log
   ```

### **Q: Getting 403 Forbidden errors - why?**
**A:** Common authentication issues:

1. **Invalid JWT Token**: Token expired or malformed
2. **Missing Authorization Header**: Include `Authorization: Bearer <token>`
3. **Insufficient Permissions**: User role doesn't have required access
4. **Token Generation**: Ensure proper login flow

### **Q: Database connection issues - how to fix?**
**A:** Database troubleshooting:

1. **Check PostgreSQL Status**:
   ```bash
   brew services list | grep postgresql
   ```

2. **Verify Credentials**:
   ```bash
   psql -U steel_user -d steel_db -h localhost
   ```

3. **Check Connection String**:
   ```yaml
   url: jdbc:postgresql://127.0.0.1:5432/steel_db
   ```

## 📚 Additional Resources

### **Q: Where can I find more documentation?**
**A:** Available documentation:
- **PROJECT_DETAILED_SPEC.md**: Comprehensive technical specification
- **QUICK_START.md**: Getting started guide
- **README.md**: Basic project overview
- **Swagger UI**: Interactive API documentation

### **Q: How do I contribute to the project?**
**A:** Development workflow:
1. Fork the repository
2. Create feature branch
3. Follow coding standards
4. Add tests for new features
5. Submit pull request

### **Q: What's the project roadmap?**
**A:** Planned features:
- **Phase 2**: Advanced analytics, mobile apps, file uploads
- **Phase 3**: Multi-tenant architecture, machine learning
- **Phase 4**: Marketplace platform, global expansion

---

**Need more help?** Check the project documentation or create an issue in the repository.




