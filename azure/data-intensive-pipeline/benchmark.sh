#!/usr/bin/env bash

FUNCTION_URL="https://cloud-functions-research-snowak-data-intensive.azurewebsites.net/api/step1"
for i in {1..100}
do
    http ${FUNCTION_URL}
done
