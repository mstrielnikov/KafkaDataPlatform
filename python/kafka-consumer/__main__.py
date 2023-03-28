from kafka import KafkaConsumer

# Define the Kafka consumer configuration
consumer = KafkaConsumer(
    'my_topic',
    bootstrap_servers=['localhost:9092'],
    auto_offset_reset='earliest',
    enable_auto_commit=True,
    group_id='my_group',
    value_deserializer=lambda x: x.decode('utf-8')
)

# Consume messages from a Kafka topic
for message in consumer:
    print(message.value)