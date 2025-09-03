# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Google Ai Generativelanguage API client library"
HOMEPAGE="https://github.com/googleapis/google-cloud-python https://pypi.org/project/google-ai-generativelanguage/"
SRC_URI="https://files.pythonhosted.org/packages/7a/8b/cb2da099282cf1bf65e4695a1365166652fd3cf136ce6af2cf9129394a54/google_ai_generativelanguage-0.6.16.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

RDEPEND=">=dev-python/google-api-core-1.34.0[${PYTHON_USEDEP}]
	>=dev-python/google-auth-2.14.1[${PYTHON_USEDEP}]
	>=dev-python/proto-plus-1.22.2[${PYTHON_USEDEP}]
	>=dev-python/protobuf-3.19.5[${PYTHON_USEDEP}]"
