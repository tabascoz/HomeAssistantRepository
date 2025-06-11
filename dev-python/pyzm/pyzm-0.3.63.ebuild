# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 pypi

DESCRIPTION="imutils collection"
HOMEPAGE="https://github.com/pliablepixels/pyzm https://pypi.org/project/pyzm/"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86 amd64-linux x86-linux"

RDEPEND=""

DEPEND="${REDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

