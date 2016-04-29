#!/bin/sh
[ -z ${desktop+x} ] && desktop=0
[ -z ${hyperv+x} ] && hyperv=0
[ -z ${qemu+x} ] && qemu=0
[ -z ${spice+x} ] && spice=0
[ -z ${vmware+x} ] && vmware=0
[ -z ${blockdevice+x} ] && disk='' || disk=$blockdevice
[ -z ${runpath+x} ] && runpath='/run/install'
file=${runpath}/vm-guests.ks

opts=$(getopt --options dhqv --long desktop,hyperv,qemu,vmware,test --name 'vm-guests.sh' -- "$@")
eval set -- "$opts"

while true; do
  case "$1" in
    -d|--desktop) desktop=1 ; shift ;;
    -q|--qemu) qemu=1 ; shift ;;
    -v|--vmware) vmware=1 ; shift ;;
    --test) runpath='.' ; file=${runpath}/vm-guests.ks ; disk='vda' ; shift ;;
    --) shift; break ;;
    *) echo "Invaild option: $1"; exit 1 ;;
  esac
done

echo "# Virtual machine guest agents" >> $file

echo "%packages" >> $file
if [ ! $disk = 'vda' ] ; then
  echo '# Hypervisor and container host (should be moved)'
  echo 'qemu-kvm' >> $file
  echo 'qemu-kvm-tools' >> $file
  echo 'libvirt-daemon-kvm' >> $file
  echo 'ksm' >> $file
  [ $desktop = 1 ] && echo 'virt-manager' >> $file
  echo 'docker-engine' >> $file
  echo 'docker-engine-selinux' >> $file
fi
echo "@guest-agents" >> $file
[ ! $vmware -eq 1 ] && echo -n '-' >> $file ; echo 'open-vm-tools' >> $file
[ ! $qemu -eq 1 ] && echo -n '-' >> $file ; echo 'qemu-guest-agent' >> $file
if [ $desktop = 1 ] ; then
  echo "@guest-desktop-agents" >> $file
  [ ! $hyperv -eq 1 ] && echo -n '-' >> $file ; echo 'hyperv-daemons' >> $file
  [ ! $vmware -eq 1 ] && echo -n '-' >> $file ; echo 'open-vm-tools-desktop' >> $file
  [ ! $vmware -eq 1 ] && echo -n '-' >> $file ; echo 'xorg-x11-drv-vmware' >> $file
  [ ! $vmware -eq 1 ] && echo -n '-' >> $file ; echo 'xorg-x11-drv-vmmouse' >> $file
  [ ! $qemu -eq 1 ] && echo -n '-' >> $file ; echo 'spice-vdagent' >> $file
  [ ! $qemu -eq 1 ] && echo -n '-' >> $file ; echo 'xorg-x11-drv-qxl' >> $file
fi
echo "%end" >> $file
