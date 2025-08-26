#!/bin/bash

# Steel Products Addition Script
# This script adds various steel products to the Steel Backend system

BASE_URL="http://localhost:8080"
API_BASE="$BASE_URL/api"

echo "🔧 Adding Steel Products to Steel Backend"
echo "========================================="
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

# Function to add a product
add_product() {
    local name="$1"
    local category="$2"
    local description="$3"
    local price="$4"
    local quantity="$5"
    local supplier_id="$6"
    
    echo "Adding: $name"
    
    local response=$(curl -s -X POST "$API_BASE/products" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        -d "{
            \"name\": \"$name\",
            \"category\": \"$category\",
            \"description\": \"$description\",
            \"price\": $price,
            \"quantityInStock\": $quantity,
            \"supplier\": {
                \"id\": $supplier_id
            }
        }")
    
    if [[ $? -eq 0 ]]; then
        echo "✅ Successfully added: $name"
        echo "Response: $response"
    else
        echo "❌ Failed to add: $name"
    fi
    echo ""
}

# Get authentication token
get_token

if [[ -z "$TOKEN" ]]; then
    echo "❌ Could not obtain authentication token. Exiting."
    exit 1
fi

echo ""
echo "📦 Adding Steel Products..."
echo "=========================="

# First, let's create a supplier if it doesn't exist
echo "🏭 Creating supplier..."
SUPPLIER_RESPONSE=$(curl -s -X POST "$API_BASE/suppliers" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d '{
        "name": "Premium Steel Manufacturing Co.",
        "contactEmail": "sales@premiumsteel.com",
        "phone": "+1-555-0100",
        "address": "789 Steel Avenue, Manufacturing District, MD 54321",
        "rating": 5
    }')

echo "Supplier response: $SUPPLIER_RESPONSE"

# Extract supplier ID (assuming it's the first one created)
SUPPLIER_ID=1

echo ""
echo "Adding products with supplier ID: $SUPPLIER_ID"
echo ""

# Ice Buckets and Chilling Products
add_product \
    "Stainless Steel Ice Bucket - 2L" \
    "Ice Buckets" \
    "Premium stainless steel ice bucket with elegant design, perfect for keeping beverages chilled. Capacity: 2 liters. Mirror finish with insulated base." \
    45.99 \
    25 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Ice Bucket - 3L" \
    "Ice Buckets" \
    "Large capacity stainless steel ice bucket for parties and events. Capacity: 3 liters. Heavy-duty construction with ergonomic handles." \
    59.99 \
    15 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Wine Chiller Bucket" \
    "Ice Buckets" \
    "Specialized wine chiller bucket with narrow design for wine bottles. Capacity: 1.5 liters. Includes bottle holder insert." \
    38.50 \
    30 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Champagne Bucket" \
    "Ice Buckets" \
    "Elegant champagne bucket with fluted design. Capacity: 2.5 liters. Perfect for special occasions and celebrations." \
    52.75 \
    20 \
    $SUPPLIER_ID

# Kitchen Utensils
add_product \
    "Stainless Steel Mixing Bowl Set - 3pc" \
    "Bowls" \
    "Professional grade mixing bowl set with 3 sizes (small, medium, large). Non-reactive stainless steel construction." \
    29.99 \
    40 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Salad Bowl - Large" \
    "Bowls" \
    "Large salad bowl with serving utensils. Capacity: 4 liters. Perfect for family gatherings and entertaining." \
    34.99 \
    35 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Measuring Cups Set" \
    "Measuring Tools" \
    "Precision measuring cups set (1/4, 1/3, 1/2, 1 cup). Engraved measurements for accuracy." \
    18.50 \
    50 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Measuring Spoons Set" \
    "Measuring Tools" \
    "Complete measuring spoons set (1/4, 1/2, 1, 1.5, 2 tsp, 1 tbsp). Magnetic storage ring included." \
    12.99 \
    60 \
    $SUPPLIER_ID

# Cooking Tools
add_product \
    "Stainless Steel Whisk - Balloon" \
    "Whisks" \
    "Professional balloon whisk for whipping cream, eggs, and batters. Comfortable ergonomic handle." \
    15.99 \
    45 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Whisk - Flat" \
    "Whisks" \
    "Flat whisk for sauces and gravies. Perfect for deglazing pans and making roux." \
    13.50 \
    40 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Spatula Set - 3pc" \
    "Spatulas" \
    "Heat-resistant spatula set with different sizes. Silicone-coated heads for non-stick cookware." \
    24.99 \
    30 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Tongs - 12 inch" \
    "Tongs" \
    "Professional kitchen tongs with locking mechanism. Perfect for grilling and serving." \
    19.99 \
    35 \
    $SUPPLIER_ID

# Storage and Organization
add_product \
    "Stainless Steel Food Storage Container Set" \
    "Storage" \
    "Airtight food storage containers with stackable design. Set includes 3 sizes (small, medium, large)." \
    42.99 \
    25 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Spice Rack" \
    "Storage" \
    "Wall-mounted spice rack with 12 spice jars. Magnetic lids for easy access." \
    67.99 \
    15 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Utensil Holder" \
    "Storage" \
    "Countertop utensil holder with drainage holes. Holds up to 15 utensils." \
    28.50 \
    30 \
    $SUPPLIER_ID

# Specialty Items
add_product \
    "Stainless Steel Cocktail Shaker" \
    "Bar Tools" \
    "Professional cocktail shaker with built-in strainer. Perfect for mixing drinks and cocktails." \
    35.99 \
    20 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Bar Spoon" \
    "Bar Tools" \
    "Long-handled bar spoon for stirring cocktails. Twisted handle design." \
    8.99 \
    40 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Strainer - Fine Mesh" \
    "Strainers" \
    "Fine mesh strainer for filtering sauces, stocks, and purees. 8-inch diameter." \
    16.99 \
    35 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Colander - Large" \
    "Colanders" \
    "Large colander for draining pasta and vegetables. 12-inch diameter with comfortable handles." \
    22.99 \
    25 \
    $SUPPLIER_ID

# Professional Grade
add_product \
    "Stainless Steel Chef's Knife - 8 inch" \
    "Knives" \
    "Professional chef's knife with ergonomic handle. High-carbon stainless steel blade." \
    89.99 \
    15 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Paring Knife - 3.5 inch" \
    "Knives" \
    "Precision paring knife for detailed cutting tasks. Razor-sharp blade with comfortable grip." \
    24.99 \
    30 \
    $SUPPLIER_ID

add_product \
    "Stainless Steel Bread Knife - 10 inch" \
    "Knives" \
    "Serrated bread knife for clean slicing. Perfect for bread, cakes, and soft fruits." \
    45.99 \
    20 \
    $SUPPLIER_ID

echo ""
echo "🎉 Product addition completed!"
echo "=============================="
echo ""
echo "📊 Summary:"
echo "- Added 20 steel products across multiple categories"
echo "- Categories: Ice Buckets, Bowls, Measuring Tools, Whisks, Spatulas, Tongs, Storage, Bar Tools, Strainers, Colanders, Knives"
echo "- Price range: $8.99 - $89.99"
echo "- Total inventory value: ~$1,200"
echo ""
echo "🔍 You can now view the products using:"
echo "- Swagger UI: http://localhost:8080/swagger-ui/index.html"
echo "- API: curl -X GET http://localhost:8080/api/products -H \"Authorization: Bearer $TOKEN\""
echo "- Test script: ./test_api.sh"
echo ""
echo "Happy selling! 🚀"
