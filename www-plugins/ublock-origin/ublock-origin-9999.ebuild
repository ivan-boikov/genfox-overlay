# Copyright 2024 Ivan Boikov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="uBlock Origin addon for Firefox"
HOMEPAGE="https://github.com/gorhill/uBlock"
SRC_URI="https://github.com/gorhill/uBlock.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="dev-build/ninja net-libs/nodejs"

inherit git-r3

src_unpack() {
	EGIT_REPO_URI="$SRC_URI"
	EGIT_CLONE_TYPE="shallow"
	git-r3_src_unpack
	cd "${S}"
	tools/pull-assets.sh
	cd -
}

src_compile() {
	cd "${S}"
	tools/make-firefox.sh all
	cd -
}

src_install() {
	dodir /usr/share/firefox-addons
	cp "${S}/dist/build/uBlock0.firefox.xpi" "${D}/usr/share/firefox-addons/uBlock0@raymondhill.net.xpi"
}
