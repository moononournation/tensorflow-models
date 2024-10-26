#!/bin/sh

# rm -rf models
# git clone --depth 1 https://github.com/tensorflow/models

docker build -t moononournation/tensorflow-models:2.17.0 .
