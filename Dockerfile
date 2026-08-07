FROM pytorch/pytorch:2.4.1-cuda12.1-cudnn9-runtime
WORKDIR /workspace
ARG FACEFUSION_VERSION=3.8.1

ENV GRADIO_SERVER_NAME=0.0.0.0
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV LD_LIBRARY_PATH=/opt/conda/lib/python3.11/site-packages/nvidia/curand/lib:/opt/conda/lib/python3.11/site-packages/nvidia/cublas/lib:/opt/conda/lib/python3.11/site-packages/nvidia/cufft/lib:/opt/conda/lib/python3.11/site-packages/nvidia/cuda_runtime/lib:/opt/conda/lib/python3.11/site-packages/nvidia/cudnn/lib:/opt/conda/lib/python3.11/site-packages/nvidia/cuda_nvrtc/lib

RUN apt-get update
RUN apt-get install git -y
RUN apt-get install curl -y
RUN apt-get install ffmpeg -y
RUN apt-get install pip -y

RUN git clone https://github.com/facefusion/facefusion.git --branch ${FACEFUSION_VERSION} --single-branch .
RUN python install.py cuda@12 --skip-conda
RUN pip install gradio-rangeslider==0.0.8
RUN pip install gradio==5.50.0
RUN pip install numpy==2.4.6
RUN pip install onnxruntime-gpu
RUN pip install opencv-python-headless==5.0.0.93
RUN pip install tqdm==4.70.0
RUN pip install scipy
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh
ENTRYPOINT ["/workspace/run.sh"]
