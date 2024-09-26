#!/bin/bash

# Variables for file paths
CA_KEY="ca.key"
CA_CSR="ca-cert-request.csr"
CA_CERT="ca-root-cert.crt"
SERVER_KEY="server.key"
SERVER_CSR="server-cert-request.csr"
SERVER_CERT="server.crt"
DAYS_VALID=365

# Step 1: Generate the CA key
echo "Generating the CA key..."
openssl genrsa -out $CA_KEY 2048

# Step 2: Create a certificate signing request (CSR) for the CA
echo "Creating a CSR for the CA..."
openssl req -new -key $CA_KEY -out $CA_CSR -sha256 -subj "/O=Autoridad falsa/CN="

# Step 3: Create the CA root certificate
echo "Creating the CA root certificate..."
openssl x509 -req -in $CA_CSR -signkey $CA_KEY -out $CA_CERT -days $DAYS_VALID -sha256

# Step 4: Generate the server key
echo "Generating the server key..."
openssl genrsa -out $SERVER_KEY 2048

# Step 5: Create a CSR for the server
echo "Creating a CSR for the server..."
openssl req -new -key $SERVER_KEY -out $SERVER_CSR -sha256 -subj "/O=MQTT Broker SA/CN=your.domain.com"

# Step 6: Sign the server certificate with the CA
echo "Signing the server certificate with the CA..."
openssl x509 -req -in $SERVER_CSR -CA $CA_CERT -CAkey $CA_KEY -CAcreateserial -out $SERVER_CERT -days $DAYS_VALID

# Final Message
echo "TLS Certificates and keys created successfully."
echo "CA Certificate: $CA_CERT"
echo "Server Certificate: $SERVER_CERT"
echo "Server Key: $SERVER_KEY"
