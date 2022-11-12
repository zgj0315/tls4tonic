#!/bin/bash
# Subordinate CA Generation
openssl req -new \
  -config sub-ca.conf \
  -out sub-ca.csr \
  -keyout private/sub-ca.key

openssl ca \
  -config root-ca.conf \
  -in sub-ca.csr \
  -out sub-ca.crt \
  -extensions sub_ca_ext

# Subordinate CA Operations
openssl ca \
  -config sub-ca.conf \
  -in server.csr \
  -out server.crt \
  -extensions server_ext

openssl ca \
  -config sub-ca.conf \
  -in client.csr \
  -out client.crt \
  -extensions client_ext
