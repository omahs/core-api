#!/bin/bash
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bin/rails db:environment:set RAILS_ENV=development
bundle exec rails db:setup
bundle exec rails s -b 0.0.0.0 -p 8080

exec "$@"