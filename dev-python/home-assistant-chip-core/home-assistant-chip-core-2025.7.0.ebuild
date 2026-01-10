# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=standalone
inherit  distutils-r1 pypi


DESCRIPTION="Python-base APIs and tools for CHIP (Matter protocol core library for Home Assistant)"
HOMEPAGE="https://pypi.org/project/home-assistant-chip-core/"
SRC_URI="https://files.pythonhosted.org/packages/48/d9/f24a20c6f48d87a23e0345449dfc09b9bb34b24259f69263b164a20956aa/home_assistant_chip_core-2025.7.0-cp37-abi3-manylinux_2_31_x86_64.whl"
S=${WORKDIR}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"  # Adjust based on available wheels; primarily platform-specific for Linux/macOS


RDEPEND="
	>=dev-python/home-assistant-chip-clusters-2024.1.0[${PYTHON_USEDEP}]
"
python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" "${DISTDIR}/${PN//-/_}-${PV}-cp37-abi3-manylinux_2_31_x86_64.whl"
}
