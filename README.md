# genfox-overlay
Essential privacy and usability addons, handled like Gentoo packages.

## Motivation
* Automatic updates are great until a [rugpull](https://www.i-dont-care-about-cookies.eu/whats-new/acquisition/) [happens](https://adblockplus.org/acceptable-ads).
* Manual updates can be forgotten.
* Global configuration is useful for multi-user computers.

## Installation
1. `eselect repository add genfox-overlay git https://github.com/ivan-boikov/genfox-overlay.git`
2. `emaint sync --repo genfox-overlay`
3. `emerge www-misc/firefox-policy` installs a system-wide policy for blocking updates for the browser and addons specified with USE flags.

## Notes
* Addon policies are permissive: they can be disabled/deleted by a user.
* [Since 2020 Firefox no longer supports addon sideloading](https://blog.mozilla.org/addons/2020/03/10/support-for-extension-sideloading-has-ended) except for [ESR, Developer, Nightly and unbranded editions](https://support.mozilla.org/en-US/kb/add-on-signing-in-firefox).
Only binary packages for addons are supported, although there is a source-based `uBlock Origin` package.
* [Excess addons harm privacy](https://github.com/arkenfox/user.js/wiki/4.1-Extensions), so only a few addons are included.

## TODO
* arkenfox configs
