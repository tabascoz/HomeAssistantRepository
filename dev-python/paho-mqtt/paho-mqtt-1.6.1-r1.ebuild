# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

DESCRIPTION="A client class with support for MQTT v5.0, v3.1.1, and v3.1"
HOMEPAGE="https://www.eclipse.org/paho/index.php?page=clients/python https://github.com/eclipse/paho.mqtt.python"
SRC_URI="
	https://github.com/eclipse/paho.mqtt.python/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/paho.mqtt.python-${PV}"

LICENSE="EPL-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~riscv x86"

BDEPEND="
	test? (
		dev-python/six[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
