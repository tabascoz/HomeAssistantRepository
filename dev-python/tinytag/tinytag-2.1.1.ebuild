

EAPI=8

REALNAME="${PN}"
LITERALNAME="${PN}"
REALVERSION="${PV}"
DIGEST_SOURCES="yes"
PYTHON_COMPAT=( python{3_10,3_11,3_12,3_13} )
DISTUTILS_USE_PEP517=standalone

inherit distutils-r1 pypi

DESCRIPTION="Read audio file metadata"

HOMEPAGE="https://github.com/tinytag/tinytag"
LICENSE=""
SRC_URI="https://files.pythonhosted.org/packages/source/${REALNAME::1}/${REALNAME}/${REALNAME}-${REALVERSION}.tar.gz"
SOURCEFILE="${REALNAME}-${REALVERSION}.tar.gz"
RESTRICT="test"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="tests"
DEPENDENCIES="tests? ( dev-python/coverage[${PYTHON_USEDEP}] )
	tests? ( dev-python/mypy[${PYTHON_USEDEP}] )
	tests? ( dev-python/pycodestyle[${PYTHON_USEDEP}] )
	tests? ( dev-python/pylint[${PYTHON_USEDEP}] )
	tests? ( dev-python/pytest[${PYTHON_USEDEP}] )"
BDEPEND="${DEPENDENCIES}"
RDEPEND="${DEPENDENCIES}"
