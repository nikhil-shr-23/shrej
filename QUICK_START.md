# 🚀 Steel Backend - Quick Start Guide

## ✅ Project Status: RUNNING

Your Steel Backend application is now **successfully running** on `http://localhost:8080`!

## 📋 What's Already Set Up

### ✅ Database Configuration
- PostgreSQL database: `steel_db`
- User: `steel_user` with password: `steel_pass`
- Connection: `jdbc:postgresql://127.0.0.1:5432/steel_db`

### ✅ Application Status
- **Port**: 8080
- **Health Check**: http://localhost:8080/actuator/health
- **Swagger UI**: http://localhost:8080/swagger-ui/index.html
- **OpenAPI Docs**: http://localhost:8080/v3/api-docs

### ✅ Pre-configured Users
The application comes with seeded users for testing:

| Username | Password | Role | Permissions |
|----------|----------|------|-------------|
| `admin` | `admin123` | ADMIN | Full system access |
| `manager` | `manager123` | MANAGER | Product and order management |
| `staff` | `staff123` | STAFF | Basic operations |

## 🔧 How to Use the API

### 1. **Interactive Testing Script**
Run the provided test script for easy API interaction:
```bash
./test_api.sh
```

### 2. **Manual API Testing**

#### Step 1: Get Authentication Token
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'
```

#### Step 2: Use the Token for API Calls
```bash
# Replace YOUR_TOKEN with the token from step 1
curl -X GET http://localhost:8080/api/products \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 3. **Swagger UI (Recommended)**
Open your browser and go to: **http://localhost:8080/swagger-ui/index.html**

This provides an interactive interface to:
- See all available endpoints
- Test API calls directly
- View request/response schemas
- Authenticate with the login endpoint

## 📊 Available API Endpoints

### 🔐 Authentication
- `POST /api/auth/login` - Login and get JWT token

### 📦 Products
- `GET /api/products` - List all products
- `GET /api/products/{id}` - Get product by ID
- `POST /api/products` - Create new product (ADMIN/MANAGER)
- `PUT /api/products/{id}` - Update product (ADMIN/MANAGER)
- `DELETE /api/products/{id}` - Delete product (ADMIN)
- `GET /api/products/low-stock?threshold=10` - Get low stock products

### 👥 Clients
- `GET /api/clients` - List all clients
- `GET /api/clients/{id}` - Get client by ID
- `POST /api/clients` - Create new client
- `PUT /api/clients/{id}` - Update client
- `DELETE /api/clients/{id}` - Delete client

### 🏭 Suppliers
- `GET /api/suppliers` - List all suppliers
- `GET /api/suppliers/{id}` - Get supplier by ID
- `POST /api/suppliers` - Create new supplier
- `PUT /api/suppliers/{id}` - Update supplier
- `DELETE /api/suppliers/{id}` - Delete supplier

### 📋 Orders
- `GET /api/orders` - List all orders
- `GET /api/orders/{id}` - Get order by ID
- `POST /api/orders` - Create new order
- `PUT /api/orders/{id}/status` - Update order status

## 🎯 Sample API Workflow

### 1. Create a Complete Order
```bash
# 1. Login and get token
TOKEN=$(curl -s -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}' | \
  grep -o '"token":"[^"]*"' | cut -d'"' -f4)

# 2. Create a supplier
curl -X POST http://localhost:8080/api/suppliers \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "SteelCorp Industries",
    "contactEmail": "contact@steelcorp.com",
    "phone": "+1-555-0123",
    "address": "123 Steel Street, Metal City, MC 12345",
    "rating": 5
  }'

# 3. Create a client
curl -X POST http://localhost:8080/api/clients \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Kitchen World Inc",
    "email": "orders@kitchenworld.com",
    "phone": "+1-555-0456",
    "billingAddress": "456 Kitchen Ave, Food Town, FT 67890",
    "shippingAddress": "456 Kitchen Ave, Food Town, FT 67890",
    "creditLimit": 10000.00
  }'

# 4. Create a product
curl -X POST http://localhost:8080/api/products \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "sku": "STL-BOWL-001",
    "name": "Stainless Steel Bowl 12cm",
    "description": "High-quality stainless steel bowl",
    "category": "Bowls",
    "unitPrice": 15.99,
    "stockQuantity": 100,
    "reorderPoint": 20,
    "supplierId": "1"
  }'

# 5. Create an order
curl -X POST http://localhost:8080/api/orders \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "clientId": "1",
    "items": [
      {
        "productId": "1",
        "quantity": 5
      }
    ]
  }'
```

## 🔍 Monitoring & Debugging

### Application Logs
The application logs are displayed in the terminal where you ran `mvn spring-boot:run`

### Health Check
```bash
curl http://localhost:8080/actuator/health
```

### Database Connection
```bash
psql -U steel_user -d steel_db -h localhost
# Password: steel_pass
```

## 🛠️ Development Commands

### Stop the Application
Press `Ctrl+C` in the terminal where the application is running

### Restart the Application
```bash
mvn spring-boot:run
```

### Clean and Rebuild
```bash
mvn clean package
java -jar target/steel-backend-0.0.1-SNAPSHOT.jar
```

### Run Tests
```bash
mvn test
```

## 📁 Project Structure

```
steel-backend/
├── src/main/java/com/steel/backend/
│   ├── config/           # Configuration classes
│   ├── model/            # JPA entities
│   ├── repository/       # Data access layer
│   ├── security/         # JWT and security
│   ├── web/             # REST controllers
│   └── SteelBackendApplication.java
├── src/main/resources/
│   └── application.yml   # Configuration
├── test_api.sh          # API testing script
├── pom.xml              # Maven dependencies
└── README.md            # Project documentation
```

## 🎉 You're All Set!

Your Steel Backend is now running and ready for:
- ✅ API development and testing
- ✅ Database operations
- ✅ Authentication and authorization
- ✅ Product, client, supplier, and order management

**Next Steps:**
1. Open Swagger UI: http://localhost:8080/swagger-ui/index.html
2. Run the test script: `./test_api.sh`
3. Start building your frontend application
4. Explore the detailed documentation in `PROJECT_DETAILED_SPEC.md`

Happy coding! 🚀
