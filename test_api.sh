#!/bin/bash

# Steel Backend API Test Script
# This script helps you test the Steel Backend API endpoints

BASE_URL="http://localhost:8080"
API_BASE="$BASE_URL/api"

echo "🔧 Steel Backend API Test Script"
echo "================================="
echo ""

# Function to get a fresh token
get_token() {
    echo "🔑 Getting authentication token..."
    local response=$(curl -s -X POST "$API_BASE/auth/login" \
        -H "Content-Type: application/json" \
        -d '{"username":"admin","password":"admin123"}')
    
    if [[ $? -eq 0 ]]; then
        TOKEN=$(echo "$response" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
        echo "✅ Token obtained successfully"
        echo "Token: ${TOKEN:0:50}..."
    else
        echo "❌ Failed to get token"
        return 1
    fi
}

# Function to test health endpoint
test_health() {
    echo ""
    echo "🏥 Testing health endpoint..."
    curl -s "$BASE_URL/actuator/health"
    echo ""
}

# Function to test products endpoint
test_products() {
    echo ""
    echo "📦 Testing products endpoint..."
    if [[ -z "$TOKEN" ]]; then
        get_token
    fi
    
    curl -s -X GET "$API_BASE/products" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json"
    echo ""
}

# Function to test clients endpoint
test_clients() {
    echo ""
    echo "👥 Testing clients endpoint..."
    if [[ -z "$TOKEN" ]]; then
        get_token
    fi
    
    curl -s -X GET "$API_BASE/clients" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json"
    echo ""
}

# Function to test suppliers endpoint
test_suppliers() {
    echo ""
    echo "🏭 Testing suppliers endpoint..."
    if [[ -z "$TOKEN" ]]; then
        get_token
    fi
    
    curl -s -X GET "$API_BASE/suppliers" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json"
    echo ""
}

# Function to test orders endpoint
test_orders() {
    echo ""
    echo "📋 Testing orders endpoint..."
    if [[ -z "$TOKEN" ]]; then
        get_token
    fi
    
    curl -s -X GET "$API_BASE/orders" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json"
    echo ""
}

# Function to show available endpoints
show_endpoints() {
    echo ""
    echo "🌐 Available API Endpoints:"
    echo "==========================="
    echo "Health Check: $BASE_URL/actuator/health"
    echo "Swagger UI: $BASE_URL/swagger-ui/index.html"
    echo "OpenAPI JSON: $BASE_URL/v3/api-docs"
    echo ""
    echo "Protected Endpoints (require JWT token):"
    echo "Authentication: POST $API_BASE/auth/login"
    echo "Products: GET/POST/PUT/DELETE $API_BASE/products"
    echo "Clients: GET/POST/PUT/DELETE $API_BASE/clients"
    echo "Suppliers: GET/POST/PUT/DELETE $API_BASE/suppliers"
    echo "Orders: GET/POST/PUT $API_BASE/orders"
    echo ""
}

# Function to create sample data
create_sample_data() {
    echo ""
    echo "📝 Creating sample data..."
    if [[ -z "$TOKEN" ]]; then
        get_token
    fi
    
    # Create a supplier
    echo "Creating supplier..."
    SUPPLIER_RESPONSE=$(curl -s -X POST "$API_BASE/suppliers" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
            "name": "SteelCorp Industries",
            "contactEmail": "contact@steelcorp.com",
            "phone": "+1-555-0123",
            "address": "123 Steel Street, Metal City, MC 12345",
            "rating": 5
        }')
    echo "Supplier created: $SUPPLIER_RESPONSE"
    
    # Create a client
    echo "Creating client..."
    CLIENT_RESPONSE=$(curl -s -X POST "$API_BASE/clients" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
            "name": "Kitchen World Inc",
            "email": "orders@kitchenworld.com",
            "phone": "+1-555-0456",
            "billingAddress": "456 Kitchen Ave, Food Town, FT 67890",
            "shippingAddress": "456 Kitchen Ave, Food Town, FT 67890",
            "creditLimit": 10000.00
        }')
    echo "Client created: $CLIENT_RESPONSE"
    
    # Create a product
    echo "Creating product..."
    PRODUCT_RESPONSE=$(curl -s -X POST "$API_BASE/products" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
            "sku": "STL-BOWL-001",
            "name": "Stainless Steel Bowl 12cm",
            "description": "High-quality stainless steel bowl, perfect for kitchen use",
            "category": "Bowls",
            "unitPrice": 15.99,
            "stockQuantity": 100,
            "reorderPoint": 20,
            "supplierId": "1"
        }')
    echo "Product created: $PRODUCT_RESPONSE"
}

# Main menu
main_menu() {
    echo ""
    echo "What would you like to test?"
    echo "1. Health Check"
    echo "2. Get Authentication Token"
    echo "3. Test Products API"
    echo "4. Test Clients API"
    echo "5. Test Suppliers API"
    echo "6. Test Orders API"
    echo "7. Create Sample Data"
    echo "8. Show All Endpoints"
    echo "9. Test All Endpoints"
    echo "0. Exit"
    echo ""
    read -p "Enter your choice (0-9): " choice
    
    case $choice in
        1) test_health ;;
        2) get_token ;;
        3) test_products ;;
        4) test_clients ;;
        5) test_suppliers ;;
        6) test_orders ;;
        7) create_sample_data ;;
        8) show_endpoints ;;
        9) 
            test_health
            get_token
            test_products
            test_clients
            test_suppliers
            test_orders
            ;;
        0) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
    
    main_menu
}

# Check if the application is running
echo "🔍 Checking if Steel Backend is running..."
if curl -s "$BASE_URL/actuator/health" > /dev/null 2>&1; then
    echo "✅ Steel Backend is running on $BASE_URL"
else
    echo "❌ Steel Backend is not running on $BASE_URL"
    echo "Please start the application first with: mvn spring-boot:run"
    exit 1
fi

# Start the main menu
main_menu
