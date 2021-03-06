# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mtr/mtr-0.86.ebuild,v 1.2 2014/12/27 12:00:51 jer Exp $

EAPI=5
inherit eutils fcaps flag-o-matic

DESCRIPTION="My TraceRoute, an Excellent network diagnostic tool"
HOMEPAGE="http://www.bitwizard.nl/mtr/"
SRC_URI="ftp://ftp.bitwizard.nl/mtr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="gtk ipv6"

RDEPEND="
	sys-libs/ncurses
	gtk? (
		dev-libs/glib:2
		x11-libs/gtk+:2
	)
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS FORMATS NEWS README SECURITY TODO )
FILECAPS=( cap_net_raw /usr/sbin/mtr )

src_configure() {
	# In the source's configure script -lresolv is commented out. Apparently it
	# is needed for 64bit macos still.
	[[ ${CHOST} == *-darwin* ]] && append-libs -lresolv

	econf \
		$(use_enable ipv6) \
		$(use_with gtk) \
		--disable-gtktest
}
