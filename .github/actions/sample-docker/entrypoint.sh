#!/usr/bin/env bash
echo "sample-docker for github actions"

OUTPUT_STRING=$1
echo "print input from github action = ::set-output name=output_string::${OUTPUT_STRING}"
