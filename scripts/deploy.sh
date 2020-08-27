#!/bin/bash

aws s3 cp s3://bkt-terraform/.env /var/www/app
cd /var/www/app/ && git pull && bundle install
