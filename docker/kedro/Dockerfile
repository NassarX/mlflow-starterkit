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
ENV APP_HOME=/home/kedro
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
COPY ./config/requirements.txt /tmp/requirements.txt

# Install dependencies from requirements.txt
RUN pip install --upgrade pip
RUN pip install -U --no-cache-dir -r /tmp/requirements.txt && rm -f /tmp/requirements.txt

# add kedro user
ARG KEDRO_UID=999
ARG KEDRO_GID=0
RUN groupadd -f -g ${KEDRO_GID} kedro_group && \
useradd -d ${APP_HOME} -s /bin/bash -g ${KEDRO_GID} -u ${KEDRO_UID} kedro

# Set the environment variables
ARG PROJECT_NAME=default
ENV PROJECT_NAME="${PROJECT_NAME}"

ARG OUTPUT_DIR="."
ENV OUTPUT_DIR="${OUTPUT_DIR}"

ARG REPO_NAME=default
ENV REPO_NAME="${REPO_NAME}"

ARG PYTHON_PACKAGE=default
ENV PYTHON_PACKAGE="${PYTHON_PACKAGE}"

# Add docker-entrypoint
COPY ./bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint

# Fix permissions for kedro user
RUN chown -R kedro:${KEDRO_GID} ${APP_HOME}
RUN chmod -R a+w ${APP_HOME}
RUN chmod +x /usr/local/bin/docker-entrypoint

USER kedro
EXPOSE 8888 4141

ENTRYPOINT ["docker-entrypoint"]

# start the server
CMD ["jupyter", "notebook"]