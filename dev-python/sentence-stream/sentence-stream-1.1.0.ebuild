# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A small sentence splitter for text streams."
HOMEPAGE="https://github.com/OHF-Voice/sentence-stream 	https://pypi.org/project/sentence-stream/"
#SRC_URI="
#	https://github.com/WoLpH/${PN}/archive/v${PV}.tar.gz
#	-> ${P}.gh.tar.gz
#

RDEPEND="
    >=dev-python/regex-2024.11.6[${PYTHON_USEDEP}]
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

distutils_enable_tests pytest
