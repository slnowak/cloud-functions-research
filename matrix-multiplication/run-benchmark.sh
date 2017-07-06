#!/usr/bin/env bash

requests=5000

for users in 10, 20, 50, 100, 200, 500, 1000:
do
    ./benchmark-matrix-multiplication.sh ${requests} ${users}
done