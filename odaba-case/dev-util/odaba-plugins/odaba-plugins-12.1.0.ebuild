# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=4
inherit flag-o-matic

DESCRIPTION="ODABA ODE plugins."
HOMEPAGE="http://odaba.com"
SRC_URI="http://sourceforge.net/projects/odaba/files/12.1.0/odaba-plugins-12.1.0.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="multimedia webkit uml"

DEPEND="dev-libs/odaba
        multimedia? ( x11-libs/qt-phonon )
        uml? ( media-gfx/graphviz )
        webkit? ( x11-libs/qt-webkit )
       "

src_unpack() {
	unpack ${A}
	cd "${S}"
}
src_compile() {
	local myconf
	if use multimedia; then
		cd "${S}/_uc_MediaPlayer"
		econf || die "econf failed"
		emake || die "make failed"
	fi
	if use webkit; then
		cd "${S}/_uc_WebKitControl"
		econf || die "econf failed"
		emake || die "make failed"
	fi
	if use uml; then
		cd "${S}/_uc_Uml"
		econf || die "econf failed"
		emake || die "make failed"
	fi
}

src_install() {
	if use multimedia; then
		cd "${S}/_uc_MediaPlayer"
		make DESTDIR="${D}" install || die "make install failed"
	fi
	if use webkit; then
		cd "${S}/_uc_WebKitControl"
		make DESTDIR="${D}" install || die "make install failed"
	fi
	if use uml; then
		cd "${S}/_uc_Uml"
		make DESTDIR="${D}" install || die "make install failed"
	fi
}
