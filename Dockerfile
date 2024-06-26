FROM ubuntu:22.04

# Arguments for the user of the container - these options have to be passed when building the image
ARG USERNAME
ARG USERID
ARG GROUPID

# Set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    lsb-release \
    gnupg2 \
    curl

# Install python
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.9 \
    python3-pip \
    python-is-python3 \
    python3-setuptools


RUN apt-get update && apt-get install -y \
    nano \
    git

# Install necessary python packages
RUN pip install --upgrade pip
RUN pip install \
    gpt4all \
    flask

    ## Setup the users

# Properly setup the root password so that we have control to log in
RUN echo "root:root" | chpasswd

# Create the user and set it up
RUN groupadd -g $GROUPID -o $USERNAME
RUN useradd -m -u $USERID -g $GROUPID -o -s /bin/bash $USERNAME
RUN echo "$USERNAME:passwd" | chpasswd
RUN adduser $USERNAME sudo


# Change to the user to run non-root tasks
USER $USERNAME


# Setup the workspace
WORKDIR "/home/$USERNAME"
RUN mkdir -p light_chatbot

WORKDIR "/home/$USERNAME/light_chatbot"
