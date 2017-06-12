#!/bin/bash

# install correct Ruby version
rvm install 2.3

# generate 8443 SSL certificate with CSR

# create access log
if [ ! -f logs/access_log ]
then
  touch logs/access_log
fi

# seed empty configuration
if [ ! -f config.json ]
then
  echo '{"callback_tokens":{}}' > config.json
fi
