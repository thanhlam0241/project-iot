import pika
import sys
import ssl
import binascii

from rabbitmq import Model
from utils import empty_folder
from config import *


connection = pika.BlockingConnection(pika.ConnectionParameters(
    host='armadillo.rmq.cloudamqp.com',
    port=5671,
    virtual_host='ubhptxwu',
    credentials=pika.PlainCredentials('ubhptxwu', 'eh0iTQ0D22adEkSc9kyb2gB8hTZ_yVOt'),
    ssl_options=pika.SSLOptions(ssl.create_default_context()),
    ))
channel = connection.channel()
channel.queue_declare(queue='queue.model.input')
channel.queue_declare(queue='exchange.model.output')

def attendance_result_json(request_id, label):
    return '{"requestId":"%s", "label":"%s"}' % (request_id, label)

def binToHex(bin):
    s = binascii.hexlify(bin)
    return s.decode()

def callback(ch, method, properties, body):
    # Creare model
    model = Model()

    # Empty the app_data/temp/picture and app_data/temp/cropped folders
    empty_folder("app_data/temp/picture")
    empty_folder("app_data/temp/cropped")

    is_register = body[0] != 0
    request_id = binToHex(body[1:17])
    label = is_register and binToHex(body[17:29]) or ''
    imageCount = int(body[29])

    # Save the images to the app_data/temp/picture folder
    image_pos = 30 + imageCount * 4
    for i in range(imageCount):
        image_size = int.from_bytes(body[30 + i * 4: 34 + i * 4], 'little')
        image = body[image_pos:image_pos + image_size]

        # Save file to hello folder
        f = open("app_data/temp/picture/image%s_%d.jpg" % (request_id, i), "wb")
        f.write(image)
        f.close()

        image_pos += image_size


    if is_register:
        sucess = model.register(label)
        if sucess:
            return_json = attendance_result_json(request_id, label)
        else:
            return_json = attendance_result_json(request_id, "")
    else:
        identified_user = model.identification()
        return_json = attendance_result_json(request_id, identified_user)


    channel.basic_publish(exchange='', routing_key='exchange.model.output', body=return_json)
    ch.basic_ack(delivery_tag = method.delivery_tag)

channel.basic_qos(prefetch_count=1)
channel.basic_consume(on_message_callback=callback, queue='queue.model.input')
print("Start consuming...")
channel.start_consuming()