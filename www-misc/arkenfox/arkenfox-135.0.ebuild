# Copyright 2024 Ivan Boikov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig

DESCRIPTION="Firefox privacy, security and anti-tracking: a comprehensive user.js template for configuration and hardening"
HOMEPAGE="https://github.com/arkenfox/user.js"
VER="135.0"
SRC_URI="https://github.com/arkenfox/user.js/archive/refs/tags/${VER}.tar.gz -> arkenfox-${VER}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+savedconfig"

RDEPEND="
"
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}"

sanitize() {
	# firefox is restrictive about the config content, so only leave the bare minimum
	# arkenfox's updating script does a similar thing
	cat "$1" | grep "user_pref" | grep -v "// user_pref" | sed "s/^user_pref/pref/g"
}

src_prepare() {
	default

	tar -xf "${DISTDIR}/arkenfox-${VER}.tar.gz"

	restore_config 'user-overrides.js'
	if [ ! -f "user-overrides.js" ]; then
		echo '// user_pref("parameter", "value")' > "user-overrides.js"
	fi
}

src_compile() {
	echo "// IMPORTANT: Start your code on the 2nd line" > "user.js-${VER}/arkenfox.cfg"
	sanitize "user.js-${VER}/user.js" >> "user.js-${VER}/arkenfox.cfg"
	sanitize "user-overrides.js" >> "user.js-${VER}/arkenfox.cfg"
}

src_install() {
	# https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig
	dodir "/etc/firefox/defaults/pref"
	cat >> "${D}/etc/firefox/defaults/pref/autoconfig.js" << EOF
pref("general.config.filename", "arkenfox.cfg");
pref("general.config.obscure_value", 0);
EOF

	# it appears we can only install configs inside the install directory
	if [ -d "/opt/firefox" ]; then # "firefox-bin" in installed
		dodir "/opt/firefox"
		cp "user.js-${VER}/arkenfox.cfg" "${D}/opt/firefox/"
	fi
	if [ -d "/usr/lib/firefox" ]; then # "firefox" in installed
		dodir "/usr/lib/firefox"
		cp "user.js-${VER}/arkenfox.cfg" "${D}/usr/lib/firefox/"
	fi

	save_config 'user-overrides.js'
}
