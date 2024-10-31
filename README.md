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

## Usage
Create your own .env using [.sample.env](https://github.com/n-mangini/mqtt-encrypted/blob/main/.sample.env) as a template.
### 1. Open Mode: 
Just run the docker-compose without any further configuration
### 2. Secured Mode (TLS Only): 
Run [./generate-certificates.sh](https://github.com/n-mangini/mqtt-encrypted/blob/main/mosquitto/certs/generate-ceritificates.sh) script to create TLS certificates, then run [docker-compose](https://github.com/n-mangini/mqtt-encrypted/blob/main/docker-compose.yml).
### 3. Auth Mode: 
Run [./generate-passwd.sh](https://github.com/n-mangini/mqtt-encrypted/blob/main/mosquitto/config/generate-passw.sh) script to create passwd file, then run [docker-compose](https://github.com/n-mangini/mqtt-encrypted/blob/main/docker-compose.yml).

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
  - `allow_anonymous false`: Requires clients to authenticate using a username/password.
  - Specifies the path to the password file (`/mosquitto/config/passwd`).
