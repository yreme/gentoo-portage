# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/greenbone-security-assistant/greenbone-security-assistant-6.0_beta4.ebuild,v 1.2 2014/12/18 08:52:19 jlec Exp $

EAPI=5

inherit cmake-utils systemd

MY_PN=gsad

DL_ID=1819

DESCRIPTION="Greenbone Security Assistant for openvas"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/${DL_ID}/${P/_beta/+beta}.tar.gz"

SLOT="0"
LICENSE="GPL-2+ BSD MIT"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=net-analyzer/openvas-libraries-8.0_beta4
	dev-libs/libxslt
	net-libs/libmicrohttpd[messages]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PN}-5.0.3-run.patch
	)

S="${WORKDIR}"/${P/_beta/+beta}

src_prepare() {
	sed \
		-e '/^install.*OPENVAS_CACHE_DIR.*/d' \
		-i CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLOCALSTATEDIR="${EPREFIX}/var"
		-DSYSCONFDIR="${EPREFIX}/etc"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newinitd "${FILESDIR}"/${MY_PN}.init ${MY_PN}

	insinto /etc/openvas
	doins "${FILESDIR}"/${MY_PN}-daemon.conf
	dosym ../openvas/${MY_PN}-daemon.conf /etc/conf.d/${PN}

	insinto /etc/logrotate.d
	doins "${FILESDIR}"/${MY_PN}.logrotate

	systemd_newtmpfilesd "${FILESDIR}"/${MY_PN}.tmpfiles.d ${MY_PN}.conf
	systemd_dounit "${FILESDIR}"/${MY_PN}.service
}
