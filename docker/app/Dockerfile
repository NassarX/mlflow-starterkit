ARG PYTHON_VERSION
ARG DEBIAN_VERSION
ARG TAG=${PYTHON_VERSION}-${DEBIAN_VERSION}
FROM python:${TAG}

# Set the labels
LABEL maintainer="mahmoud@nassarx.com"
LABEL version="1.0"
LABEL description="Python Docker Image for Development"

ARG DEBIAN_FRONTEND=noninteractive
ENV PATH="${HOME}/miniconda3/bin:${PATH}"
ARG PATH="${HOME}/miniconda3/bin:${PATH}"

# Set the working directory
ENV APP_HOME=/code
ARG APP_HOME="${APP_HOME}"
WORKDIR $APP_HOME

# Install dependencies
RUN apt-get update &&  \
    apt-get upgrade -y &&  \
    apt-get install -y \
    build-essential \
    cmake \
    curl \
    ca-certificates \
    gcc \
    locales \
    wget \
    git \
    ffmpeg \
    libsm6 \
    libxext6 \
    libc6 \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy config files
COPY ./config/* $APP_HOME/

# Install dependencies from requirements.txt
RUN pip install --upgrade pip
RUN pip install -U --no-cache-dir -r $APP_HOME/requirements.txt

# Install the as  package in "editable" mode.
RUN pip install -e .

# start the server
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80", "--reload"]