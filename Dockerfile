# use ubuntu latest
FROM ubuntu:latest

# metadata
LABEL maintainer="Mohammad Abu Mattar"
LABEL container="DalAI"
LABEL version="0.0.1"

# set work directory
WORKDIR /app

# update and install dependencies
RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:deadsnakes/ppa -y && \
  apt-get update && \
  apt-get install -y python3.10 python3-pip python3-venv python-is-python3 && \
  apt-get install -y build-essential cmake curl gcc git make && \
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get install -y nodejs

# clone repository dalai repo
RUN git clone https://github.com/cocktailpeanut/dalai.git . --depth 1

# install npm dependencies
RUN npm install

# install Python dependencies
RUN pip install torch

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
# RUN npx --verbose dalai llama install 7B

# install the Alpaca module
# there are more modules available:
# - 7B: Alpaca 7B
#   - Compressed: 4.21GB
RUN npx --verbose dalai alpaca install 7B

# expose port 3000
EXPOSE 3000

# start the application
CMD ["npx", "--verbose", "dalai", "serve"]
