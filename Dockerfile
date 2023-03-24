# ARG for the base image
ARG BASE_IMAGE=python:3.10-slim-buster

# use python as the base image
FROM ${BASE_IMAGE} AS base

# update and install dependencies
RUN apt-get update \
  && apt-get install -y \
  build-essential \
  curl \
  g++ \
  git \
  make \
  python3-venv \
  software-properties-common

# add NodeSource PPA to get Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

# Install Node.js 18.x
RUN apt-get update \
  && apt-get install -y nodejs

FROM base AS builder

# work directory
WORKDIR /app

# clone repository dalai repo
RUN git clone --depth 1 https://github.com/cocktailpeanut/dalai.git .

# install npm dependencies
RUN npm install

# ARGs are used to pass the version of the base image and the LLaMA and Alpaca modules
ARG LLAMA_VERSION=""
ARG ALPACA_VERSION=""

ENV LLAMA_VERSION=${LLAMA_VERSION}
ENV ALPACA_VERSION=${ALPACA_VERSION}

# install the LLaMA module
# there are more modules available:
# - 7B
#   - Full: The model takes up 31.17GB
#   - Quantized: 4.21GB
# - 13B
#   - Full: The model takes up 60.21GB
#   - Quantized: 4.07GB * 2 = 8.14GB
# - 30B
#   - Full: The model takes up 150.48GB
#   - Quantized: 5.09GB * 4 = 20.36GB
# - 65B
#   - Full: The model takes up 330.48GB
#   - Quantized: 5.11GB * 8 = 40.88GB
RUN if [ -n "${LLAMA_VERSION}" ]; then npx --verbose dalai llama install ${LLAMA_VERSION}; fi

# install the Alpaca module
# there are more modules available:
# - 7B
#   - Compressed: 4.21GB
# - 13B
#   - Compressed: 8.14GB
RUN if [ -n "${ALPACA_VERSION}" ]; then npx --verbose dalai alpaca install ${ALPACA_VERSION}; fi

# expose port 3000
EXPOSE 3000

# start the application
CMD ["npx", "--verbose", "dalai", "serve"]