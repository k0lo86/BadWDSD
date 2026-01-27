#!/bin/bash
# Buduje wyłącznie wersję dla Raspberry Pi Pico Zero (BadWDSD_SW_x32_Zero.uf2)

set -e
cd "$(dirname "$0")"

mkdir -p BadWDSD/build
echo -e '#define PICO_IS_ZERO 1\n#define SC_IS_SW 1\n#define XDR_IS_X32 1' > BadWDSD/build/Config.h
./build.sh
mkdir -p out
cp -a BadWDSD/build/BadWDSD.uf2 out/BadWDSD_SW_x32_Zero.uf2
echo "Gotowe: out/BadWDSD_SW_x32_Zero.uf2"
