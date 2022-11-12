#!/bin/sh

set -xe

rm -rf rsa/
mkdir -p rsa/root
mkdir -p rsa/intermediate
mkdir -p rsa/server

openssl req -nodes \
          -x509 \
          -days 3650 \
          -newkey rsa:4096 \
          -keyout rsa/root/ca.key \
          -out rsa/root/ca.crt \
          -sha256 \
          -batch \
          -subj "/CN=After90 RSA CA"

openssl req -nodes \
          -newkey rsa:3072 \
          -keyout rsa/intermediate/inter.key \
          -out rsa/intermediate/inter.csr \
          -sha256 \
          -batch \
          -subj "/CN=After90 RSA level 2 intermediate"

openssl req -nodes \
          -newkey rsa:2048 \
          -keyout rsa/server/server.key \
          -out rsa/server/server.csr \
          -sha256 \
          -batch \
          -subj "/CN=after90.com"

openssl x509 -req \
          -in rsa/intermediate/inter.csr \
          -out rsa/intermediate/inter.crt \
          -CA rsa/root/ca..cr t \
          -CAkey rsa/root/ca.key \
          -sha256 \
          -days 3650 \
          -set_serial 123 \
          -extensions v3_inter -extfile openssl.cnf

openssl x509 -req \
          -in rsa/server/server.csr \
          -out rsa/server/server.crt \
          -CA rsa/intermediate/inter.crt \
          -CAkey rsa/intermediate/inter.key \
          -sha256 \
          -days 2000 \
          -set_serial 456 \
          -extensions v3_server -extfile openssl.cnf
