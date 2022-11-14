# OpenSSL命令学习记录

```shell
# 清场
rm fd.key
rm fd.csr
rm fd.crt

# 生成私钥
openssl genrsa -aes256 -out fd.key 4096

# 解析私钥的结构
openssl rsa -text -in fd.key

# 创建证书签名申请
openssl req -new -key fd.key -out fd.csr

# 查看证书签名申请内容
openssl req -text -in fd.csr -noout

# 自签名证书（通过证书签名申请生成签名证书）
openssl x509 -req -days 365 -in fd.csr -signkey fd.key -out fd.crt

# 自签名证书（通过私钥直接生成签名证书）
openssl req -new -x509 -days 365 -key fd.key -out fd.crt

# 自签名证书（通过-subj参数方式输入标题信息）
openssl req -new -x509 -days 365 -key fd.key -out fd.crt \
-subj "/C=CN/L=Beijing/O=After90/CN=www.after90.com"

# 查看签名证书
openssl x509 -text -in fd.crt -noout

```