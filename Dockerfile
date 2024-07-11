FROM ollama/ollama:latest


FROM ubuntu:22.04

# Configure NVIDIA things
ENV NVIDIA_DRIVER_CAPABILITIES=all

# Install necessary packages
RUN apt-get update && apt-get install -y \
    lsb-release \
    gnupg2 \
    curl \
    openssh-server \
    iproute2

# Install python
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.9 \
    python3-pip \
    python-is-python3 \
    python3-setuptools


RUN apt-get update && apt-get install -y \
    nano \
    git \
    sudo

# Install necessary python packages
RUN pip install --upgrade pip
RUN pip install \
    gpt4all \
    flask

# Installing Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh
RUN pip install ollama


# Setup the workspace
RUN mkdir -p light_chatbot

EXPOSE 22

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]