#!/bin/sh

set -e

if [ -z "$MLFLOW_BACKEND_STORE" ]; then
  echo >&2 "MLFLOW DIR must be set"
  exit 1
fi

mlflow server \
    --backend-store-uri "$MLFLOW_TRACKING_URI" \
    --default-artifact-root "$MLFLOW_TRACKING_URI" \
    --host 0.0.0.0 \
    --port $MLFLOW_SERVER_PORT