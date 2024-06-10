#!/bin/bash

ENV=$1

if [ "$ENV" == "staging" ]; then
  echo "Deploying to staging environment..."
  docker-compose -f docker-compose.yml up -d
elif [ "$ENV" == "production" ]; then
  echo "Deploying to production environment..."
  docker-compose -f docker-compose.yml up -d --build
else
  echo "Unknown environment: $ENV"
  exit 1
fi
