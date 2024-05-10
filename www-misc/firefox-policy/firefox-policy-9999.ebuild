# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Generating Firefox system-wide policies to handle addons and updates"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+noupdate +ublock redirect nocookiespopup"

RDEPEND="
	ublock? ( www-plugins/ublock-origin-bin )
	redirect? ( www-plugins/libredirect-bin )
	nocookiespopup? ( www-plugins/istilldontcareaboutcookies-bin )
"
DEPEND="${RDEPEND}"
BDEPEND="app-misc/jq"

S="${WORKDIR}"

_add_addon_entry() {
	echo "$1" | jq ".policies.ExtensionSettings +=
		{ \"$2\" :
			{
				\"install_url\" : \"file:///usr/share/firefox-addons/$2.xpi\",
				\"installation_mode\" : \"normal_installed\",
				\"updates_disabled\" : true
			}
		}"
}

src_install() {
	# firefox-bin installs policies to /opt/firefox/distribution/policies.json
	# policy in /etc overrides it
	dodir /etc/firefox/policies
	policy=""
	if use noupdate ; then
		# browser updates
		policy="$(jq -n '.policies += { "DisableAppUpdates" : true }')"
	fi
	if use ublock ; then
		# uBlockOrigin
		policy="$(_add_addon_entry "$policy" "uBlock0@raymondhill.net")"
	fi
	if use redirect ; then
		# LibRedirect
		policy="$(_add_addon_entry "$policy" "7esoorv3@alefvanoon.anonaddy.me")"
	fi
	if use nocookiespopup ; then
		# I still don't care about cookies
		policy="$(_add_addon_entry "$policy" "idcac-pub@guus.ninja")"
	fi
	echo "$policy" > "${D}/etc/firefox/policies/policies.json"
}
