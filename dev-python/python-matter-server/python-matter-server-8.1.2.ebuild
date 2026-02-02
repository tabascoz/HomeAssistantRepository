# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3_11 python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python Matter WebSocket Server"
HOMEPAGE=" https://pypi.org/project/python-matter-server/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test systemd server"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	acct-group/matter-server
	acct-user/matter-server	
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiorun[${PYTHON_USEDEP}]
	|| ( ~dev-python/atomicwrites-1.4.1[${PYTHON_USEDEP}] ~dev-python/atomicwrites-homeassistant-1.4.1[${PYTHON_USEDEP}] )
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/orjson[${PYTHON_USEDEP}]
	dev-python/dacite[${PYTHON_USEDEP}]
	dev-python/zeroconf[${PYTHON_USEDEP}]
	~dev-python/home-assistant-chip-core-2025.7.0[${PYTHON_USEDEP}]
	~dev-python/ecdsa-0.19.1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-aiohttp[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)"

python_install_all() {
	distutils-r1_python_install_all
	use systemd && use server && systemd_dounit "${FILESDIR}/matter-server.service"
        keepdir /data
        keepdir /var/lib/matter-server
	fowners matter-server:matter-server /data
	fowners matter-server:matter-server /var/lib/matter-server
	fperms 0700 /data
	fperms 0700 /var/lib/matter-server
	

}


distutils_enable_tests pytest
