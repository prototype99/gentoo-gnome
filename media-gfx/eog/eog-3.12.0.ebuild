# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome3

DESCRIPTION="The Eye of GNOME image viewer"
HOMEPAGE="http://projects.gnome.org/eog/"

LICENSE="GPL-2+"
SLOT="1"
IUSE="+exif +introspection +jpeg lcms +svg tiff xmp"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

REQUIRED_USE="exif? ( jpeg )"

RDEPEND="
	>=x11-libs/gtk+-3.7.8:3[introspection,X]
	>=dev-libs/glib-2.31:2
	>=dev-libs/libxml2-2:2
	>=dev-libs/libpeas-0.7.4:=[gtk]
	>=gnome-base/gnome-desktop-${PV}:3=
	>=gnome-base/gsettings-desktop-schemas-${PV}
	>=x11-themes/gnome-icon-theme-2.19.1
	>=x11-misc/shared-mime-info-0.20

	x11-libs/gdk-pixbuf:2[jpeg?,tiff?]
	x11-libs/libX11

	exif? ( >=media-libs/libexif-0.6.14 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	svg? ( >=gnome-base/librsvg-2.36.2:2 )
	xmp? ( media-libs/exempi:2 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.10
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
"

DOCS=( "AUTHORS" "ChangeLog" "HACKING" "MAINTAINERS" "NEWS" "README" "THANKS" "TODO" )

src_configure() {
	gnome3_src_configure \
		$(use_enable introspection) \
		$(use_with jpeg libjpeg) \
		$(use_with exif libexif) \
		$(use_with lcms cms) \
		$(use_with xmp) \
		$(use_with svg librsvg) \
		ITSTOOL=$(type -P true)
}
