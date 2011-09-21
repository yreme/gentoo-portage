# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pms/pms-9999.ebuild,v 1.3 2011/09/21 08:01:22 mgorny Exp $

EAPI=2

inherit autotools git-2

DESCRIPTION="Practical Music Search: an open source ncurses client for mpd, written in C++"
HOMEPAGE="http://pms.sourceforge.net/"
SRC_URI=""

EGIT_REPO_URI="git://pms.git.sourceforge.net/gitroot/pms/pms"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="regex"

RDEPEND="
	sys-libs/ncurses
	dev-libs/glib:2
	regex? ( >=dev-libs/boost-1.36 )
"
DEPEND="
	dev-util/pkgconfig
	${RDEPEND}
"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable regex) ||
			die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"

	dodoc AUTHORS README TODO
}
