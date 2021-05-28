FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu18.04

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN apt-get update -q \
  && DEBIAN_FRONTEND="noninteractive" \
  apt-get install -yq \
    python3=3.6.7-1~18.04 \
    python3-pip=9.0.1-2.3~ubuntu1.18.04.4 \
    software-properties-common=0.96.24.32.14 \
  && add-apt-repository -y ppa:deadsnakes/ppa \
  && DEBIAN_FRONTEND="noninteractive" \
  apt-get install -yq \
    python3.8=3.8.10-1+bionic1 \
  && python3.8 -m pip install --upgrade pip \
  && apt-get clean \
  && mkdir /workspace

WORKDIR /workspace
COPY requirements.txt ./
RUN python3.8 -m pip install -r requirements.txt \
      -f https://download.pytorch.org/whl/torch_stable.html

COPY main.py ./

ENTRYPOINT ["python3.8", "main.py"]