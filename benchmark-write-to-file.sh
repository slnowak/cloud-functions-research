#!/usr/bin/env bash

FUNCTION_URL="https://cloud-functions-research-snowak.azurewebsites.net/api/writeToFile"

ab -n 1000 -c 5 ${FUNCTION_URL}
