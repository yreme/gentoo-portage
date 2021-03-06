# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-pcscd/selinux-pcscd-2.20141203-r2.ebuild,v 1.1 2014/12/21 13:55:56 swift Exp $
EAPI="5"

IUSE=""
MODS="pcscd"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for pcscd"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
