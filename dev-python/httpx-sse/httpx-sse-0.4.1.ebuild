# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Consume Server-Sent Event (SSE) messages with HTTPX."
HOMEPAGE="
	https://github.com/florimondmanca/httpx-sse
	https://pypi.org/project/httpx-sse/
"
#SRC_URI="https://files.pythonhosted.org/packages/4c/60/8f4281fa9bbf3c8034fd54c0e7412e66edbab6bc74c4996bd616f8d0406e/httpx-sse-0.4.0.tar.gz"
#	https://github.com/encode/httpx/archive/${PV}.tar.gz
#		-> ${P}.gh.tar.gz
#"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~mips ppc ppc64 ~riscv ~s390 sparc x86"

RDEPEND="
	dev-python/httpcore[${PYTHON_USEDEP}]
	>=dev-python/black-23.12.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.26.0[${PYTHON_USEDEP}]
	>=dev-python/mypy-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-7.4.3[${PYTHON_USEDEP}]
	>=dev-python/pytest-asyncio-0.21.1[${PYTHON_USEDEP}]
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	>=dev-util/ruff-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.27.0[${PYTHON_USEDEP}]

	
	
	
"

distutils_enable_tests pytest


src_unpack() {
	unpack ${A}
	echo ${P}
	mv ${P} httpx_sse-${PV}
}
