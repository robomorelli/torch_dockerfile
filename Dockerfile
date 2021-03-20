FROM nvidia/cuda:11.0-devel-ubuntu18.04

# Python 3.7 is supported by Ubuntu Bionic out of the box
ARG python=3.7
ENV PYTHON_VERSION=${python}

RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        nano \
        curl


RUN ln -s /usr/bin/python${PYTHON_VERSION} /usr/bin/python

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py


# set working directory
WORKDIR /app

# copy 'app' subfolder content to current directory, i.e. '/app'
COPY . .

# run command at build time
RUN pip install torch==1.8.0+cu111 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install -r requirements.txt

# define Start-up Command, Entrypoint is null
#CMD ["python", "main.py"]
ENTRYPOINT ["/bin/bash"]
