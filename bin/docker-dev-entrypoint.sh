#!/bin/bash
set -e

bundle exec rails db:setup

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec "$@"