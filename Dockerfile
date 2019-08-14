FROM nvidia/cuda:10.1-cudnn7-devel

ENV DEBIAN_FRONTEND noninteractive

#install git & opencv 
RUN apt-get update && \
    apt-get install -qqy \
        git \
        libopencv-dev &&\
    rm -rf /var/lib/apt/lists/*
        
#install darknet-yolo
RUN git clone https://github.com/AlexeyAB/darknet.git /darknet &&\
    cd /darknet &&\
    #sed -i "s/GPU=0/GPU=1/g" Makefile &&\
    #sed -i "s/CUDNN=0/CUDNN=1/g" Makefile && \ 
    sed -i "s/OPENCV=0/OPENCV=1/g" Makefile && \
    make && \
    mv darknet /usr/bin/darknet && \
    chmod +x /usr/bin/darknet && \
    rm -rf /darknet

# Create projectdir
RUN mkdir /project

# Make default dir
WORKDIR /project

# Set a default entrypoint
ENTRYPOINT [ "darknet" ]

# Set default CMD
CMD ["detector", "train", "data/obj.data", "cfg/yolo.cfg", "weights/yolo.weights", "-dont_show"]
