# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} )

inherit pypi distutils-r1

DESCRIPTION="Pre-packaged voice activity detector using silero-vad"
HOMEPAGE="https://pypi.org/project/pysilero-vad/ https://github.com/rhasspy/pysilero-vad"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

# The package provides manylinux and musllinux wheels, so it should work on most Linux arches.
# No explicit runtime dependencies listed on PyPI (it bundles ONNX Runtime C++).
RDEPEND=""

# No tests in the sdist
RESTRICT="test"
