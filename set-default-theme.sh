#!/bin/bash

# Wait for Keycloak to be ready
echo "Waiting for Keycloak to be ready..."
until curl -f http://localhost:8080/health/ready 2>/dev/null; do
    echo "Waiting for Keycloak..."
    sleep 5
done

echo "Keycloak is ready! Setting default theme..."

# Get admin token
ADMIN_TOKEN=$(curl -s -X POST http://localhost:8080/realms/master/protocol/openid-connect/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d "password=admin123" \
  -d "grant_type=password" \
  -d "client_id=admin-cli" | jq -r '.access_token')

if [ "$ADMIN_TOKEN" = "null" ] || [ -z "$ADMIN_TOKEN" ]; then
    echo "Failed to get admin token"
    exit 1
fi

# Set the theme for the master realm
curl -s -X PUT http://localhost:8080/admin/realms/master \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "loginTheme": "my-theme",
    "accountTheme": "my-theme",
    "adminTheme": "my-theme",
    "emailTheme": "my-theme"
  }'

echo "Default theme set to 'my-theme' for master realm!"

# Create a test realm with the theme
curl -s -X POST http://localhost:8080/admin/realms \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "realm": "test",
    "enabled": true,
    "displayName": "Test Realm",
    "loginTheme": "my-theme",
    "accountTheme": "my-theme",
    "adminTheme": "my-theme",
    "emailTheme": "my-theme"
  }'

echo "Test realm created with 'my-theme' as default!"

echo "You can now access:"
echo "- Admin Console: http://localhost:8080/admin"
echo "- Test Realm: http://localhost:8080/realms/test/account"