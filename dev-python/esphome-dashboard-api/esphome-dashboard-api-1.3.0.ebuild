# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="API to interact with ESPHome Dashboard"
HOMEPAGE="https://github.com/esphome/dashboard-api https://pypi.org/project/esphome-dashboard-api/"
SRC_URI="https://files.pythonhosted.org/packages/bd/cd/54f2a1b61544cc966583c92abd9b24cf5f6cbe97be31976b4d1a6657413f/esphome_dashboard_api-1.3.0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}

src_unpack() {
	unpack ${A}
	mv esphome_dashboard_api-${PV}  esphome-dashboard-api-${PV} 
	}



distutils_enable_tests pytest
