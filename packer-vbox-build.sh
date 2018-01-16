#!/usr/bin/env bash

set -e
export PACKER=~/bin/packer
export PACKER_LOG=1
export PACKER_LOG_PATH="packer/logs/packer-vbox.log"
export IMAGE_NAME='CentOS-7-x86_64-Minimal'
export BOXES='~/.vagrant.d/boxes'
export URL='http://ftp.iij.ad.jp/pub/linux/centos/7/isos'
export ARCH='x86_64'
export CHECK_SUM='sha256sum'

# Packer log Generate if there is no output directory.
[[ -d "packer/logs" ]] || install -d "packer/logs"

# Delete image of vagrant box.
[[ -e "${BOXES}/${IMAGE_NAME}" ]] && {
    rm -rf "${BOXES}/${IMAGE_NAME}"
    echo "boxes deleted"
}

# Generate the URL of the latest OS image.
export IMAGE_ISO=${URL}/${ARCH}/$(
    curl -s ${URL}/${ARCH}/ |\
    sed -n 's/^.*<a.href="[^"]*">\([^<]*\).*/\1/p'|\
    grep ${IMAGE_NAME}|\
    grep .iso
)

# Get Check Sum for latest OS image.
export IMAGE_SUM=$(
    curl -s ${URL}/${ARCH}/$(\
        curl -s ${URL}/${ARCH}/ |\
        sed -n 's/^.*<a.href="[^"]*">\([^<]*\).*/\1/p'|\
        grep ${CHECK_SUM}|\
        grep .txt
    ) | grep ${IMAGE_NAME}|awk '{print $1}'
)

eval "${PACKER} build \\
      -only=virtualbox-iso \\
      -var image_iso="${IMAGE_ISO}" \\
      -var image_sum="${IMAGE_SUM}" \\
      packer.json"
