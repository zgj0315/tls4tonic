#!/bin/bash
# Root CA Directory Structure
rm -rf root-ca
mkdir root-ca
cp root-ca.conf root-ca/
cp sub-ca.conf root-ca/
cd root-ca
mkdir certs db private
chmod 700 private
touch db/index
openssl rand -hex 16 >db/serial
echo 1001 >db/crlnumber

# Root CA Generation
openssl req -new \
  -config root-ca.conf \
  -out root-ca.csr \
  -keyout private/root-ca.key

openssl ca -selfsign \
  -config root-ca.conf \
  -in root-ca.csr \
  -out root-ca.crt \
  -extensions ca_ext

# Root CA Operations
openssl ca -gencrl \
  -config root-ca.conf \
  -out root-ca.crl

openssl ca \
  -config root-ca.conf \
  -in sub-ca.csr \
  -out sub-ca.crt \
  -extensions sub_ca_ext

openssl ca \
  -config root-ca.conf \
  -revoke certs/1002.pem \
  -crl_reason keyCompromise

# Create a Certificate for OCSP Signing
openssl req -new \
  -newkey rsa:2048 \
  -subj "/C=CN/O=After90/CN=OCSP Root Responder" \
  -keyout private/root-ocsp.key \
  -out root-ocsp.csr

openssl ca \
  -config root-ca.conf \
  -in root-ocsp.csr \
  -out root-ocsp.crt \
  -extensions ocsp_ext \
  -days 30

openssl ocsp \
  -port 9080 \
  -index db/index \
  -rsigner root-ocsp.crt \
  -rkey private/root-ocsp.key \
  -CA root-ca.crt \
  -text

openssl ocsp \
  -issuer root-ca.crt \
  -CAfile root-ca.crt \
  -cert root-ocsp.crt \
  -url http://127.0.0.1:9080
