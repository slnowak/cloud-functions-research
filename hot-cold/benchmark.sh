#!/usr/bin/env bash

FUNCTION_URL_BASE="https://cloud-functions-research-snowak.azurewebsites.net/api/hotCold"
JS_FUNCTION=${FUNCTION_URL_BASE}"Js"
PYTHON_FUNCTION=${FUNCTION_URL_BASE}"Python"
C_SHARP_FUNCTION=${FUNCTION_URL_BASE}"CSharp"

execution_count=0
for((; ;))
do 
	execution_count=$((execution_count + 1))

	curl -s -o /dev/null ${JS_FUNCTION}
	curl -s -o /dev/null ${PYTHON_FUNCTION}
	curl -s -o /dev/null ${C_SHARP_FUNCTION}

	echo "HTTP requests sent for the $execution_count time"
	sleep $1
done