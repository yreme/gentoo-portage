# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxsession-edit/lxsession-edit-0.2.0.ebuild,v 1.7 2013/02/23 02:42:36 zmedico Exp $

EAPI="4"

DESCRIPTION="LXDE session autostart editor"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ppc x86 ~arm-linux ~x86-linux"
IUSE=""

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/gtk+:2"
RDEPEND="${COMMON_DEPEND}
	lxde-base/lxde-common
	lxde-base/lxsession"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README
}
