# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OHF Matter Server - WebSocket Matter controller based on matter.js"
HOMEPAGE="https://github.com/matter-js/matterjs-server"
SRC_URI="https://registry.npmjs.org/matter-server/-/matter-server-${PV}.tgz -> ${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+server +systemd"
REQUIRED_USE="systemd? ( server )"

RDEPEND="
	server? ( >=net-libs/nodejs-22.13.0:* )
"

S="${WORKDIR}/package"

inherit systemd

src_install() {
	if use server; then
		cd "${S}" || die
		npm install --omit=dev --ignore-scripts --no-audit --no-fund || die

		insinto /opt/${PN}
		doins -r .

		# CLI wrapper (newbin is the correct Gentoo helper - auto-creates dir + sets +x)
		cat > "${T}/matter-server" <<-'EOF'
#!/bin/sh
exec /usr/bin/node --enable-source-maps "/opt/matterjs-server/dist/esm/MatterServer.js" "$@"
EOF
		newbin "${T}/matter-server" matter-server
	fi

	if use systemd; then
		systemd_dounit "${FILESDIR}/${PN}.service"
	fi

	dodoc README.md
}

pkg_postinst() {
	if use server; then
		elog "Manual start:"
		elog "  matter-server --storage-path /var/lib/matterjs-server"
		elog "Dashboard: http://localhost:5580"
	fi

	if use systemd; then
		elog "Systemd service:"
		elog "  systemctl enable --now matterjs-server.service"
	fi

	elog ""
	elog "Storage directory (recommended):"
	elog "  mkdir -p /var/lib/matterjs-server"
	elog "  chown -R matter:matter /var/lib/matterjs-server  (optional)"
}
