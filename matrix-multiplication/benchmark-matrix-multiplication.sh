#!/usr/bin/env bash

FUNCTION_URL="https://cloud-functions-research-snowak.azurewebsites.net/api/matrixMultiplication"

ab -n $1 -c $2 -p matrix.size ${FUNCTION_URL}
