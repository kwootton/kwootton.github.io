#!/bin/bash
PORT=8000

function onExit {
  rm .reload
  pkill -P $$
}

# Serve HTML & CSS with a python webserver
function runServer {
  trap onExit EXIT 

  python -m SimpleHTTPServer $PORT 2>&1 | xargs -L 1 echo "Server: " &

  socat tcp-listen:8001,fork exec:"inotifywait -e modify -e create -e delete ./"
}

runServer

xdg-open http://localhost:$PORT

for job in `jobs -p`; do
  wait $job
done