# Make Cert For Tonic TLS
## 1 工程说明
### 1.1 build.sh
生成证书脚本  
执行build.sh，会在rsa目录中生成对应证书文件

### 1.2 rsa/root
根证书目录，用于签发中间证书，保护好这个目录内的文件
```
ca.key: 根私钥
ca.cert: 根证书
```

### 1.3 rsa/intermediate
中间证书目录，用于签发各种业务证书，保护好私钥文件
```
inter.key: 中间证书私钥
inter.csr: 中间证书签名申请文件
inter.cert: 中间签名证书
```
### 1.4 rsa/server
服务端证书目录，用于服务端程序
```
server.key: 服务端证书
server.csr: 服务端证书签名申请文件
server.cert: 服务端签名证书
```
## 2 tonic框架证书说明
Tonic框架中，支持TLS证书，其中涉及到的三个文件制作方法
文件地址：https://github.com/hyperium/tonic/tree/master/examples/data/tls
### 2.1 ca.pem
签名证书  
对应本工程中rsa/intermediate/inter.cert

### 2.2 server.pem
服务端证书  
对应本工程中rsa/server/server.cert

### 2.3 server.key
服务端私钥  
对应本工程中rsa/server/server.key
