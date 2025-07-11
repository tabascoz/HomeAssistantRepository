# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 udev

DESCRIPTION="An open source ecosystem for IoT development"
HOMEPAGE="https://platformio.org/"
SRC_URI="https://github.com/platformio/platformio-core/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}"/${PN}-core-${PV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	$(python_gen_cond_dep '
		~dev-python/bottle-0.12.25[${PYTHON_USEDEP}]
		>=dev-python/click-8.0.4[${PYTHON_USEDEP}]
		<dev-python/click-9[${PYTHON_USEDEP}]
		dev-python/colorama[${PYTHON_USEDEP}]
		~dev-python/marshmallow-3.21.1[${PYTHON_USEDEP}]
		~dev-python/pyserial-3.5[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		>=dev-python/semantic-version-2.10[${PYTHON_USEDEP}]
		<dev-python/semantic-version-3[${PYTHON_USEDEP}]
		<dev-python/tabulate-1[${PYTHON_USEDEP}]
		~dev-python/ajsonrpc-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/starlette-0.41.2[${PYTHON_USEDEP}]
		>=dev-python/uvicorn-0.19[${PYTHON_USEDEP}]
		<dev-python/uvicorn-0.36[${PYTHON_USEDEP}]
		dev-python/wsproto[${PYTHON_USEDEP}]
		>=dev-python/pyelftools-0.27[${PYTHON_USEDEP}]
		<dev-python/pyelftools-1[${PYTHON_USEDEP}]
	')
	virtual/udev"
DEPEND="virtual/udev"
BDEPEND="test? ( $(python_gen_cond_dep 'dev-python/jsondiff[${PYTHON_USEDEP}]') )"

# This list could be refined a bit to have individual tests which need network
# (within EPYTEST_DESELECT) but so many need it that it doesn't seem worth it right now.
EPYTEST_IGNORE=(
	# Requires network access
	tests/test_builder.py
	tests/package/test_manager.py
	tests/package/test_manifest.py
	tests/commands/test_platform.py
	tests/commands/test_test.py
	tests/commands/test_ci.py
	tests/commands/test_init.py
	tests/commands/test_lib.py
	tests/commands/test_lib_complex.py
	tests/commands/test_boards.py
	tests/commands/test_check.py
	tests/commands/test_run.py
	tests/commands/pkg/test_exec.py
	tests/commands/pkg/test_list.py
	tests/commands/pkg/test_outdated.py
	tests/commands/pkg/test_search.py
	tests/commands/pkg/test_show.py
	tests/commands/pkg/test_install.py
	tests/commands/pkg/test_uninstall.py
	tests/commands/pkg/test_update.py
	tests/misc/ino2cpp/test_ino2cpp.py
	tests/test_maintenance.py
	tests/test_misc.py
)

EPYTEST_DESELECT=(
	# Requires network access
	tests/misc/test_maintenance.py::test_check_pio_upgrade
	tests/misc/test_misc.py::test_ping_internet_ips
	tests/misc/test_misc.py::test_api_cache
)

distutils_enable_tests pytest

python_test() {
	epytest -k "not skip_ci"
}

src_install() {
	distutils-r1_src_install
	udev_dorules platformio/assets/system/99-platformio-udev.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
