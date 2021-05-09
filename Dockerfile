FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-devel
ENV NVIDIA_VISIBLE_DEVICES all

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}

RUN apt-get update && apt-get install -y \
    build-essential \
    tmux \
    curl \
    unzip \
    git \
    libsndfile1 \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/NVIDIA/apex /apex
WORKDIR /apex/
RUN git checkout 37cdaf4
RUN pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" .

RUN pip install --no-cache-dir \
    "cython==0.29.12" \ 
    "librosa==0.7.2" \ 
    "numpy==1.17.4" \ 
    "scipy==1.4.1" \ 
    "numba==0.48" \
    "Unidecode==1.0.22" \
    "tensorflow==2.3.0" \ 
    "inflect==4.1.0" \
    "matplotlib==3.3.0" \
    "jupyterlab"

RUN mkdir -p /content/glow-tts

WORKDIR /content/glow-tts

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=*", "--port=8888", "--no-browser", "--allow-root"]
