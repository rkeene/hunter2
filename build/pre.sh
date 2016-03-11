#! /usr/bin/env bash

ourscp="$(which "$0")" || exit 1
ourdir="$(cd -- "$(dirname "${ourscp}")" && pwd)" || exit 1

if [ ! -f "${ourdir}/teapot-client.kit" ]; then
	echo "Internal error." >&2

	exit 1
fi

set -x
set -e

cd "${ourdir}/.."

rm -rf lib

if [ "$1" = 'clean' -o "$1" = 'distclean' ]; then
	exit 0
fi

"${TCLKIT:-tclkit}" "${ourdir}/teapot-client.kit" get . tcl tcl pki aes

for platform in linux-ix86 linux-x86_64 macosx-ix86 macosx-x86_64 win32-ix86 win32-x86_64; do
	dl_platform="${platform}"
	vers='0.9.9'
	case "${platform}" in
		macosx-*)
			vers='0.9.6'
			;;
		linux-ix86)
			dl_platform='linux-glibc2.1-ix86'
			;;
		linux-x86_64)
			dl_platform='linux-glibc2.2-x86_64'
			;;
	esac

	dir="lib/$platform/pkiPkcs11-${vers}"
	file="${dir}/file.zip"
	url="http://teapot.rkeene.org/package/name/pki::pkcs11/ver/${vers}/arch/${dl_platform}/file.zip"

	mkdir -p "${dir}"

	wget -O "${file}" "${url}" || \
		curl "${url}" > "${file}" || \
		rm -f "${file}"

	(
		cd "${dir}" || exit 1
		unzip file.zip || exit 1
	)

	sed -i 's@file join  @file join $dir @' lib/*/pkiPkcs11-*/pkgIndex.tcl

	rm -f "${file}"
done
