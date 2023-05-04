ARG PYTHON_VERSION
ARG DEBIAN_VERSION
ARG TAG=${PYTHON_VERSION}-${DEBIAN_VERSION}
FROM python:${TAG}

# Set the labels
LABEL maintainer="mahmoud@nassarx.com"
LABEL version="1.0"
LABEL description="MLFlow Docker Image for Development (MLOps Classes)"

USER root

# Set the working directory
ENV APP_HOME=/home
ARG APP_HOME="${APP_HOME}"

ARG MLFLOW_SERVER_PORT
ENV MLFLOW_SERVER_PORT=${MLFLOW_SERVER_PORT}

# MLflow version
ARG MLFLOW_VERSION

# Set the default for tracking URI environment variable
ENV MLFLOW_BACKEND_STORE="/home/jovyan/mlruns"
ENV MLFLOW_TRACKING_URI="/home/jovyan/mlruns"

WORKDIR $APP_HOME
RUN mkdir -p /home/jovyan/mlruns

# Create a user
RUN useradd -m -s /bin/bash -N -u 1000 jovyan
RUN chown -R jovyan /home/jovyan/mlruns
RUN chmod -R a+rw /home/jovyan/mlruns

# Install dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        curl \
        git \
        vim \
        telnet \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies from requirements.txt
RUN pip install --upgrade pip
RUN pip install mlflow==$MLFLOW_VERSION

# Copy config files
COPY ./config/requirements.txt $APP_HOME/requirements.txt
RUN pip install -U --no-cache-dir -r $APP_HOME/requirements.txt

# Expose the MLflow port
EXPOSE $MLFLOW_SERVER_PORT

# Set the entrypoint
ADD ./bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]