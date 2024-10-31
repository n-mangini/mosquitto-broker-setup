# Mosquitto MQTT Setup

This project provides a configurable Mosquitto MQTT broker setup with three main options:
- **Open Mode**: No encryption (TLS) and no authentication.
- **Secured Mode**: TLS encryption.
- **Auth Mode**: Username/password authentication.

These options can be combined to create different configurations:
- **Open**: No TLS, No Authentication.
- **Secured**: TLS Only.
- **Auth**: Authentication Only.
- **Secured + Auth**: TLS with Authentication.

## Configuration Files

### 1. `mosquitto-open.conf.template`
- **Description**: Fully open mode with **no encryption (TLS)** and **no authentication**.
- **Settings**:
  - Listens on port `1883`.
  - `allow_anonymous true`: Allows any client to connect without a username/password.

### 2. `mosquitto-secure.conf.template`
- **Description**: Secured mode with **TLS encryption**.
- **Settings**:
  - Listens on port `8883` with TLS enabled.
  - Includes CA, server certificate, and server key paths.

### 3. `mosquitto-auth.conf.template`
- **Description**: Authenticated mode with **username/password authentication**.
- **Settings**:
  - Listens on port `1883`.
  - `allow_anonymous false`: Requires clients to authenticate using a username/password.

### 4. `mosquitto-secure-auth.conf.template`
- **Description**: Combined secured and authenticated mode with **TLS encryption** and **username/password authentication**.
- **Settings**:
  - Listens on port `8883` with TLS enabled.
  - `allow_anonymous false`: Requires clients to authenticate using a username/password.
  - Specifies CA, server certificate, server key, and password file paths.

## Usage

### 1. Open Mode
This mode enables Mosquitto without any encryption or authentication, making it accessible to any client.

### 2. Secured Mode (TLS Only)
This mode enables Mosquitto with TLS encryption only, without requiring authentication.

**To enable secured mode**:
1. Run the `generate-certificates.sh` script to create TLS certificates:
   ```bash
   ./generate-certificates.sh

### 3. Auth Mode
This mode enables authentication with username and password.

**To enable auth mode**:
1. Run the `generate-passwd.sh` script to create passwd file
      ```bash
      ./generate-passwd.sh
