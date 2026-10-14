FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=8080

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    sudo \
    htop \
    net-tools \
    iputils-ping \
    iproute2 \
    ca-certificates \
    python3 \
    python3-pip \
    build-essential \
    tmux \
    jq \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 安装 ttyd (网页终端)
RUN arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then ttyd_arch="x86_64"; else ttyd_arch="aarch64"; fi && \
    curl -sLo /usr/local/bin/ttyd "https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.${ttyd_arch}" && \
    chmod +x /usr/local/bin/ttyd

WORKDIR /root

EXPOSE 8080

# 启动网页终端，监听 8080 端口，可直接执行 bash
CMD ["ttyd", "-p", "8080", "-W", "bash"]
