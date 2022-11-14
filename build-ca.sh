#!/bin/bash
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
openssl req -nodes \
    -x509 \
    -days 3650 \
    -newkey rsa:4096 \
    -keyout private/root-ca.key \
    -out root-ca.crt \
    -sha256 \
    -batch \
    -subj "/CN=Root CA"

# Subordinate CA Generation
openssl req -nodes \
    -newkey rsa:3072 \
    -keyout private/sub-ca.key \
    -out sub-ca.csr \
    -sha256 \
    -batch \
    -subj "/CN=Sub CA"

openssl x509 -req \
    -in sub-ca.csr \
    -out sub-ca.crt \
    -CA root-ca.crt \
    -CAkey private/root-ca.key \
    -sha256 \
    -days 3650 \
    -set_serial 123 \
    -extensions v3_inter -extfile ../openssl.cnf

# DJ CA Generation
openssl req -nodes \
    -newkey rsa:2048 \
    -keyout private/dj-ca.key \
    -out dj-ca.csr \
    -sha256 \
    -batch \
    -subj "/CN=DJ CA"

openssl x509 -req \
    -in dj-ca.csr \
    -out dj-ca.crt \
    -CA sub-ca.crt \
    -CAkey private/sub-ca.key \
    -sha256 \
    -days 2000 \
    -set_serial 456 \
    -extensions v3_server -extfile ../openssl.cnf