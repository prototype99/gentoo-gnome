# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libquvi/libquvi-0.9.2.ebuild,v 1.1 2013/08/08 07:05:13 radhermit Exp $

EAPI=5
AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

DESCRIPTION="Library for parsing video download links"
HOMEPAGE="http://quvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/quvi/${PV:0:3}/${P}.tar.xz"

LICENSE="AGPL-3"
SLOT="0/8" # subslot = libquvi soname version
KEYWORDS="~amd64"
IUSE="examples nls static-libs"

RDEPEND="!<media-libs/quvi-0.4.0
	>=dev-libs/glib-2.24.2:2
	>=dev-libs/libgcrypt-1.4.5:=
	>=media-libs/libquvi-scripts-0.9
	>=net-libs/libproxy-0.3.1
	>=net-misc/curl-7.21.0
	>=dev-lang/lua-5.1[deprecated]
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}"/${PN}-0.9.1-headers-reinstall.patch )

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		--with-manual
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use examples ; then
		docinto examples
		dodoc examples/*.c
	fi
}
