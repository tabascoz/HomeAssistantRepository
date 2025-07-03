# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 

DESCRIPTION="A Python library for local control of Midea (and associated brands) smart air conditioners."
HOMEPAGE="https://github.com/mill1000/midea-msmart"
SRC_URI="https://github.com/mill1000/midea-msmart/archive/refs/tags/${PV}.tar.gz"

#		-> ${P}.gh.tar.gz


LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
#RESTRICT="!test? ( test )"

DOCS="README.md"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

#python_test() {
#	py.test -v -v || die
#}

#distutils_enable_tests pytest

python_prepare_all() {
   export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
      distutils-r1_python_prepare_all
      }