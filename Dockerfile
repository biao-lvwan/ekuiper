# 使用官方 Ubuntu 镜像作为基础镜像
FROM ubuntu:latest

# 换源
RUN  echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list  \
        && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list  \
        && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list # buildkit


# 设置环境变量
ENV GOLANG_VERSION 1.22.5
ENV GOLANG_SRC_URL https://dl.google.com/go/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV GOPROXY https://goproxy.cn,direct
ENV PATH $GOPROXY/bin:$GOROOT/bin:$GOPATH/bin:$PATH

# 更新软件包索引并安装必要的工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    curl \
    gcc \
    build-essential \
    coreutils \
    vim \
    bash \
    zip \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY tar/go1.22.5.linux-amd64.tar.gz /tmp/go.tar.gz
# 下载并安装 Go
RUN  tar -C /usr/local -xzf /tmp/go.tar.gz \
     && rm -rf /tmp/go.tar.gz

# 创建工作目录
WORKDIR $GOPATH

# 可选：将 Go 的 bin 目录添加到 PATH 环境变量
RUN echo "export PATH=$GOROOT/bin:$GOPATH/bin:$PATH" >> /etc/profile

# 可选：设置 GOROOT 环境变量
RUN echo "export GOROOT=$GOROOT" >> /etc/profile

# 可选：设置 GOPATH 环境变量
RUN echo "export GOPATH=$GOPATH" >> /etc/profile

RUN echo "export GOPROXY=$GOPROXY" >> /etc/profile

# 可选：在容器启动时执行的命令
#CMD ["go", "version"]
WORKDIR /app
CMD ["sh", "-c", "while true; do sleep 1; done"]