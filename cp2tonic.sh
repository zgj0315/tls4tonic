#!/bin/bash
set -xe
cp home-ca/crts/sub-ca.crt ../../hyperium/tonic/examples/data/tls/ca.pem
cp home-ca/private/dj-ca.key ../../hyperium/tonic/examples/data/tls/server.key
cp home-ca/crts/dj-ca.crt ../../hyperium/tonic/examples/data/tls/server.pem
