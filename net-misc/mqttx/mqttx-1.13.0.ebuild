# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Powerful cross-platform MQTT 5.0 desktop, CLI, and WebSocket client toolbox"
HOMEPAGE="https://mqttx.app https://github.com/emqx/MQTTX"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

SRC_URI="https://packages.emqx.io/MQTTX/v${PV}/MQTTX-${PV}.AppImage -> MQTTX-${PV}.AppImage"

RDEPEND="
    sys-fs/fuse:0
    media-libs/alsa-lib
    media-libs/fontconfig:1.0
    media-libs/freetype:2
    media-libs/libglvnd
    media-libs/mesa
    net-print/cups
    sys-apps/dbus
    x11-libs/cairo
    x11-libs/gdk-pixbuf:2
    x11-libs/gtk+:3[X]
    x11-libs/libX11
    x11-libs/libXScrnSaver
    x11-libs/libXcomposite
    x11-libs/libXcursor
    x11-libs/libXdamage
    x11-libs/libXext
    x11-libs/libXfixes
    x11-libs/libXi
    x11-libs/libXrandr
    x11-libs/libXrender
    x11-libs/libXtst
    x11-libs/pango
"

inherit desktop wrapper xdg

S="${WORKDIR}"

src_unpack() {
    cp "${DISTDIR}/MQTTX-${PV}.AppImage" "${WORKDIR}/MQTTX.AppImage" || die
    chmod +x "${WORKDIR}/MQTTX.AppImage" || die
}

src_install() {
    local dest="/opt/${PN}"

    exeinto "${dest}"
    newexe "${WORKDIR}/MQTTX.AppImage" MQTTX.AppImage

    # Extract AppImage
    "${WORKDIR}/MQTTX.AppImage" --appimage-extract || die "AppImage extraction failed"

    insinto "${dest}"
    doins -r squashfs-root/.

    # Fix permissions: Make AppRun and main binary executable
    chmod +x "${D}${dest}/AppRun" || die "chmod AppRun failed"
    chmod +x "${D}${dest}/mqttx" || die "chmod main binary failed"
    # Optional: other potential executables
    chmod +x "${D}${dest}"/chrome_* 2>/dev/null || true

    rm -rf squashfs-root || die

    make_wrapper mqttx "${dest}/AppRun" "${dest}"

    # Improved icon search
    local icon_found=""
    for candidate in \
        "${D}${dest}/usr/share/icons/hicolor/"*"/apps/mqttx.png" \
        "${D}${dest}/usr/share/icons/hicolor/"*"/apps/mqttx.svg" \
        "${D}${dest}/.DirIcon" \
        "${D}${dest}/icon.png" \
        "${D}${dest}/resources/icon.png" \
        "${D}${dest}/resources/app/icon.png" \
        "${D}${dest}/*.png" "${D}${dest}/*.svg" ; do
        if [[ -f "${candidate}" ]]; then
            icon_found="${candidate}"
            break
        fi
    done

    if [[ -n "${icon_found}" ]]; then
        newicon "${icon_found}" mqttx.png
        elog "Found and installed icon: ${icon_found#${D}}"
    else
        ewarn "No icon file found in extracted AppImage. Desktop entry will use generic/fallback icon."
    fi

    make_desktop_entry mqttx "MQTTX" mqttx "Development;Network;Utility;"
}
pkg_postinst() {
    xdg_pkg_postinst
    elog "MQTTX v${PV} installed to /opt/mqttx"
    elog "Run with: mqttx"
}