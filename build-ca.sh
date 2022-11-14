#!/bin/bash
home_ca="home-ca"
rm -rf $home_ca
mkdir -p $home_ca/certs $home_ca/db $home_ca/private
chmod 700 $home_ca/private
touch $home_ca/db/index
openssl rand -hex 16 >$home_ca/db/serial
echo 1001 >$home_ca/db/crlnumber

# Root CA Generation
openssl req -nodes \
    -x509 \
    -days 3650 \
    -newkey rsa:4096 \
    -keyout $home_ca/private/root-ca.key \
    -out $home_ca/root-ca.crt \
    -sha256 \
    -batch \
    -subj "/CN=Root CA"

# Subordinate CA Generation
openssl req -nodes \
    -newkey rsa:3072 \
    -keyout $home_ca/private/sub-ca.key \
    -out $home_ca/sub-ca.csr \
    -sha256 \
    -batch \
    -subj "/CN=Sub CA"

openssl x509 -req \
    -in $home_ca/sub-ca.csr \
    -out $home_ca/sub-ca.crt \
    -CA $home_ca/root-ca.crt \
    -CAkey $home_ca/private/root-ca.key \
    -sha256 \
    -days 3650 \
    -set_serial 123 \
    -extensions sub_ca_ext -extfile build-ca.conf

# DJ CA Generation
openssl req -nodes \
    -newkey rsa:2048 \
    -keyout $home_ca/private/dj-ca.key \
    -out $home_ca/dj-ca.csr \
    -sha256 \
    -batch \
    -subj "/CN=DJ CA"

openssl x509 -req \
    -in $home_ca/dj-ca.csr \
    -out $home_ca/dj-ca.crt \
    -CA $home_ca/sub-ca.crt \
    -CAkey $home_ca/private/sub-ca.key \
    -sha256 \
    -days 2000 \
    -set_serial 456 \
    -extensions dj_ca_ext -extfile build-ca.conf
