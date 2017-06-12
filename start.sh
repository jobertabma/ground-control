#!/bin/bash

ruby server.rb -p 8080 &
PORT_8080_PID=$!

ruby server.rb -p 8443 -cert ssl/8443.pem &
PORT_8443_PID=$!

read -p "Press any key to quit..." -n1 -s

kill $PORT_8080_PID
kill $PORT_8443_PID
