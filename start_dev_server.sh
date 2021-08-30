#!/bin/sh

export $(cat .env | xargs)

mix phx.server
