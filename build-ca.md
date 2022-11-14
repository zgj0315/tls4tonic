```shell
# Root CA Directory Structure
home_ca="home-ca"
rm -rf $home_ca
mkdir $home_ca
cd $home_ca
mkdir certs db private
chmod 700 private
touch db/index
openssl rand -hex 16 >db/serial
echo 1001 >db/crlnumber

# Root CA Generation
openssl req -new \
  -config ../root-ca.conf \
  -out root-ca.csr \
  -keyout private/root-ca.key

openssl ca -selfsign \
  -config ../root-ca.conf \
  -in root-ca.csr \
  -out root-ca.crt \
  -extensions ca_ext

# Subordinate CA Generation
openssl req -new \
  -config ../sub-ca.conf \
  -out sub-ca.csr \
  -keyout private/sub-ca.key

openssl ca \
  -config ../root-ca.conf \
  -in sub-ca.csr \
  -out sub-ca.crt \
  -extensions sub_ca_ext

# DJ CA Generation
openssl req -new \
  -config ../dj-ca.conf \
  -out dj-ca.csr \
  -keyout private/dj-ca.key

openssl ca \
  -config ../sub-ca.conf \
  -in dj-ca.csr \
  -out dj-ca.crt \
  -extensions dj_ca_ext

```