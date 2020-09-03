#!/bin/bash

# initialization 脚本主要完成服务器初始化工具安装
# curl
# wget
# docker 
# docker-compose
# Go
# java

echo "<<---------------install curl start---------------->>";
sudo yum install curl -y
echo "<<---------------install curl end---------------->>";

echo "<<---------------install wget start---------------->>";
sudo yum install wget -y
echo "<<---------------install wget end---------------->>";

echo "<<---------------install docker start---------------->>";
sudo yum install docker-ce docker-ce-cli containerd.io -y
echo "<<---------------install docker end---------------->>";

echo "<<---------------install docker-compose start---------------->>";
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
echo "<<---------------install docker-compose end---------------->>";



echo "<<---------------install java start---------------->>";

sudo yum install java-1.8.0-openjdk
java -version
echo "<<---------------install java end---------------->>";


echo "<<---------------install Go start---------------->>";
cd /usr/local

sudo wget https://golang.google.cn/dl/go1.14.4.linux-amd64.tar.gz

sudo tar -xvf  go1.13.4.linux-amd64.tar.gz

echo "<<---------------install Go end---------------->>";

echo "基础的工具已完成安装，请配置Go的环境变量";
echo "sudo vim /etc/profile";
echo "Export GOPATH=/usr/local/go1.13.4/go";
echo "Export PATH=$PATH:$GOPATH/bin";
echo "source /etc/profile";

