# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/freerdp/freerdp-9999.1.ebuild,v 1.3 2011/10/01 16:46:46 pva Exp $

EAPI="4"

inherit cmake-utils git-2

DESCRIPTION="Client-side implementation of the Remote Desktop Protocol"
HOMEPAGE="http://www.freerdp.com/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/FreeRDP/FreeRDP.git
	https://github.com/FreeRDP/FreeRDP.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+alsa +cups directfb pulseaudio sse2 test +X +xcursor +xext +xinerama +xkbfile"

FREERDP_DEBUG="transport chanman svc dvc kbd nla nego certificate license gdi rfx x11 rail xv"
IUSE+=" $(printf 'debug-%s ' ${FREERDP_DEBUG})"

RDEPEND="
	dev-libs/openssl
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	directfb? ( dev-libs/DirectFB )
	pulseaudio? ( media-sound/pulseaudio )
	X? (
		x11-libs/libX11
		xcursor? ( x11-libs/libXcursor )
		xext? ( x11-libs/libXext )
		xinerama? ( x11-libs/libXinerama )
	)
	xkbfile? ( x11-libs/libxkbfile )
"
DEPEND="${RDEPEND}
	app-text/xmlto
	test? ( dev-util/cunit )
"

DOCS=( README )

# Test suite segfaults
RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		-DWITH_MANPAGES=ON
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with cups)
		$(cmake-utils_use_with directfb)
		$(cmake-utils_use_with pulseaudio)
		$(cmake-utils_use_with test CUNIT)
		$(cmake-utils_use_with X X11)
		$(cmake-utils_use_with xcursor)
		$(cmake-utils_use_with xext)
		$(cmake-utils_use_with xinerama)
		$(cmake-utils_use_with xkbfile)
		$(cmake-utils_use_with sse2 SSE2)
	)
	for i in ${FREERDP_DEBUG}; do
		mycmakeargs+=(
			$(cmake-utils_use_with debug-${i} DEBUG_$(LC_ALL=C echo ${i} | tr a-z A-Z))
		)
	done
	einfo "${mycmakeargs[@]}"
	cmake-utils_src_configure
}
