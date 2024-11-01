import paho.mqtt.client as mqtt
from include.config import CERT,BROKER, PORT, USERNAME, PASSWORD


def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe("test/topic")
def on_message(client, userdata, msg):
    print(msg.topic + " " + str(msg.payload))


client = mqtt.Client()
client.username_pw_set(USERNAME, PASSWORD)
client.tls_set(ca_certs = CERT)
client.connect(BROKER, PORT, 60)
client.on_connect = on_connect
client.on_message = on_message
client.loop_forever()
