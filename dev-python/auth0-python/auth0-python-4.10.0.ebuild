##Copyright 1999-2025 Gentoo Authors
##Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=standalone

PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi
DESCRIPTION="Auth0 SDK for Python"
HOMEPAGE="https://github.com/auth0/auth0-python https://pypi.org/project/auth0-python/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

RDEPEND="
    dev-python/aiohttp[${PYTHON_USEDEP}]
    dev-python/cryptography[${PYTHON_USEDEP}]
    dev-python/pyjwt[${PYTHON_USEDEP}]
    dev-python/requests[${PYTHON_USEDEP}]
    dev-python/urllib3[${PYTHON_USEDEP}]"

BDEPEND="
    dev-python/poetry-dynamic-versioning[${PYTHON_USEDEP}]
    test? ( dev-python/pytest[${PYTHON_USEDEP}] )
    "


distutils_enable_tests pytest
