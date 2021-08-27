#!/bin/sh

export POSTGRES_USER="postgres"
export POSTGRES_PASS="postgres"
export POSTGRES_DB="fslc_dev"
export POSTGRES_HOSTNAME="localhost"
export HTTP_PORT="4000"

mix phx.server
