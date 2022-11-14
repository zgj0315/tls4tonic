#!/bin/bash
# cp rsa/intermediate/inter.crt ../../hyperium/tonic/examples/data/tls
# cp rsa/server/server.key ../../hyperium/tonic/examples/data/tls
# cp rsa/server/server.crt ../../hyperium/tonic/examples/data/tls

cp home-ca/sub-ca.crt ../../hyperium/tonic/examples/data/tls/ca.pem
cp home-ca/private/dj-ca.key ../../hyperium/tonic/examples/data/tls/server.key
cp home-ca/dj-ca.crt ../../hyperium/tonic/examples/data/tls/server.pem
