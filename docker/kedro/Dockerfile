ARG PYTHON_VERSION
ARG DEBIAN_VERSION
ARG TAG=${PYTHON_VERSION}-${DEBIAN_VERSION}

FROM python:${TAG} as base

# Set the labels
LABEL maintainer="mahmoud@nassarx.com"
LABEL version="1.0"
LABEL description="Python Docker Image for Development"

# Install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        build-essential \
        cmake \
        curl \
        ca-certificates \
        gcc \
        locales \
        wget \
        git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
ENV APP_HOME=/home/kedro
WORKDIR $APP_HOME

# add kedro user
ARG KEDRO_UID=999
ARG KEDRO_GID=0
RUN groupadd -f -g ${KEDRO_GID} kedro_group && \
    useradd -m -d ${APP_HOME} -s /bin/bash -g ${KEDRO_GID} -u ${KEDRO_UID} kedro

# Copy config files and install dependencies
COPY ./config/requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && \
    pip install -U -r /tmp/requirements.txt && \
    rm -f /tmp/requirements.txt

# Switch to the kedro user
USER kedro

FROM base as final

# Set the working directory
ENV APP_HOME=/home/kedro
WORKDIR $APP_HOME

# Fix permissions for kedro user
USER root
RUN chown -R kedro:${KEDRO_GID} ${APP_HOME}

# Copy kedro script
COPY ./bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

# Switch to the kedro user
USER kedro
RUN chmod -R a+w ${APP_HOME}

# Set the environment variables
ARG PROJECT_NAME=default
ENV PROJECT_NAME="${PROJECT_NAME}"

ARG OUTPUT_DIR="."
ENV OUTPUT_DIR="${OUTPUT_DIR}"

ARG REPO_NAME=default
ENV REPO_NAME="${REPO_NAME}"

ARG PYTHON_PACKAGE=default
ENV PYTHON_PACKAGE="${PYTHON_PACKAGE}"

# Set the entrypoint
ENTRYPOINT ["docker-entrypoint"]

# Expose ports for Jupyter (8888), kedro-viz (4141), and mlflow (5000)
EXPOSE 8888 4141 5000

# Keep the container running by using an infinite loop
CMD tail -f /dev/null

