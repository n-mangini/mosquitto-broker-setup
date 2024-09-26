#!/bin/bash

# Paths to the Mosquitto certificate files
CERT_FILE="./mosquitto/certs/server.crt"
KEY_FILE="./mosquitto/certs/server.key"
CA_FILE="./mosquitto/certs/ca-root-cert.crt"

# Paths to the configuration files
SECURED_CONF="./mosquitto/config/mosquitto.conf.template"
NON_SECURED_CONF="./mosquitto/config/mosquitto-non-secured.conf.template"
TARGET_CONF="./mosquitto/config/mosquitto.conf"

# Define the service user (mosquitto in this case)
SERVICE_USER="mosquitto"
SERVICE_GROUP="mosquitto"

# Check if all certificate files exist
if [[ -f "$CERT_FILE" && -f "$KEY_FILE" && -f "$CA_FILE" ]]; then
  echo "TLS certificates found. Using secured Mosquitto configuration."

  # Change ownership of the certificate files to the service user
  chown $SERVICE_USER:$SERVICE_GROUP "$CERT_FILE" "$KEY_FILE" "$CA_FILE"
  
  # Set correct permissions: 644 for certs, 600 for private key
  chmod 644 "$CERT_FILE" "$CA_FILE"
  chmod 600 "$KEY_FILE"

  # Use secured configuration
  cp "$SECURED_CONF" "$TARGET_CONF"
else
  echo "TLS certificates not found. Using non-secured Mosquitto configuration."
  
  # Use non-secured configuration
  cp "$NON_SECURED_CONF" "$TARGET_CONF"
fi

# Start Mosquitto after configuration
exec mosquitto -c /mosquitto/config/mosquitto.conf