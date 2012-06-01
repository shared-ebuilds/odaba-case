# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=4
inherit flag-o-matic

DESCRIPTION="ODABA ComputerAidedSoftwareEngenerieng environment. Libraries and Tools."
HOMEPAGE="http://odaba.com"
SRC_URI="http://sourceforge.net/projects/odaba/files/12.1.0/odaba-12.1.0.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="gui readline email compression documents ode documentation"

DEPEND="readline? ( sys-libs/readline )
        email? ( net-misc/curl )
        compression? ( sys-libs/zlib )
        documents? ( dev-libs/libzip )
        ode? ( media-gfx/graphviz )
        gui? ( x11-libs/qt-gui )
       "

src_unpack() {
	unpack ${A}
	cd "${S}"
}
src_compile() {
	local myconf
	econf \
		$(use_enable zlib) \
		$(use_enable gui) \
		${myconf} \
		\
		|| die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	if [ use documentation ]; then
		ewarn unpack documentation on demand: its located in /usr/doc/odaba/HTMLDoc.tar.bz2
	fi
	#TODO:???
	pushd ${D}
	chmod 777 var/lib/log/odaba
	chmod 777 var/log/odaba
	ln -s /usr/lib/odaba/tools/code usr/bin/code
	ln -s /usr/share/odaba/otool.sh usr/bin/otool.sh
	popd
}
