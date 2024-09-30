# Copyright 2024 Ivan Boikov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VER="2.9.1"

DESCRIPTION="LibRedirect addon for Firefox"
HOMEPAGE="https://github.com/libredirect/browser_extension"
XPI="libredirect-${VER}.xpi"
SRC_URI="https://addons.mozilla.org/firefox/downloads/file/4280925/${XPI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir "/usr/share/firefox-addons"
	cp "${DISTDIR}/${XPI}" "${D}/usr/share/firefox-addons/7esoorv3@alefvanoon.anonaddy.me.xpi"
}
