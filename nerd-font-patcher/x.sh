#!/usr/bin/env bash

for file in ~/Downloads/241229J2ZQ4L8Z4J/TX-02-0W0YVPW2/*.ttf; do
    if [ -f "$file" ]; then
        fontforge -script font-patcher "$file" -c
    fi
done
