#!/usr/bin/env bash

set -e
export PACKER=../../../../bin/packer
export PACKER_LOG=1
export PACKER_LOG_PATH='packer/logs/packer-qemu.log'
export IMAGE_NAME='CentOS-7-x86_64-Minimal'
export BOXES='~/.vagrant.d/boxes'
export VIRT_IMAGES='~/Desktop/opt/project/libvirt/images'
export URL='http://ftp.iij.ad.jp/pub/linux/centos/7/isos'
export ARCH='x86_64'
export CHECK_SUM='sha256sum'
vagrant destroy

# Packer log Generate if there is no output directory.
[[ -d "packer/logs" ]] || install -d 'packer/logs'

# Delete image of vagrant box.
[[ -e "${BOXES}/${IMAGE_NAME}" ]] && {
    vagrant box remove CentOS-7-x86_64-Minimal
    rm -rf "${BOXES}/${IMAGE_NAME}"
    echo "boxes deleted"
}

# Delete vagrant and libvirt images.
[[ -e "${VIRT_IMAGES}/${IMAGE_NAME}*" ]] && {
    rm -rf "${VIRT_IMAGES}/${IMAGE_NAME}*"
    echo "images deleted"
}

# Generate the URL of the latest OS image.
export IMAGE_ISO=${URL}/${ARCH}/$(
    curl -s ${URL}/${ARCH}/ |\
    awk -v RS='[<>]' -F\" \
    '/^a href=/ && $2 ~ /iso$/ { print $2 }'|\
    grep ${IMAGE_NAME}
)

# Get Check Sum for latest OS image.
export IMAGE_SUM=$(\
    curl -s ${URL}/${ARCH}/$(\
        curl -s ${URL}/${ARCH}/ |\
        awk -v RS='[<>]' -F\" '/^a href=/ && $2 ~ /txt$/ { print $2 }'|\
        grep ${CHECK_SUM}\
    ) | grep ${IMAGE_NAME}|awk '{print $1}'
)

eval "${PACKER} build \\
      -only=qemu \\
      -var image_iso=${IMAGE_ISO} \\
      -var image_sum=${IMAGE_SUM} \\
      packer.json"
