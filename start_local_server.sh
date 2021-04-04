#!/bin/bash

function onExit {
  pkill -P $$
}

# Serve HTML & CSS with a python webserver
function runServer {
  trap onExit EXIT 

  sudo python -m SimpleHTTPServer 80 2>&1 &
}

runServer

xdg-open "http://localhost"

for job in `jobs -p`; do
  wait $job
done