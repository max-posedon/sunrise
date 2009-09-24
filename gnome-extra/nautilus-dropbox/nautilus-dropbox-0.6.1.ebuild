# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils linux-info gnome2

DESCRIPTION="Store, Sync and Share Files Online"
HOMEPAGE="http://www.getdropbox.com/"
SRC_URI="http://www.getdropbox.com/download?dl=packages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="gnome-base/nautilus
	dev-python/pygtk
	dev-python/docutils
	net-misc/wget
	x11-libs/libnotify
	x11-libs/libXinerama"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

CONFIG_CHECK="INOTIFY_USER"

pkg_setup () {
	linux-info_pkg_setup

	# create the group for the daemon, if necessary
	# truthfully this should be run for any dropbox plugin
	enewgroup dropbox
}

pkg_postinst () {
	gnome2_pkg_postinst

	# Allow only for users in the dropbox group
	# see http://forums.getdropbox.com/topic.php?id=3329&replies=5#post-22898
	local extensiondir="$(pkg-config --variable=extensiondir libnautilus-extension)"
	[ -z ${extensiondir} ] && die "pkg-config unable to get nautilus extensions dir"
	chown root:dropbox "${ROOT}${extensiondir}"/libnautilus-dropbox.{a,la,so} || die "fowners failed"
	chmod o-rwx "${ROOT}${extensiondir}"/libnautilus-dropbox.{a,la,so} || die "fperms failed"

	elog "Add any users who wish to have access to the dropbox nautilus"
	elog "plugin to the group 'dropbox'."
	elog
	elog "If you've installed old version, Remove \${HOME}/.dropbox-dist first."
	elog
	elog " $ rm -rf \${HOME}/.dropbox-dist"
	elog " $ dropbox start -i"
}
