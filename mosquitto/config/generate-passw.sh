#!/bin/bash

# Path to the Mosquitto password file
PASSWORD_FILE="passwd"

# Ensure the mosquitto_passwd command is available
if ! command -v mosquitto_passwd &> /dev/null
then
    echo "Error: mosquitto_passwd command not found. Please install Mosquitto utilities."
    exit 1
fi

# Prompt for username
read -p "Enter the username for Mosquitto authentication: " USERNAME

# Check if password file already exists
if [ ! -f "$PASSWORD_FILE" ]; then
    echo "Creating new password file at $PASSWORD_FILE"
    sudo mosquitto_passwd -c "$PASSWORD_FILE" "$USERNAME"
else
    echo "Adding user to existing password file at $PASSWORD_FILE"
    sudo mosquitto_passwd "$PASSWORD_FILE" "$USERNAME"
fi

# Set permissions on the password file to secure it
echo "Setting permissions for the password file..."
sudo chown mosquitto:mosquitto "$PASSWORD_FILE"
sudo chmod 600 "$PASSWORD_FILE"

echo "User $USERNAME has been added to the Mosquitto password file."
