# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-2.2.2.ebuild,v 1.2 2014/10/26 14:51:23 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RDEPEND+=" >=dev-libs/glib-2"
DEPEND+=" >=dev-libs/glib-2"

ruby_add_bdepend "dev-ruby/pkg-config"

all_ruby_prepare() {
	# Our sandbox always provides LD_PRELOAD in the environment.
	sed -i -e 's/unless ENV.empty?/unless (ENV.keys - ["LD_PRELOAD"]).empty?/' test/test_spawn.rb || die
}

each_ruby_configure() {
	${RUBY} extconf.rb || die "extconf.rb failed"
}

each_ruby_test() {
	${RUBY} test/run-test.rb || die
}
