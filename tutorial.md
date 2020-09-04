# hyperledger fabric2.2 联盟链网络测试
## 1.主机列表
 |节点|IP|组织|
 |---|---|---|
 |order.example.com|161.189.74.20|order|
 |peer0.org1.example.com|52.82.32.71|org1|
 |peer1.org1.example.com|52.82.52.3|org1|
 |peer0.org2.example.com|68.79.46.48|org2|
 |peer1.org2.example.com|68.79.52.144|org3|
将域名以上加入各个主机的/etc/hosts
## 2.主机环境设置
执行initialization.sh 完成主机基础环境工具的安装
## 3. 安装Fabric 二进制文件
将fabric 安装到/usr/local 目录下  

    mkdir fabric && cd fabric && curl -sSL https://bit.ly/2ysbOFE | bash -s
## 4.生成公钥和证书
### 4.1crypto-config.yaml配置

    OrdererOrgs:
    - Name: Orderer
      Domain: example.com
      EnableNodeOUs: true
      Specs:
          - Hostname: orderer
          - Hostname: orderer2
          - Hostname: orderer3
          - Hostname: orderer4
          - Hostname: orderer5
    PeerOrgs:
        - Name: Org1
        Domain: org1.example.com
        EnableNodeOUs: true
        Template:
            Count: 2
        Users:
            Count: 1
        - Name: Org2
        Domain: org2.example.com
        EnableNodeOUs: true
        Template:
            Count: 2
        Users:
            Count: 1
### 4.2 生成证书文件

    cryptogen generate --config=./crypto-config.yaml
### 4.3 configtx.yaml 配置

configtx.yaml 文件
使用configtxgen工具生成区块

    configtxgen -profile SampleMultiNodeEtcdRaft -channelID sys-channel -outputBlock ./channel-artifacts/genesis.block
生成了系统通道的创世块，sys-channel是我们设置的系统创世块名,
./channel-artifacts/genesis.block该创世区块在后面的 Orderer 启动和网络配置会使用到
### 4.4 生成通道
新建 ID 为mychannel的通道，指定通道成员以及访问策略

    configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ../channel-artifacts/channel.tx -channelID mychannel
### 4.5 锚节点更新文件
锚节点负责代表组织与其他组织中的节点进行 Gossip 通信

    configtxgen  -profile TwoOrgsChannel -outputAnchorPeersUpdate ../channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP
    configtxgen  -profile TwoOrgsChannel -outputAnchorPeersUpdate ../channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP
## 5.启动节点
### 5.1 order节点配置启动
docker-compose-order.yaml 文件

    docker-compose -f docker-compose-order.yaml up -d
