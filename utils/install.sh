#!/bin/bash

BASE_IMG='/home/virtImages/BASE/ubuntu-18.04-minimal-cloudimg-amd64.qcow2'
NAME=$1
SIZE=15G
MEMORY=2048
CLOUD_INIT_IMG='/home/fabio/git_repos/elastic-builder/cloud-init/user-data.img'
DISK="/home/virtImages/${NAME}.qcow2"

[[ -f "${DISK}" ]] || qemu-img create -f qcow2 -b ${BASE_IMG} ${DISK} ${SIZE}

virt-install --connect qemu:///system --name=${NAME} --memory=${MEMORY} --vcpu=2 --os-type=linux --os-variant=ubuntu18.04 --virt-type kvm --disk ${DISK},bus=virtio --disk ${CLOUD_INIT_IMG},format=raw --import --network network=default,model=virtio --graphics none --noautoconsole

sleep 15

virsh --connect qemu:///system domifaddr ${NAME}
