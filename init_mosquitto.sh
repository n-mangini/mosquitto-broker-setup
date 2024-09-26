#!/bin/bash

# Paths to the Mosquitto certificate files
CERT_FILE="./mosquitto/certs/server.crt"
KEY_FILE="./mosquitto/certs/server.key"
CA_FILE="./mosquitto/certs/ca-root-cert.crt"

# Paths to the configuration files
SECURED_CONF="./mosquitto/config/mosquitto.conf.template"
NON_SECURED_CONF="./mosquitto/config/mosquitto-non-secured.conf.template"
TARGET_CONF="./mosquitto/config/mosquitto.conf"

# Check if the DOMAIN_NAME environment variable is set
if [ -z "$DOMAIN_NAME" ]; then
  echo "Error: DOMAIN_NAME environment variable is not set."
  exit 1
fi

# Check if all certificate files exist
if [[ -f "$CERT_FILE" && -f "$KEY_FILE" && -f "$CA_FILE" ]]; then
  echo "TLS certificates found. Using secured Mosquitto configuration."
  # Use secured configuration
  envsubst "${DOMAIN_NAME}" < "$SECURED_CONF" > "$TARGET_CONF"
else
  echo "TLS certificates not found. Using non-secured Mosquitto configuration."
  # Use non-secured configuration
  envsubst "${DOMAIN_NAME}" < "$NON_SECURED_CONF" > "$TARGET_CONF"
fi

# Start Mosquitto after configuration
exec mosquitto -c /mosquitto/config/mosquitto.conf
