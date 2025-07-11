# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="A python library for interacting with the SmartThings cloud API build with asyncio and aiohttp."
HOMEPAGE="https://github.com/andrewsayre/pysmartthings https://pypi.org/project/pysmartthings/"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
#SRC_URI="https://github.com/pySmartThings/pysmartthings/releases/download/v3.0.5/pysmartthings-3.0.5.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND=">=dev-python/aiohttp-3.5.1[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest
