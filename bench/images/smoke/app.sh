#!/bin/sh
# Responde "ok <arch>" donde <arch> es la arquitectura de la imagen corriendo.
ARCH=$(uname -m)
echo "ok ${ARCH}"
