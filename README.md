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

> **Note**: The first time you run this command, it will take a while to download the base image and install the dependencies. Subsequent runs will be much faster.

> **Note**: If you want add more AI models, you can add them to the `Dockerfile` and rebuild the image.

```dockerfile
# install the LLaMA module
# there are more modules available:
# - 7B: LLaMA 7B
#   - Full: The model takes up 31.17GB
#   - Quantized: 4.21GB
# - 13B: LLaMA 13B
#   - Full: The model takes up 60.21GB
#   - Quantized: 4.07GB * 2 = 8.14GB
# - 30B
#   - Full: The model takes up 150.48GB
#   - Quantized: 5.09GB * 4 = 20.36GB
# - 65B
#   - Full: The model takes up 330.48GB
#   - Quantized: 5.11GB * 8 = 40.88GB
RUN npx --verbose dalai llama install 7B 13B 30B 65B

# install the Alpaca module
# there are more modules available:
# - 7B: Alpaca 7B
#   - Compressed: 4.21GB
RUN npx --verbose dalai alpaca install 7B
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
