# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opengfx/opengfx-0.3.6.ebuild,v 1.2 2011/10/10 05:45:07 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="OpenGFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opengfx/"
SRC_URI="http://bundles.openttdcoop.org/opengfx/releases/${PV}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

S=${WORKDIR}/${P}-source

DEPEND=">=games-util/grfcodec-5.1.1"
RDEPEND=""

src_prepare() {
	sed -i -e 's/\[a-z\]/[[:alpha:]]/' ./scripts/Makefile.in || die
}

src_compile() {
	emake bundle || die
}

src_install() {
	insinto "${GAMES_DATADIR}/openttd/data/"
	doins *.grf opengfx.obg || die
	dodoc docs/{changelog.txt,readme.txt}
	prepgamesdirs
}
