安装教程
1 执行命令

yum install wget unzip -y
2创建一个目录放配置以及chromium

mkdir nolanjdc && cd nolanjdc
3下载config.json 配置文件 并且修改自己的配置 不能缺少

wget -O Config.json  https://raw.githubusercontent.com/NolanHzy/nvjdc/main/Config.json
国内请使用

wget -O Config.json   https://ghproxy.com/https://raw.githubusercontent.com/NolanHzy/nvjdc/main/Config.json
4 创建chromium文件夹并进入

mkdir -p  .local-chromium/Linux-884014 && cd .local-chromium/Linux-884014
5下载 chromium

wget https://mirrors.huaweicloud.com/chromium-browser-snapshots/Linux_x64/884014/chrome-linux.zip && unzip chrome-linux.zip
6删除刚刚下载的压缩包

rm  -f chrome-linux.zip
7 回到刚刚创建的目录

cd  /nolanjdc
8拉镜像

sudo docker pull nolanhzy/nvjdc:0.5
9启动镜像

sudo docker run   --name nolanjdc -p 9096:80 -d  -v  "$(pwd)"/Config.json:/app/Config/Config.json:ro \
-v "$(pwd)"/.local-chromium:/app/.local-chromium  \
-it --privileged=true  nolanhzy/nvjdc:0.7 
10查看 日志

docker logs -f nolanjdc 

出现 NETJDC started 即可

更新
删除容器

docker rm -f nolanjdc 
删除镜像

docker rmi -f nolanhzy/nvjdc:0.4
进入你以前下载过 浏览器 和JSON配置的文件夹中 如原来在 root 下 nolanjdc 文件夹中 下载的配置与浏览器

cd /root/nolanjdc 
