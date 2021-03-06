# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-specimen/gnome-specimen-0.4-r1.ebuild,v 1.1 2014/12/02 22:07:33 pacho Exp $

EAPI=5
GCONF_DEBUG=no
PYTHON_COMPAT=( python2_7)

inherit autotools gnome2 python-single-r1

DESCRIPTION="Font preview application"
HOMEPAGE="http://uwstopia.nl"
SRC_URI="http://uwstopia.nl/geek/projects/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/gconf-python[${PYTHON_USEDEP}]
	dev-python/libgnome-python[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/pygobject:2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
"

src_prepare() {
	eautoreconf # To fix bug 408099
	gnome2_src_prepare
}
