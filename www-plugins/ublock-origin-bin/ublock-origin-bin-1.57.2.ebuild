# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VER="1.57.2"

DESCRIPTION="uBlock Origin addon for Firefox"
HOMEPAGE="https://github.com/gorhill/uBlock"
XPI="ublock_origin-${VER}.xpi"
SRC_URI="https://addons.mozilla.org/firefox/downloads/file/4261710/${XPI}"
# alternative
#XPI="uBlock0_${VER}.firefox.signed.xpi"
#SRC_URI="https://github.com/gorhill/uBlock/releases/download/${VER}/${XPI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir "/usr/share/firefox-addons"
	cp "${DISTDIR}/${XPI}" "${D}/usr/share/firefox-addons/uBlock0@raymondhill.net.xpi"
}
