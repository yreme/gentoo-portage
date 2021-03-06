# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ruby-threads/ruby-threads-7.ebuild,v 1.1 2015/01/19 19:35:41 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for a ruby interpreter with threading enabled"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x64-macos"
IUSE=""

RDEPEND="
	ruby_targets_ruby19? ( dev-lang/ruby:1.9 )
	ruby_targets_ruby20? ( dev-lang/ruby:2.0 )
	ruby_targets_ruby21? ( dev-lang/ruby:2.1 )"

pkg_setup() { :; }
src_unpack() { :; }
src_prepare() { :; }
src_compile() { :; }
src_install() { :; }
pkg_preinst() { :; }
pkg_postinst() { :; }
