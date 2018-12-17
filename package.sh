#!/bin/bash

ARCH=$(uname -m)

if [ "x${ARCH}" = "xarmv7l" ] ; then
	uname_r="VERSION"
	distro="DISTRO"
	dpkg_arch="armhf"
else
	uname_r="4.1.18-ti-r50.5"
	distro="jessie"
	dpkg_arch="amd64"
fi

package="rtl8788cu"
base_dir="./"

if [ -f ${base_dir}src/8821cu.ko ] ; then

	cp -v ${base_dir}src/8821cu.ko ${base_dir}
	cp -v ${base_dir}src/README.md ${base_dir}

	echo "Section: misc" > ${base_dir}control
	echo "Priority: optional" >> ${base_dir}control
	echo "Homepage: https://github.com/rcn-ee/${package}" >> ${base_dir}control
	echo "Standards-Version: 3.9.6" >> ${base_dir}control
	echo "" >> ${base_dir}control
	echo "Package: ${package}-modules-${uname_r}" >> ${base_dir}control
	echo "Version: 1${distro}" >> ${base_dir}control
	echo "Pre-Depends: linux-image-${uname_r}" >> ${base_dir}control
	echo "Maintainer: Robert Nelson <robertcnelson@gmail.com>" >> ${base_dir}control
	echo "Architecture: ${dpkg_arch}" >> ${base_dir}control
	echo "Readme: README.md" >> ${base_dir}control
	echo "Files: 8821cu.ko /lib/modules/${uname_r}/kernel/drivers/net/wireless/" >> ${base_dir}control
	echo "Description: ${package} modules" >> ${base_dir}control
	echo " Kernel modules for ${package} devices" >> ${base_dir}control
	echo "" >> ${base_dir}control

	equivs-build control

	rm -rf 8821cu.ko || true
	rm -rf README.md || true
	rm -rf control || true
fi
