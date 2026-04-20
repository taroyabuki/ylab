#!/usr/bin/bash

docker run --rm -it -v "${PWD}:/workdir" taroyabuki/tex latexmk -c
