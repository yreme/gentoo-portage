# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/grimrock/grimrock-20121222.ebuild,v 1.2 2013/01/29 12:37:49 hasufell Exp $

EAPI=5

inherit eutils multilib gnome2-utils unpacker games

TIMESTAMP="${PV:0:4}-${PV:4:2}-${PV:6:2}"
MY_PN="Grimrock"
DESCRIPTION="Legend of Grimrock: The Ultimate dungeon crawling RPG + modding engine"
HOMEPAGE="http://www.grimrock.net/"
SRC_URI="LegendOfGrimrock-Linux-${TIMESTAMP}.sh"

SLOT="0"
LICENSE="all-rights-reserved"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+system-libs"
RESTRICT="fetch bindist"

QA_PREBUILT="${GAMES_PREFIX_OPT}/${PN}/${MY_PN}.bin.*
	${GAMES_PREFIX_OPT}/${PN}/lib.*"

RDEPEND="
	app-arch/bzip2
	media-libs/freetype:2
	media-libs/ilmbase
	media-libs/lcms
	media-libs/libpng:0
	media-libs/libraw
	media-libs/jasper
	media-libs/openexr
	media-libs/openjpeg
	media-libs/tiff
	sys-libs/zlib
	virtual/jpeg
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libXext
	system-libs? (
		media-libs/freeimage
		media-libs/libogg
		media-libs/libvorbis
		media-libs/openal
		sys-libs/zlib[minizip]
	)"
DEPEND="app-arch/xz-utils"

S=${WORKDIR}

pkg_pretend() {
	if has splitdebug ${FEATURES}; then
		eerror "FEATURES=splitdebug is broken for this package, disable it locally"
		die "FEATURES=splitdebug is broken for this package, disable it locally"
	fi
}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

src_unpack() {
	use amd64 && myarch=x86_64 || myarch=x86

	local archivelist=(
		subarch
		instarchive_all
		instarchive_linux_${myarch}
		deps/SDL2/SDL2_files_linux_${myarch}
		deps/FreeImage/FreeImage_files_linux_${myarch}
		deps/libogg/libogg_files_linux_${myarch}
		deps/minizip/minizip_files_linux_${myarch}
		deps/openal/openal_files_linux_${myarch}
		deps/vorbis/vorbis_files_linux_${myarch}
	)

	unpack_makeself

	local i
	for i in $(use system-libs && echo ${archivelist[@]:0:4} || echo ${archivelist[@]}) ; do
		mv "${i}" "${i}.tar.xz" || die
		unpack ./"${i}.tar.xz"
	done
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins ${PN}.{dat,png}

	exeinto "${dir}"
	doexe "${MY_PN}.bin.${myarch}"

	exeinto "${dir}"/lib
	doexe $(get_libdir)/libSDL2-2.0.so.0
	use system-libs || {
		doexe $(get_libdir)/lib{freeimage.so.3,minizip.so.1,ogg.so.0,openal.so.1,vorbisfile.so.3,vorbis.so.0}
	}

	games_make_wrapper "${PN}" "./${MY_PN}.bin.${myarch}" "${dir}" "${dir}"/lib
	doicon -s 256 ${PN}.png
	newicon -s 64 ${MY_PN}.png ${PN}.png
	make_desktop_entry "${PN}" "Legend of ${MY_PN}"

	dodoc README.linux
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst

	elog "If you are using opensource drivers you should consider installing:"
	elog "    media-libs/libtxc_dxtn"

	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}