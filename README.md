# MLFLow Server - Jupyter Notebook StarterKit

A Dockerized environment for [Jupyter](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html) notebooks and [MLflow server](https://www.mlflow.org/docs/latest/index.html), providing an easy and customizable setup for data scientists and ML engineers. Seamlessly connect Jupyter and MLflow servers to streamline machine learning workflows and track experiments.

## Table of Contents

- [Motivation](#motivation)
- [Features](#features)
- [Quick Start](#quick-start)
  - [Pre-requisites](#pre-requisites)
    - [Docker](#docker) 
    - [Environment Variables](#environment-variables)
      - [Jupyter Notebook](#jupyter-notebook)
      - [MLflow Server](#mlflow-server)
  - [Up And Running](#up-and-running)
    - [Jupyter Notebook](#jupyter-notebook)
    - [MLflow Server](#mlflow-server)
    - [Jupyter Notebook & MLflow Server](#jupyter-notebook--mlflow-server)
    - [Accessing Services](#accessing-services)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Future Work](#future-work)
- [Contributing](#contributing)

## Motivation

Setting up the necessary environment for your next project can be a time-consuming and frustrating process. This became clear during my recent MLOps class where many of us struggled to set up Jupyter Notebook and MLflow server environments.

The project allows for easy customization of Jupyter Notebook and MLflow server configurations through Docker Compose, making it easy to switch between different setups.

## Features

- Dockerized environment for Jupyter notebooks and MLflow server, allowing for easy setup and deployment.
- Choice of Jupyter Notebook stacks including `jupyter/minimal-notebook`, `jupyter/scipy-notebook`, and `jupyter/all-spark-notebook`, and more.
- **MLFlow Configurable Metadata Store**: The flexibility to configure [metadata](https://mlflow.org/docs/latest/tracking.html) (e.g. metrics, parameters) store. You can choose to use a relational database like MySQL, PostgreSQL or SQLite by default. Alternatively, you can configure the system to use Amazon S3 for storing the metadata.
- **MLFlowConfigurable Artifact Store**:  The flexibility to configure [artifacts](https://www.mlflow.org/docs/latest/tracking.html#storage) store. By default, the artifacts are stored on the local file system. However, you can configure the system to use a cloud storage as AWS S3, Google Cloud Storage, or Azure.
- Streamlined connection between Jupyter Notebook and MLflow server.

## Quick Start

Make sure to Review the [Pre-requisites](#pre-requisites) section below before getting started.

### Pre-requisites

#### Docker

This application is shipped with the Docker Compose environment and requires Docker to be installed locally and running.
If you're not familiar with Docker or don't have it locally, please reach out to 
[the official website](https://www.docker.com)
 to learn more and follow the Docker installation instructions to install it on your platform:   

[Docker for Mac](https://docs.docker.com/desktop/install/mac-install/)  
[Docker for Linux](https://docs.docker.com/desktop/get-started/)  
[Docker for Windows](https://docs.docker.com/desktop/install/windows-install/)

The Project is containerized within two containers currently build on top of [jupyter/scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook) and [Python-3.10-slim](https://hub.docker.com/_/python/tags) images both images could be customized via `.env` choose the one that fits your needs `version` and `system distribution` wise, requirements.txt attached and could be customized to add more dependencies.

#### Environment Variables

Make sure to copy the `.env.example` file located in the root directory of the project and rename it to `.env` before running containers.

#### JUPYTER NOTEBOOK
| Variable | Description                    | Default Value            |
| --- |--------------------------------|--------------------------|
| `JUPYTER_IMAGE` | Jupyter Notebook image         | `jupyter/scipy-notebook` |
| `MLFLOW_IMAGE` | MLflow server image            | `python:3.10-slim`       |
| `JUPYTER_PORT` | Jupyter Notebook port          | `8888`                   |
| `JUPYTER_HOST_PORT` | Jupyter Notebook host port     | `8899`                   |
| `JUPYTER_TOKEN` | Jupyter Notebook default token | `jupyter`                |
| `MLFLOW_VERSION` | MLflow version                 | `2.3.1`                  |
 

#### MLFLOW SERVER
| Variable | Description                    | Default Value            |
| --- |--------------------------------|--------------------------|
| `PYTHON_VERSION` | Python version                 | `3.10`                   |
| `DEBIAN_VERSION` | Debian version                 | `slim-buster`            |
| `MLFLOW_SERVER_PORT` | MLflow server port             | `5000`                   |
| `MLFLOW_SERVER_HOST_PORT` | MLflow server host port        | `5001`                   |
| `MLFLOW_BACKEND_STORE` | MLflow backend store           | `/home/jovyan/mlruns`    |
| `MLFLOW_TRACKING_URI` | MLflow tracking URI            | `/home/jovyan/mlruns`    |

### Up And Running


#### Jupyter Notebook

In case you want to run the Jupyter Notebook container only, run the following commands:

To build and run the Jupyter Notebook container:

```bash
docker build -t nassarx/mlflow-starter-notebook:1.0 -f ./docker/jupyter/Dockerfile \
--build-arg MLFLOW_VERSION=<version> \
--build-arg JUPYTER_BASE_IMAGE=<image> \
--build-arg JUPYTER_BASE_VERSION=<version> .
```

```bash
docker run -p <host_port>:<container_port> -e GRANT_SUDO=yes -e JUPYTER_TOKEN=<token> \
-v <local_notebooks_dir>:/home/jovyan/work nassarx/mlflow-starter-notebook:1.0
```

Or simply run the following command to build and run the container from docker-compose:

```bash
docker-compose up mlflow-starter-notebook
```

#### MLflow Server

In case you want to run the MLflow server container only, run the following commands:

To build and run the MLflow server container, run the following commands:
```bash
docker build -t nassarx/mlflow-starter-server:1.0 ./docker/mlflow --build-arg PYTHON_VERSION=<version> \
--build-arg DEBIAN_VERSION=<version> --build-arg MLFLOW_VERSION=<version> --build-arg MLFLOW_SERVER_PORT=<port> \
--build-arg MLFLOW_BACKEND_STORE=<store_uri> --build-arg MLFLOW_TRACKING_URI=<tracking_uri> .
```

```bash
docker run --name mlflow-starter-server \
-p <host_port>:<container_port> \
-e MLFLOW_BACKEND_STORE=<backend_store> \
-e MLFLOW_TRACKING_URI=<tracking_uri> \
-v <local_mlflow_dir>:/home/jovyan \
nassarx/mlflow-starter-server:1.0
```

Or simply run the following command to build and run the container from docker-compose:

```bash
docker-compose up mlflow-starter-server
```

#### Jupyter Notebook & MLflow Server

To build and run both containers on same network, run the following commands:

```bash
docker-compose up
```

Alternatively you can start the application containers in detached mode to suppress containers messages:

```bash
docker-compose up --detach
```

To stop and remove containers, run the following command:

```bash
docker-compose down --rmi all
```
**Note: The `--rmi all` flag will remove all images associated with the containers. If you want to keep the images, remove the flag.**

#### Accessing Services

- Jupyter Notebook will be listening on ports `8899` on your `localhost`, you can access the application main page using your browser using the following URL: [http://localhost:8899](http://localhost:8899).
or configure your IDE to connect to the notebook server using the following URL: [http://localhost:8899](http://localhost:8899).
**Note: You'll need to provide the token you've set in the `.env` file to access the notebook server.**

- MLflow server will be listening on ports `5001` on your `localhost`, you can access the application main page using your browser using the following URL: [http://localhost:5001](http://localhost:5001).

## Project Structure

````
.
├── _mlflow
│   └── mlruns
│       ├── 0
│       ├── 24552641888*****
│       ├── 31988532510*****
│       ├── 61683865883*****
│       ├── etc
│       └── models
├── docker
│   ├── jupyter
│   │   └── config
│   │   └── Dockerfile
│   └── mlflow
│       ├── bin
│       └── config
│       └── Dockerfile
└── notebooks
└── docker-compose.yml
└── .env
└── .env.example
└── .gitignore
└── README.md
````

## Usage

- To connect to mlflow server from jupyter notebook running on the same network, use the following code:

  ```python
  mlflow.set_tracking_uri("http://mlflow-starter-server:5000")
  ```

**Note: The `mlflow-starter-server` is the name of the container running the mlflow server.**

- To connect to mlflow server from jupyter notebook running on a different network, use the following code:

  ```python
  mlflow.set_tracking_uri("http://<host_ip>:5001")
  ```

**Note: The `host_ip` is the ip address of the host machine running the mlflow server, could be your local machine (localhost) or a remote server.**

## Future Work

As part of ongoing development, we plan to extend the capabilities of the project to make it more versatile and customizable. Specifically, we plan to add the following features:

- [ ] Configure PostgreSQL, MySQL, or SQLite as a backend store for storing metadata such as metrics, parameters, and tags.
- [ ] Configure AWS S3, Google Cloud Storage, or Azure Blob Storage as artifact stores for storing the model artifacts and other output files generated during the experiments.
- [ ] Provide an abstract configuration interface that allows users to easily switch between different backend stores and artifact stores based on their needs and preferences.
- [ ] Enhance the integration with other popular ML frameworks and libraries beside PyTorch such as TensorFlow to support a wider range of use cases and workflows.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)
