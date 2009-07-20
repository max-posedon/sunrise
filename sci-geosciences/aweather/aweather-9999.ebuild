# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2 subversion

DESCRIPTION="A weather monitoring program"
HOMEPAGE="http://lug.rose-hulman.edu/wiki/AWeather"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=">=net-libs/libsoup-2.26
	>=x11-libs/gtk+-2.16
	x11-libs/gtkglext
	sci-libs/rsl"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="ChangeLog README TODO"

MAKEOPTS="${MAKEOPTS} -j1"

ESVN_REPO_URI="https://lug.rose-hulman.edu/svn/proj-aweather/trunk"
ESVN_BOOTSTRAP="./autogen.sh"
