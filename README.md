Debian Unstable Chroot on Intel Edison
======================================

Based initially on the same-named pair of scripts from
https://communities.intel.com/message/254727#254727

Scripts were attached to that post by user hkratz


Adapted to install debian unstable into a chroot in
similar fashion

Intel Edison(R) is a registered trademark of Intel Corporation.


Installation
============

1. Update Edison Firmware Image from the latest image publication point,
probably https://software.intel.com/en-us/iot/hardware/edison/downloads
following prescribed installation/update process.
2. Configure Edison networking to enable access to debian package repo
3. Copy the scripts herein to /tmp on Edison target, cd /tmp
4. Examine values within bootstrap-debian-edison.sh for repository, chroot location, etc.
5. Remount /home with dev option... mount /home/ -o dev,remount  
6. On Edison, execute bootstrap-debian-edison.sh to download and install debian chroot
7. When installation is complete, remount /home with nodev mount /home/ -o nodev,remount  
8. Execute setup-chroot-mounts.sh to setup mounts inside chroot
9. Switch to chroot with chroot /home/root/debian /bin/bash (default location, bash shell)

Just the shell (steps 5-9):

```bash
mount /home/ -o dev,remount
./bootstrap-debian-edison.sh
mount /home/ -o nodev,remount
./setup-chroot-mounts.sh
chroot /home/root/debian
```

Installing and Updating Debian Packages
=======================================

Once inside the chroot it is possible to update and install new packages using apt-get.

For example:

```bash
apt-get update
apt-get install python-pip
```

