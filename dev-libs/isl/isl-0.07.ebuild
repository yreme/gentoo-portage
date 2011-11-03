# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/isl/isl-0.07.ebuild,v 1.1 2011/08/21 06:41:25 dirtyepic Exp $

EAPI="3"

inherit autotools-utils

DESCRIPTION="A library for manipulating integer points bounded by affine constraints."
HOMEPAGE="http://www.kotnet.org/~skimo/isl/"
SRC_URI="http://www.kotnet.org/~skimo/isl/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="dev-libs/gmp"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog AUTHORS doc/manual.pdf )
PATCHES=( "${FILESDIR}"/${PN}-0.07-gdb-autoload-dir.patch )
AUTOTOOLS_IN_SOURCE_BUILD="1"
