# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
#DISTUTILS_USE_PEP517=hatchling
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="WSGI HTTP Server for UNIX"
HOMEPAGE="
    https://gunicorn.org
    https://github.com/benoitc/gunicorn
    https://pypi.org/project/gunicorn/
"

# pypi inherit downloads the sdist automatically
#SRC_URI="$(pypi_sdist_url "${PN}-${PV}.tar.gz")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

# Core dependencies (always required)
RDEPEND="
    >=dev-python/packaging-21.0[${PYTHON_USEDEP}]
"

# Optional worker types and features
IUSE="gevent eventlet tornado setproctitle"

RDEPEND+="
    gevent? ( >=dev-python/gevent-22.10[${PYTHON_USEDEP}] )
    eventlet? ( >=dev-python/eventlet-0.33.3[${PYTHON_USEDEP}] )
    tornado? ( >=dev-python/tornado-6.2[${PYTHON_USEDEP}] )
    setproctitle? ( >=dev-python/setproctitle-1.2[${PYTHON_USEDEP}] )
"

# Tests require network + external servers
RESTRICT="test"

src_prepare() {
    default

    # Remove overly strict upper bounds that break regularly
    sed -i -e 's/~=/>=/g' -e 's/==/>=/g' pyproject.toml || die

    # hatch-vcs is only needed for building from git
    sed -i '/hatch-vcs/d' pyproject.toml || die
}

python_test() {
    # Tests require pytest, pytest-cov, and network access
    ewarn "Skipping tests (require network and many extras)"
}

pkg_postinst() {
    einfo "Gunicorn is a pre-fork worker model WSGI server."
    einfo ""
    einfo "Supported worker types:"
    einfo "  sync      - default (pure Python)"
    if use gevent; then
        einfo "  gevent    - enabled via USE=gevent"
    fi
    if use eventlet; then
        einfo "  eventlet  - enabled via USE=eventlet"
    fi
    if use tornado; then
        einfo "  tornado   - enabled via USE=tornado"
    fi
    einfo ""
    einfo "Example commands:"
    einfo "  gunicorn myapp:wsgi_app"
    einfo "  gunicorn -w 4 -k gevent myapp:wsgi_app   # with gevent workers"
    einfo "  gunicorn -b 0.0.0.0:8000 myapp:wsgi_app"
    if use setproctitle; then
        einfo ""
        einfo "USE=setproctitle is enabled – process titles will be nice in ps/top"
    fi
}
