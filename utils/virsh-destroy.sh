#!/bin/bash

NAME=$1

virsh --connect qemu:///system destroy --domain=${NAME}
virsh --connect qemu:///system undefine --domain=${NAME}
virsh --connect qemu:///system vol-delete ${NAME}.qcow2 --pool default
