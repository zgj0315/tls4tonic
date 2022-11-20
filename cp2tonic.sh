#!/bin/bash
set -xe
cp home-ca/crts/sub-ca.crt ../../hyperium/tonic/examples/data/tls/ca.pem
cp home-ca/private/torsen-ca.key ../../hyperium/tonic/examples/data/tls/server.key
cp home-ca/crts/torsen-ca.crt ../../hyperium/tonic/examples/data/tls/server.pem
