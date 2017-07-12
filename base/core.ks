# base/core.ks
# platform=x86, AMD64, or Intel EM64T
# digitalr00ts kickstart file

# Group Name: Core
# Description: Smallest possible installation

%packages

# Mandatory
#audit
basesystem
bash
coreutils
cronie
curl
dhcp-client
dnf
dnf-yum
e2fsprogs
filesystem
glibc
grubby
hostname
initscripts
iproute
iputils
kbd
less
man-db
ncurses
openssh-clients
openssh-server
parted
passwd
-plymouth
policycoreutils
procps-ng
rootfiles
rpm
selinux-policy-targeted
setup
shadow-utils
#sssd-common
sudo
systemd
util-linux
vim-minimal

# Default
authconfig
dnf-plugins-core
#dracut-config-rescue
firewalld
NetworkManager

# Optional
#dracut-config-generic
#initial-setup
#ppc64-diag
#ppc64-utils
#uboot-images-armv7
#uboot-images-armv8
#uboot-tools

%end

