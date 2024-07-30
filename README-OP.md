# 构建基础镜像 ,进行编译
docker build -t xubiao05/ekuiper-base:1.0.0 -f Dockerfile .

# 构建一个编译环境
docker-compose -f docker-compose.yml up -d 

# 编译增加插件
# https://ekuiper.org/docs/zh/latest/guide/sinks/plugin/tdengine.html

# 安装tdegnien插件
sh build-plugins.sh sinks tdengine  安装好了，生成的在对应的目录下面
# 在执行一次 会将插件生成在对应的目录下面
go build -trimpath --buildmode=plugin -o plugins/sinks/Tdengine@v1.0.0.so extensions/sinks/tdengine/tdengine.go

# 编译安装一个docker镜像
docker buildx build --no-cache --platform=linux/amd64 -t xubiao05/lfedge/ekuiper:v1.0.0 -f deploy/docker/Dockerfile-full . --load

# https://ekuiper.org/docs/zh/latest/installation.html 可以按需编译
+ 编译二进制：

    - 编译二进制文件: `$ make`

    - 编译支持 EdgeX 的二进制文件: `$ make build_with_edgex`

    - 编译核心包的二进制文件: `$ make build_core`

+ 安装文件打包：

    - 安装文件打包：: `$ make pkg`

    - 支持 EdgeX 的安装文件打包: `$ make pkg_with_edgex`

# 编译镜像
+ Docker 镜像：`$ make docker`

  > Docker 镜像默认支持 EdgeX
  > 


编译含有tdengine的边缘计算
docker build -t xubiao05/ekuiper-tdengine:1.0.0 -f Dockerfile-tdengine .

# 插件部署
https://ekuiper.org/docs/zh/latest/operation/manager-ui/plugins_in_manager.html
# 容器初始化部署
1） 需要先安装客户端的tdengine
2) 将so文件挂载到容器中