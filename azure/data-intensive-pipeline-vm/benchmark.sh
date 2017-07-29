#!/usr/bin/env bash

FUNCTION_URL="https://cloud-functions-research-snowak-data-intensive.azurewebsites.net/api/step1"

ab -n $1 -c $2 -s 1000 ${FUNCTION_URL}
