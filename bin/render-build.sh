#!/usr/bin/env bash
# exit on error
set -o errexit

yarn install
bundle install
./bin/rails assets:precompile
./bin/rails assets:clean
