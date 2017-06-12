#!/bin/bash

# add repository
apt-add-repository ppa:brightbox/ruby-ng
apt-get update

# install correct Ruby version
apt-get install ruby2.3 ruby2.3-dev

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
