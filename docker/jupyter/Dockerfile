ARG JUPYTER_BASE_IMAGE="scipy-notebook"
ARG JUPYTER_BASE_VERSION="latest"
FROM jupyter/${JUPYTER_BASE_IMAGE}:${JUPYTER_BASE_VERSION} AS jupyter

LABEL maintainer="mahmoud@nassarx.com"
LABEL version="1.0"
LABEL description="Jupyter notebook Docker Image for Development."

WORKDIR "${HOME}/work"

# Set User to Root
USER root

# Install missing dependencies.
RUN apt-get update &&  \
    apt-get upgrade -y &&  \
    apt-get install -y \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set User back to Jovyan
USER ${NB_UID}

# Install torch
RUN python3 -m pip install --upgrade pip && \
     python3 -m pip install --no-cache-dir \
    'torch' &&\
    python3 -m pip cache purge && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Copy config files
COPY ./config/* /home/${NB_USER}/

## Install dependencies from requirements.txt
RUN python3 -m pip install -U --no-cache-dir -r /home/${NB_USER}/requirements.txt

# Start Jupyter
CMD ["jupyter", "notebook", "list"]