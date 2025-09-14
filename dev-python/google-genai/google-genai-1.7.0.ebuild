# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1
DESCRIPTION="Google Gen AI Python SDK provides an interface for developers to integrate Google's generative models into their Python applications. It supports the Gemini Developer API and Vertex AI APIs."
HOMEPAGE="https://github.com/googleapis/python-genai https://pypi.org/project/google-genai/"
MY_PN="google-genai"
SRC_URI="https://github.com/googleapis/python-genai/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
#SRC_URI="https://github.com/google/generative-ai-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S=${WORKDIR}/${MY_PN}-${PV}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	dev-python/absl-py[${PYTHON_USEDEP}]
	dev-python/iniconfig[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]"

src_unpack() {
	unpack ${A}
	echo ${P}
	mv python-genai-${PV}  google-genai-${PV} 
	}

PATCHES=( "${FILESDIR}/${P}-add-build.patch" )
