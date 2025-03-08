#!/usr/bin/env bash

for file in ./*.ttf; do
    if [ -f "$file" ]; then
        fontforge -script font-patcher "$file" -c
    fi
done
