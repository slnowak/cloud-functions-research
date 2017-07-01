#!/usr/bin/env bash

FUNCTION_URL="https://cloud-functions-research-snowak.azurewebsites.net/api/writeToFile"

ab -n $1 -c $2 ${FUNCTION_URL}
