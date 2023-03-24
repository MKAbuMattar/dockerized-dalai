# Dockerized DalAI

This repository contains the Dockerfile and the scripts to build the Docker image for the [DalAI](https://github.com/cocktailpeanut/dalai) project, documented in the [DalAI documentation](https://cocktailpeanut.github.io/dalai/).

## Building the Docker image

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Building and running the Docker image

To build the Docker image, run the following command:

```bash
# build and run the container in the background
docker-compose up -d --build
```

This will build the Docker image and run the container in the background. The container will be named `dalai`.

**Note**: The first time you run this command, it will take a while to download the base image and install the dependencies. Subsequent runs will be much faster.

**Note**: If you want add more AI models, you can add them to the `docker-compose.yml` file. You can add more than one model by to the `args` section of the `dalai` service. For example, to add the `7B` model, you can add the following line to the `args` section:

```yaml
---
args:
  - LLAMA_VERSION= 7B # add the module version here (e.g. 7B)
  - ALPACA_VERSION= 7B # add the module version here (e.g. 7B)
```

or you can add the models as `volumes`:

```yaml
---
volumes:
  - ./models/alpaca:/root/dalai/alpaca # add the model here
  - ./models/llama:/root/dalai/llama # add the model here
```

After the container is running, you can access the DalAI web interface at [http://localhost:3000](http://localhost:3000).

## Stopping the Docker container

To stop the Docker container, run the following command:

```bash
docker-compose down
```

## Cleaning up

To remove the Docker image, run the following command:

```bash
docker rmi dalai
```

## License

This project is licensed under the [MIT License](LICENSE).
