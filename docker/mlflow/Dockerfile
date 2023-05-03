ARG PYTHON_VERSION
ARG DEBIAN_VERSION
ARG TAG=${PYTHON_VERSION}-${DEBIAN_VERSION}
FROM python:${TAG}

LABEL maintainer="mahmoud@nassarx.com"
LABEL version="1.0"
LABEL description="MLFlow Docker Image for Development (MLOps Classes)"

# Set the working directory
ENV APP_HOME=/app
ARG APP_HOME="${APP_HOME}"
WORKDIR $APP_HOME

RUN chmod +x $APP_HOME

# Install dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        curl \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# MLflow version
ARG MLFLOW_VERSION

# Install dependencies from requirements.txt
RUN pip install --upgrade pip
RUN pip install mlflow==$MLFLOW_VERSION

# Copy config files
COPY ./config/* $APP_HOME/
RUN pip install -U --no-cache-dir -r $APP_HOME/requirements.txt

# Set the default for tracking URI environment variable
ENV MLFLOW_BACKEND="file"
ENV MLFLOW_TRACKING_URI="file:///app/mlflow"

# Expose the MLflow port
ARG MLFLOW_SERVER_PORT
EXPOSE $MLFLOW_SERVER_PORT

# Start the MLflow server
CMD if [ $MLFLOW_BACKEND = "file" ]; then \
       echo "Starting MLflow server with file backend..." && \
       mlflow server --backend-store-uri "${MLFLOW_TRACKING_URI}" --host 0.0.0.0; \
    else \
       echo "Starting MLflow server with other backend..." && \
       mlflow server --backend-store-uri "${MLFLOW_TRACKING_URI}" --default-artifact-root file:/app/artifacts --host 0.0.0.0; \
    fi


