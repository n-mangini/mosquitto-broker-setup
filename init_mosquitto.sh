#!/bin/bash

# Paths to Mosquitto certificate and password files
CERT_FILE="./mosquitto/certs/server.crt"
KEY_FILE="./mosquitto/certs/server.key"
CA_FILE="./mosquitto/certs/ca-root-cert.crt"
PASSWORD_FILE="/mosquitto/config/passwd"
CONF_FILE="./mosquitto/config/mosquitto.conf"

# Paths to configuration templates
OPEN_TEMPLATE="./mosquitto/config/mosquitto-open.conf.template"
SECURE_TEMPLATE="./mosquitto/config/mosquitto-secure.conf.template"
AUTH_TEMPLATE="./mosquitto/config/mosquitto-auth.conf.template"

# Define the service user (mosquitto in this case)
SERVICE_USER="mosquitto"
SERVICE_GROUP="mosquitto"

# Function to check if TLS is enabled
function tls_enabled {
    [[ -f "$CERT_FILE" && -f "$KEY_FILE" && -f "$CA_FILE" ]]
}

# Function to check if authentication is enabled
function auth_enabled {
    [[ -f "$PASSWORD_FILE" ]]
}

echo "Generating Mosquitto configuration based on available files..."

# Start with the open configuration template
cat "$OPEN_TEMPLATE" > "$CONF_FILE"

# If TLS certificates are present, append the TLS settings from the secure template
if tls_enabled; then
    echo "TLS certificates found. Adding secured configuration."

    # Remove the default listener on port 1883 from the configuration file if it exists
    sed -i '/^listener 1883/d' "$CONF_FILE"

    # Set ownership and permissions for TLS files
    chown $SERVICE_USER:$SERVICE_GROUP "$CERT_FILE" "$KEY_FILE" "$CA_FILE"
    chmod 644 "$CERT_FILE" "$CA_FILE"
    chmod 600 "$KEY_FILE"

    # Append the TLS configuration to the main config
    cat "$SECURE_TEMPLATE" >> "$CONF_FILE"
fi

# If authentication is enabled, append the authentication settings from the auth template
if auth_enabled; then
    echo "Password file found. Adding authentication configuration."

    # Remove the line `allow_anonymous true` from the configuration file if it exists
    sed -i '/^allow_anonymous true/d' "$CONF_FILE"

    # Append the authentication configuration to the main config
    cat "$AUTH_TEMPLATE" >> "$CONF_FILE"
fi

echo "Mosquitto configuration generated successfully in $CONF_FILE."

# Start Mosquitto with the generated configuration
exec mosquitto -c "$CONF_FILE"
