# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

S="${WORKDIR}/${P}/src/=build"
DESCRIPTION="Revision control system ideal for widely distributed development"
HOMEPAGE="http://savannah.gnu.org/projects/gnu-arch http://wiki.gnuarch.org/ http://arch.quackerhead.com/~lord/"
SRC_URI="mirror://gnu/gnu-arch/${P}.tar.gz
	http://gentooexperimental.org/~patrick/tla.1-2.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~sh ~sparc ~x86"
IUSE="doc"

DEPEND="sys-apps/debianutils"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	mkdir "${S}"
	sed -i 's:/home/lord/{install}:/usr:g' "${WORKDIR}/${P}/src/tla/=gpg-check.awk" || die
}

src_compile() {
	../configure --prefix=/usr --with-posix-shell=/bin/bash || die "configure failed"
	# parallel make may cause problems with this package
	emake -j1 || die "emake failed"
}

src_install () {
	make install prefix="${D}/usr" || die "make install failed"

	cd ..
	dodoc ChangeLog || die

	if use doc; then
		cd docs-tla
		docinto html
		dohtml -r . || die

		cd ../docs-hackerlab
		docinto hackerlab/html
		dohtml html/* || die
		docinto hackerlab/ps
		dodoc ps/* || die
	fi

	cd "${WORKDIR}"
	mv tla.1-2 tla.1 || die
	doman tla.1 || die

	newbin "${WORKDIR}/${P}/src/tla/=gpg-check.awk" tla-gpg-check.awk || die
}
