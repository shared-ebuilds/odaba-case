# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=4
inherit flag-o-matic

DESCRIPTION="commandline tools for the ODABA ComputerAidedSoftwareEngenerieng environment"
HOMEPAGE="http://struction.de/odaba-case"
SRC_URI="http://struction.de/odaba-case/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="cgdb gdb valgrind"

DEPEND="dev-db/odaba[gui]
        cgdb? ( dev-util/cgdb )
        gdb? ( dev-util/gdb )
        valgrind? ( dev-util/valgrind )
        dev-lang/bash_include
       "
#bash library

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
