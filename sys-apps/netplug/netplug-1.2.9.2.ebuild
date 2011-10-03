# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netplug/netplug-1.2.9.2.ebuild,v 1.1 2011/10/03 07:09:24 polynomial-c Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Brings up/down ethernet ports automatically with cable detection"
HOMEPAGE="http://www.red-bean.com/~bos/"
SRC_URI="http://www.red-bean.com/~bos/netplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86"
IUSE="debug doc"

DEPEND="doc? ( app-text/ghostscript-gpl
		media-gfx/graphviz )"
RDEPEND=""

src_prepare() {
	# Remove debug flags from CFLAGS
	if ! use debug; then
		sed -i -e "s/ -ggdb3//" Makefile || die "sed failed"
	fi

	# Remove -O3 and -Werror from CFLAGS
	sed -i -e "s/ -O3//" -e "s/ -Werror//" Makefile || die "sed failed"

	# Remove nested functions, #116140
	epatch "${FILESDIR}/${PN}-1.2.9-remove-nest.patch"

	# Ignore wireless events
	epatch "${FILESDIR}/${PN}-1.2.9-ignore-wireless.patch"
}

src_compile() {
	tc-export CC
	emake CC="${CC}" || die "emake failed"

	if use doc; then
		emake -C docs/ || die "emake failed"
	fi
}

src_install() {
	into /
	dosbin netplugd
	doman man/man8/netplugd.8

	dodir /etc/netplug.d
	exeinto /etc/netplug.d
	doexe "${FILESDIR}/netplug.2"

	dodir /etc/netplug
	echo "eth*" > "${D}"/etc/netplug/netplugd.conf

	dodoc ChangeLog NEWS README TODO || die "dodoc failed"

	if use doc; then
		dodoc docs/state-machine.ps || die "dodoc failed"
	fi
}
