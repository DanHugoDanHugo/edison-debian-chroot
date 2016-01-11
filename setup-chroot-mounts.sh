#!/bin/ash

set -e

DEBIAN_CHROOT=/home/root/debian

if ! mount | grep -q $DEBIAN_CHROOT/dev; then
  mount --bind /dev $DEBIAN_CHROOT/dev
fi

if ! mount | grep -q $DEBIAN_CHROOT/proc; then
  mount -t proc proc $DEBIAN_CHROOT/proc
fi


if ! mount | grep -q $DEBIAN_CHROOT/sys; then
  mount -t sysfs sys $DEBIAN_CHROOT/sys
fi
