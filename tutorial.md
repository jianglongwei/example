# hyperledger fabric2.2 联盟链网络测试
## 1.主机列表
 |节点|IP|组织|
 |---|---|---|
 |order.example.com|161.189.74.20|order|
 |peer0.org0.example.com|52.82.32.71|org0|
 |peer1.org0.example.com|52.82.52.3|org0|
 |peer0.org1.example.com|68.79.46.48|org1|
 |peer1.org1.example.com|68.79.52.144|org1|
将域名以上加入各个主机的/etc/hosts
## 2.主机环境设置
执行initialization.sh 完成主机基础环境工具的安装
## 3.生成公钥和证书
### 3.1crypto-config.yaml配置

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
