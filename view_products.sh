#!/bin/bash

# View Products Script
# This script displays the products in the Steel Backend system

BASE_URL="http://localhost:8080"
API_BASE="$BASE_URL/api"

echo "📦 Steel Backend - Product Catalog"
echo "=================================="
echo ""

# Function to get authentication token
get_token() {
    local response=$(curl -s -X POST "$API_BASE/auth/login" \
        -H "Content-Type: application/json" \
        -d '{"username":"admin","password":"admin123"}')
    
    if [[ $? -eq 0 ]]; then
        TOKEN=$(echo "$response" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
        echo "✅ Authenticated successfully"
    else
        echo "❌ Authentication failed"
        return 1
    fi
}

# Get token
get_token

if [[ -z "$TOKEN" ]]; then
    echo "❌ Could not obtain authentication token. Exiting."
    exit 1
fi

echo ""
echo "🔍 Fetching products..."
echo ""

# Get products and format the output
PRODUCTS_JSON=$(curl -s -X GET "$API_BASE/products" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json")

# Check if we got a response
if [[ -z "$PRODUCTS_JSON" ]]; then
    echo "❌ No products found or error occurred"
    exit 1
fi

# Count products
PRODUCT_COUNT=$(echo "$PRODUCTS_JSON" | grep -o '"id":[0-9]*' | wc -l)
echo "📊 Total Products: $PRODUCT_COUNT"
echo ""

# Display products by category
echo "🏷️  Products by Category:"
echo "========================"

# Ice Buckets
echo ""
echo "🧊 ICE BUCKETS:"
echo "---------------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Ice Buckets"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Bowls
echo ""
echo "🥣 BOWLS:"
echo "---------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Bowls"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Measuring Tools
echo ""
echo "📏 MEASURING TOOLS:"
echo "------------------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Measuring Tools"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Whisks
echo ""
echo "🥄 WHISKS:"
echo "----------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Whisks"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Spatulas
echo ""
echo "🥄 SPATULAS:"
echo "------------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Spatulas"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Tongs
echo ""
echo "🔧 TONGS:"
echo "--------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Tongs"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Storage
echo ""
echo "🗄️  STORAGE:"
echo "-----------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Storage"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Bar Tools
echo ""
echo "🍸 BAR TOOLS:"
echo "-------------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Bar Tools"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Strainers
echo ""
echo "🕸️  STRAINERS:"
echo "-------------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Strainers"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Colanders
echo ""
echo "🍝 COLANDERS:"
echo "-------------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Colanders"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

# Knives
echo ""
echo "🔪 KNIVES:"
echo "----------"
echo "$PRODUCTS_JSON" | grep -A 5 -B 1 '"category":"Knives"' | grep '"name"' | sed 's/.*"name":"\([^"]*\)".*/- \1/'

echo ""
echo "💰 Price Summary:"
echo "================="

# Extract and display price ranges
MIN_PRICE=$(echo "$PRODUCTS_JSON" | grep -o '"price":[0-9]*\.[0-9]*' | sort -t: -k2 -n | head -1 | cut -d: -f2)
MAX_PRICE=$(echo "$PRODUCTS_JSON" | grep -o '"price":[0-9]*\.[0-9]*' | sort -t: -k2 -n | tail -1 | cut -d: -f2)

echo "Lowest Price: \$$MIN_PRICE"
echo "Highest Price: \$$MAX_PRICE"

# Calculate total inventory value
TOTAL_VALUE=$(echo "$PRODUCTS_JSON" | grep -o '"price":[0-9]*\.[0-9]*' | cut -d: -f2 | awk '{sum += $1} END {print sum}')
echo "Total Products Value: \$$TOTAL_VALUE"

echo ""
echo "🔗 Quick Links:"
echo "==============="
echo "• Swagger UI: $BASE_URL/swagger-ui/index.html"
echo "• API Documentation: $BASE_URL/v3/api-docs"
echo "• Test API: ./test_api.sh"
echo ""
echo "Happy browsing! 🛍️"
