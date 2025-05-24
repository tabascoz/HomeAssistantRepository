# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 
DISTUTILS_EXT=1

DESCRIPTION="python-geohash is a fast, accurate python geohashing library."
HOMEPAGE="https://pypi.org/project/python-geohash/"
SRC_URI="https://files.pythonhosted.org/packages/9c/e2/1a3507af7c8f91f8a4975d651d4aeb6a846dfdf74713954186ade4205850/python-geohash-0.8.5.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"

DOCS="README"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

