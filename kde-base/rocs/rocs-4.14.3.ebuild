# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/rocs/rocs-4.14.3.ebuild,v 1.3 2014/12/26 10:34:31 kensington Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE4 interface to work with Graph Theory"
HOMEPAGE="http://www.kde.org/applications/education/rocs
http://edu.kde.org/applications/mathematics/rocs"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	dev-libs/grantlee:0
	dev-qt/qtxmlpatterns:4
"
DEPEND="
	${RDEPEND}
	>=dev-libs/boost-1.49
"

RESTRICT=test
# bug 443752

src_test() {
	local mycmakeargs=(-DKDE4_BUILD_TESTS=ON)
	cmake-utils_src_configure
	kde4-base_src_compile

	cd "${BUILD_DIR}"
	emake DESTDIR="${T}/tests" install
	export KDEDIRS="${KDEDIRS}:${T}/tests/${PREFIX}"
	kbuildsycoca4
	ctest || die "tests failed"
}
