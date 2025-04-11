#!/usr/bin/env bash
# Wait for database to be ready
until pg_isready -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "Waiting for database to be ready..."
  sleep 2
done

bundle install
bundle exec rake db:migrate
