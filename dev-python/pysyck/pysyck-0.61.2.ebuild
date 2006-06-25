# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_P=${P/pysyck/PySyck}

DESCRIPTION="PySyck is aimed to update the current Python bindings for Syck. The new bindings provide a wrapper for the Syck emitter and give access to YAML representation graphs."
HOMEPAGE="http://pyyaml.org"
SRC_URI="http://pyyaml.org/download/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/syck-0.55"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_test() {
	cd "${S}/tests"
	python test_syck.py
	einfo "Some tests may have failed due to pending bugs in dev-libs/syck"
}
