# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpyc/rpyc-3.2.0.ebuild,v 1.1 2011/10/12 06:37:53 grozin Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Remote Python Call (RPyC), a transparent and symmetric RPC library"
HOMEPAGE="http://rpyc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=""
DEPEND="dev-python/setuptools"
