#Copyright 1999-2025 Gentoo Authors
#Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1 pypi

DESCRIPTION="Python library for reading audio file metadata"
HOMEPAGE="https://github.com/tinytag/tinytag  https://pypi.org/project/tinytag/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

#SRC_URI="https://files.pythonhosted.org/packages/source/${REALNAME::1}/${REALNAME}/${REALNAME}-${REALVERSION}.tar.gz"
#SOURCEFILE="${REALNAME}-${REALVERSION}.tar.gz"
#RESTRICT="test"

SLOT="0"
KEYWORDS="~amd64 ~x86"
