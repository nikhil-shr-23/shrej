#!/bin/bash

echo "🔍 Testing Products API - Simple Debug"
echo "======================================"

# Get a fresh token
echo "1. Getting authentication token..."
TOKEN_RESPONSE=$(curl -s -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}')

echo "Token response: $TOKEN_RESPONSE"

# Extract token
TOKEN=$(echo "$TOKEN_RESPONSE" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
echo "Extracted token: ${TOKEN:0:50}..."

# Test products endpoint
echo ""
echo "2. Testing products endpoint..."
PRODUCTS_RESPONSE=$(curl -s -X GET http://localhost:8080/api/products \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json")

echo "Products response length: ${#PRODUCTS_RESPONSE}"
echo "Products response (first 200 chars): ${PRODUCTS_RESPONSE:0:200}"

# Test with verbose output
echo ""
echo "3. Testing with verbose output..."
curl -v -X GET http://localhost:8080/api/products \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" 2>&1 | head -30

echo ""
echo "✅ Test completed!"
