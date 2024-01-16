import os

IMAGE_SIZE = 160  # All images will be resized to this size
DETECTION_THRESHOLD = 0.1  # Probability threshold to detect a face
VERIFICATION_THRESHOLD = 0.1  # Distance threshold to decide whether faces belong to the same person

SEED = 42

DATA_PATH = 'data/'
CASIA_PATH = 'data/CASIA-WebFace/'
LFW_PATH = 'data/lfw/lfw_cropped'
LFW_PAIRS_PATH = 'data/lfw/pairs.txt'
LOG_DIR = 'runs/'


casia_cropped_path = os.path.join(DATA_PATH, 'CASIA-WebFace-cropped/')
# casia_cropped_path = '/kaggle/input/casia-webface-cropped-with-mtcnn/CASIA-WebFace-cropped'
# casia_cropped_path = '/kaggle/input/casia-webface-mtcnn-v2/CASIA-WebFace-cropped'
# casia_cropped_path = '/kaggle/input/casia-webface-v3/CASIA-WebFace-cropped'


# RMQ_SERVER = "amqps://ubhptxwu:eh0iTQ0D22adEkSc9kyb2gB8hTZ_yVOt@armadillo.rmq.cloudamqp.com/ubhptxwu"
RMQ_SERVER = "armadillo.rmq.cloudamqp.com"
RMQ_PORT = 5672
RMQ_USER = "ubhptxwu"
RMQ_PASSWORD = "eh0iTQ0D22adEkSc9kyb2gB8hTZ_yVOt"
RMQ_VIRTUAL_HOST = "ubhptxwu"
RMQ_SOURCE_QUEUE = "queue.model.input"
RMQ_COMPLETED_EXCHANGE = "exchange.model.output"