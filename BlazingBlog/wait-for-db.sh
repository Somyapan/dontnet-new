#!/bin/bash
set -e

HOST="$1"
PORT="$2"
shift 2

if [ -z "$HOST" ] || [ -z "$PORT" ]; then
  echo "Usage: $0 <host> <port> <command...>"
  exit 2
fi

echo "Waiting for $HOST:$PORT ..."
# simple TCP check using bash /dev/tcp
while ! timeout 1 bash -c "</dev/tcp/$HOST/$PORT" &>/dev/null; do
  echo "$(date) - waiting for $HOST:$PORT ..."
  sleep 1
done

echo "$HOST:$PORT is available, launching: $@"
exec "$@"
