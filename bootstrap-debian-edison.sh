#!/bin/ash

set -e

DEBIAN_MIRROR_URL=http://ftp.debian.org/debian
CDEBOOTSTRAP_PACKAGE_VERSION=0.7.1_i386
SHA1SUM_SOURCE_URL=ftp://ftp.gnupg.org/gcrypt/binary/sha1sum.c
DEBIAN_CHROOT=/home/root/debian
DEBIAN_DIST=unstable
DEBIAN_ARCH=i386

if [ -e $DEBIAN_CHROOT ]; then
  echo $DEBIAN_CHROOT exists already
  exit 1
fi

if [ -d /tmp/debootstrap-bin/ ]; then
  rm -r /tmp/debootstrap-bin/
fi

mkdir /tmp/debootstrap-bin/
cd /tmp/debootstrap-bin

wget -q $DEBIAN_MIRROR_URL/pool/main/c/cdebootstrap/cdebootstrap-static_$CDEBOOTSTRAP_PACKAGE_VERSION.deb

ar -x cdebootstrap-static_$CDEBOOTSTRAP_PACKAGE_VERSION.deb


tar xf data.tar.xz

tar xf ./usr/lib/cdebootstrap/cdebootstrap_$CDEBOOTSTRAP_PACKAGE_VERSION.tar.gz

echo "Untarred cdebootstrap tarball"





wget -q $SHA1SUM_SOURCE_URL

echo "wget sha1sum source complete"

cc -O3 -o sha1sum sha1sum.c

echo "compile of sha1sum complete"

cp sha1sum ./usr/bin/

echo "Running cdeboottrap-static"
PATH=/tmp/debootstrap-bin/usr/bin:$PATH ./usr/bin/cdebootstrap-static --debug --allow-unauthenticated -c /tmp/debootstrap-bin/usr/share/cdebootstrap-static/ -H /tmp/debootstrap-bin/usr/share/cdebootstrap-static -f standard --arch=$DEBIAN_ARCH $DEBIAN_DIST $DEBIAN_CHROOT $DEBIAN_MIRROR_URL

echo "Removing /dev from chroot"
rm -r $DEBIAN_CHROOT/dev/*

echo "Done"
