#!/usr/bin/env bash

FUNCTION_URL="https://hlfwg75ya1.execute-api.eu-west-1.amazonaws.com/dev/files"
for i in {1..100}
do
    http ${FUNCTION_URL}
done
