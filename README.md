# Make Cert For Tonic TLS
## 1 工程说明
### 1.1 build.sh
生成证书脚本  
执行build-ca.sh，会在home-ca目录中生成对应证书文件

### 1.2 home-ca/private
私钥目录，保护好这个目录内的文件
```
root-ca.key: 根私钥
sub-ca.key: 扩展私钥
dj-ca.key: 服务器私钥
```

### 1.3 home-ca/csrs
证书签名申请文件目录

### 1.4 rsa/server
证书目录

## 2 tonic框架证书说明
Tonic框架中，支持TLS证书，其中涉及到的三个文件制作方法
文件地址：https://github.com/hyperium/tonic/tree/master/examples/data/tls
### 2.1 ca.pem
签名证书  
对应本工程中home-ca/crts/sub-ca.cert

### 2.2 server.pem
服务端证书  
对应本工程中home-ca/crts/dj-ca.cert

### 2.3 server.key
服务端私钥  
对应本工程中home-ca/private/dj-ca.key
