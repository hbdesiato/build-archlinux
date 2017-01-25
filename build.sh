#! /bin/bash
pacman -Syu sed grep tar --noconfirm

ROOT=/tmp/root
mkdir -p $ROOT/var/lib/pacman
pacman -r $ROOT -Syy bash pacman --noconfirm
rm -r $ROOT/usr/share/man/*
ls -d $ROOT/usr/share/locale/* | egrep -v "en_U|alias" | xargs rm -rf
ln -s /usr/share/zoneinfo/UTC $ROOT/etc/localtime
sed -i '/^#Server =/s/^#//' $ROOT/etc/pacman.d/mirrorlist
cp -a /etc/pacman.d/gnupg $ROOT/etc/pacman.d/

mknod -m 666 $ROOT/dev/null c 1 3
mknod -m 666 $ROOT/dev/zero c 1 5
mknod -m 666 $ROOT/dev/random c 1 8
mknod -m 666 $ROOT/dev/urandom c 1 9
mkdir -m 755 $ROOT/dev/pts
mkdir -m 1777 $ROOT/dev/shm
mknod -m 666 $ROOT/dev/tty c 5 0
mknod -m 600 $ROOT/dev/console c 5 1
mknod -m 666 $ROOT/dev/tty0 c 4 0
mknod -m 666 $ROOT/dev/full c 1 7
mknod -m 600 $ROOT/dev/initctl p
mknod -m 666 $ROOT/dev/ptmx c 5 2
ln -sf /proc/self/fd $ROOT/dev/fd

cd /output
rm archlinux.tar.xz
XZ_OPTS=-2 tar --checkpoint=2500 --numeric-owner -C $ROOT -cJf archlinux.tar.xz .
