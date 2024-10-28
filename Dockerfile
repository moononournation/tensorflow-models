FROM python:3.10-slim

WORKDIR /app

# runtime dependencies
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
        python3-dev \
        python3-pip \
        python3-venv \
        protobuf-compiler \
        imagemagick \
	; \
	rm -rf /var/lib/apt/lists/*

# install and upgrade python utils
RUN pip install --upgrade pip

# install tensorflow
RUN pip install tensorflow==2.17.0
RUN pip install flask mtcnn numpy protobuf

# git clone --depth 1 https://github.com/tensorflow/models
COPY models/research/object_detection ./models/research/object_detection
RUN cd models/research/ && protoc object_detection/protos/*.proto --python_out=. && cp object_detection/packages/tf2/setup.py . && python -m pip install .

# preload models
COPY preloadmodel.py .
# RUN python preloadmodel.py 'CenterNet HourGlass104 512x512'
# RUN python preloadmodel.py 'CenterNet HourGlass104 Keypoints 512x512'
# RUN python preloadmodel.py 'CenterNet HourGlass104 1024x1024'
# RUN python preloadmodel.py 'CenterNet HourGlass104 Keypoints 1024x1024'
# RUN python preloadmodel.py 'CenterNet Resnet50 V1 FPN 512x512'
# RUN python preloadmodel.py 'CenterNet Resnet50 V1 FPN Keypoints 512x512'
# RUN python preloadmodel.py 'CenterNet Resnet101 V1 FPN 512x512'
RUN python preloadmodel.py 'CenterNet Resnet50 V2 512x512'
# RUN python preloadmodel.py 'CenterNet Resnet50 V2 Keypoints 512x512'
# RUN python preloadmodel.py 'EfficientDet D0 512x512'
# RUN python preloadmodel.py 'EfficientDet D1 640x640'
# RUN python preloadmodel.py 'EfficientDet D2 768x768'
# RUN python preloadmodel.py 'EfficientDet D3 896x896'
# RUN python preloadmodel.py 'EfficientDet D4 1024x1024'
# RUN python preloadmodel.py 'EfficientDet D5 1280x1280'
# RUN python preloadmodel.py 'EfficientDet D6 1280x1280'
# RUN python preloadmodel.py 'EfficientDet D7 1536x1536'
# RUN python preloadmodel.py 'SSD MobileNet v2 320x320'
# RUN python preloadmodel.py 'SSD MobileNet V1 FPN 640x640'
# RUN python preloadmodel.py 'SSD MobileNet V2 FPNLite 320x320'
# RUN python preloadmodel.py 'SSD MobileNet V2 FPNLite 640x640'
# RUN python preloadmodel.py 'SSD ResNet50 V1 FPN 640x640 (RetinaNet50)'
# RUN python preloadmodel.py 'SSD ResNet50 V1 FPN 1024x1024 (RetinaNet50)'
# RUN python preloadmodel.py 'SSD ResNet101 V1 FPN 640x640 (RetinaNet101)'
# RUN python preloadmodel.py 'SSD ResNet101 V1 FPN 1024x1024 (RetinaNet101)'
# RUN python preloadmodel.py 'SSD ResNet152 V1 FPN 640x640 (RetinaNet152)'
# RUN python preloadmodel.py 'SSD ResNet152 V1 FPN 1024x1024 (RetinaNet152)'
# RUN python preloadmodel.py 'Faster R-CNN ResNet50 V1 640x640'
# RUN python preloadmodel.py 'Faster R-CNN ResNet50 V1 1024x1024'
# RUN python preloadmodel.py 'Faster R-CNN ResNet50 V1 800x1333'
# RUN python preloadmodel.py 'Faster R-CNN ResNet101 V1 640x640'
# RUN python preloadmodel.py 'Faster R-CNN ResNet101 V1 1024x1024'
# RUN python preloadmodel.py 'Faster R-CNN ResNet101 V1 800x1333'
# RUN python preloadmodel.py 'Faster R-CNN ResNet152 V1 640x640'
# RUN python preloadmodel.py 'Faster R-CNN ResNet152 V1 1024x1024'
# RUN python preloadmodel.py 'Faster R-CNN ResNet152 V1 800x1333'
# RUN python preloadmodel.py 'Faster R-CNN Inception ResNet V2 640x640'
# RUN python preloadmodel.py 'Faster R-CNN Inception ResNet V2 1024x1024'
# RUN python preloadmodel.py 'Mask R-CNN Inception ResNet V2 1024x1024'
