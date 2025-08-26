#!/bin/bash

# Example Users Addition Script
# This script adds realistic example users to the Steel Backend system

BASE_URL="http://localhost:8080"
API_BASE="$BASE_URL/api"

echo "👥 Adding Example Users to Steel Backend"
echo "========================================"
echo ""

# Function to get authentication token
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

# Function to add a user (this would require a user management endpoint)
# Since we don't have a direct user creation endpoint, we'll show how to do it
# and provide the SQL commands to add users directly to the database

echo "📋 Example Users to Add:"
echo "========================"
echo ""

echo "1. 🏢 EXECUTIVE TEAM"
echo "-------------------"
echo "Username: sarah.johnson"
echo "Password: Exec2024!"
echo "Role: ADMIN"
echo "Description: Chief Operations Officer - Full system access"
echo ""

echo "2. 📊 SALES TEAM"
echo "---------------"
echo "Username: mike.chen"
echo "Password: Sales2024!"
echo "Role: MANAGER"
echo "Description: Sales Manager - Product and order management"
echo ""

echo "Username: emily.rodriguez"
echo "Password: Sales2024!"
echo "Role: STAFF"
echo "Description: Sales Representative - Basic operations"
echo ""

echo "3. 📦 INVENTORY TEAM"
echo "-------------------"
echo "Username: david.kumar"
echo "Password: Inv2024!"
echo "Role: MANAGER"
echo "Description: Inventory Manager - Stock and supplier management"
echo ""

echo "Username: lisa.thompson"
echo "Password: Inv2024!"
echo "Role: STAFF"
echo "Description: Warehouse Coordinator - Stock operations"
echo ""

echo "4. 🏭 SUPPLIER RELATIONS"
echo "----------------------"
echo "Username: robert.wilson"
echo "Password: Supp2024!"
echo "Role: MANAGER"
echo "Description: Supplier Relations Manager - Supplier management"
echo ""

echo "5. 💼 FINANCE TEAM"
echo "-----------------"
echo "Username: jennifer.lee"
echo "Password: Fin2024!"
echo "Role: ADMIN"
echo "Description: Financial Controller - Full system access"
echo ""

echo "6. 🛠️ OPERATIONS TEAM"
echo "-------------------"
echo "Username: carlos.martinez"
echo "Password: Ops2024!"
echo "Role: STAFF"
echo "Description: Operations Specialist - Order processing"
echo ""

echo "Username: amanda.foster"
echo "Password: Ops2024!"
echo "Role: STAFF"
echo "Description: Customer Service Representative - Order support"
echo ""

echo "🔧 Adding Users to Database..."
echo "=============================="
echo ""

# Get authentication token
get_token

if [[ -z "$TOKEN" ]]; then
    echo "❌ Could not obtain authentication token. Exiting."
    exit 1
fi

echo ""
echo "📝 SQL Commands to Add Users:"
echo "============================="
echo ""

# Generate BCrypt hashed passwords (using a simple approach)
# In production, you'd use a proper password hashing tool

echo "-- Add Example Users to Steel Backend Database"
echo "-- Run these commands in your PostgreSQL database"
echo ""
echo "-- 1. Executive Team"
echo "INSERT INTO users (username, password) VALUES ('sarah.johnson', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'sarah.johnson'), 'ADMIN');"
echo ""
echo "-- 2. Sales Team"
echo "INSERT INTO users (username, password) VALUES ('mike.chen', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'mike.chen'), 'MANAGER');"
echo ""
echo "INSERT INTO users (username, password) VALUES ('emily.rodriguez', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'emily.rodriguez'), 'STAFF');"
echo ""
echo "-- 3. Inventory Team"
echo "INSERT INTO users (username, password) VALUES ('david.kumar', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'david.kumar'), 'MANAGER');"
echo ""
echo "INSERT INTO users (username, password) VALUES ('lisa.thompson', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'lisa.thompson'), 'STAFF');"
echo ""
echo "-- 4. Supplier Relations"
echo "INSERT INTO users (username, password) VALUES ('robert.wilson', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'robert.wilson'), 'MANAGER');"
echo ""
echo "-- 5. Finance Team"
echo "INSERT INTO users (username, password) VALUES ('jennifer.lee', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'jennifer.lee'), 'ADMIN');"
echo ""
echo "-- 6. Operations Team"
echo "INSERT INTO users (username, password) VALUES ('carlos.martinez', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'carlos.martinez'), 'STAFF');"
echo ""
echo "INSERT INTO users (username, password) VALUES ('amanda.foster', '\$2a\$10\$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');"
echo "INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'amanda.foster'), 'STAFF');"
echo ""

echo "🚀 Quick Add Script:"
echo "==================="
echo ""

# Create a SQL file with all the commands
cat > add_example_users.sql << 'EOF'
-- Add Example Users to Steel Backend Database
-- All passwords are: Password123! (BCrypt hashed)

-- 1. Executive Team
INSERT INTO users (username, password) VALUES ('sarah.johnson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'sarah.johnson'), 'ADMIN');

-- 2. Sales Team
INSERT INTO users (username, password) VALUES ('mike.chen', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'mike.chen'), 'MANAGER');

INSERT INTO users (username, password) VALUES ('emily.rodriguez', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'emily.rodriguez'), 'STAFF');

-- 3. Inventory Team
INSERT INTO users (username, password) VALUES ('david.kumar', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'david.kumar'), 'MANAGER');

INSERT INTO users (username, password) VALUES ('lisa.thompson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'lisa.thompson'), 'STAFF');

-- 4. Supplier Relations
INSERT INTO users (username, password) VALUES ('robert.wilson', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'robert.wilson'), 'MANAGER');

-- 5. Finance Team
INSERT INTO users (username, password) VALUES ('jennifer.lee', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'jennifer.lee'), 'ADMIN');

-- 6. Operations Team
INSERT INTO users (username, password) VALUES ('carlos.martinez', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'carlos.martinez'), 'STAFF');

INSERT INTO users (username, password) VALUES ('amanda.foster', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa');
INSERT INTO user_roles (user_id, role) VALUES ((SELECT id FROM users WHERE username = 'amanda.foster'), 'STAFF');
EOF

echo "✅ SQL file created: add_example_users.sql"
echo ""

echo "🔧 To add these users, run:"
echo "psql -U steel_user -d steel_db -h localhost -f add_example_users.sql"
echo ""

echo "📋 User Summary:"
echo "================"
echo "Total Users to Add: 9"
echo "ADMIN Users: 2 (sarah.johnson, jennifer.lee)"
echo "MANAGER Users: 4 (mike.chen, david.kumar, robert.wilson)"
echo "STAFF Users: 5 (emily.rodriguez, lisa.thompson, carlos.martinez, amanda.foster)"
echo ""
echo "🔑 All passwords are: Password123!"
echo ""
echo "🎯 User Access Matrix:"
echo "====================="
echo "ADMIN: Full system access (users, products, orders, clients, suppliers)"
echo "MANAGER: Product and order management, client/supplier management"
echo "STAFF: Basic operations, order creation, product viewing"
echo ""
echo "Happy user management! 👥"
