# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Client library to download and publish models, datasets and applications on the Hugging Face Hub"
HOMEPAGE="
    https://huggingface.co/docs/huggingface_hub
    https://github.com/huggingface/huggingface_hub
    https://pypi.org/project/huggingface-hub/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# Core dependencies (always required)
RDEPEND="
    >=dev-python/filelock-3.4.0[${PYTHON_USEDEP}]
    >=dev-python/fsspec-2023.0.0[${PYTHON_USEDEP}]
    >=dev-python/packaging-20.9[${PYTHON_USEDEP}]
    >=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
    >=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
    >=dev-python/tqdm-4.42.1[${PYTHON_USEDEP}]
    >=dev-python/typing-extensions-4.8.0[${PYTHON_USEDEP}]
"

# Optional features via USE flags
IUSE="cli tensorflow torch jax fastapi"

RDEPEND+="
    cli? ( 
        dev-python/rich[${PYTHON_USEDEP}]
    )
    tensorflow? ( 
        >=dev-python/tensorflow-2.4[${PYTHON_USEDEP}]
    )
    torch? ( 
        >=dev-python/torch-1.13[${PYTHON_USEDEP}]
    )
    jax? ( 
        dev-python/jax[${PYTHON_USEDEP}]
        dev-python/flax[${PYTHON_USEDEP}]
    )
    fastapi? ( 
        >=dev-python/fastapi-0.99[${PYTHON_USEDEP}]
        >=dev-python/uvicorn-0.23[${PYTHON_USEDEP}]
        >=dev-python/aiohttp-3.8[${PYTHON_USEDEP}]
    )
"

# Tests require internet access + the real Hub
RESTRICT="test"

src_prepare() {
    default

    # Remove overly restrictive upper bounds that break every month
    sed -i -e 's/~=/>=/g' -e 's/==/>=/g' pyproject.toml || die

    # hatchling doesn't need these at runtime
    sed -i '/hatch-vcs/d' pyproject.toml || die
}

python_test() {
    # Skip tests requiring network + auth
    # If you really want to run them: HF_TOKEN=... pytest -m "not online"
    ewarn "Tests are restricted (require network + HF token). Skipping."
}

pkg_postinst() {
    einfo "huggingface-hub is the official client for https://huggingface.co"
    einfo ""
    einfo "Useful commands:"
    einfo "  huggingface-cli login          # authenticate"
    einfo "  huggingface-cli whoami         # check login"
    einfo "  huggingface-cli download ...   # download models/datasets"
    einfo ""
    if use cli; then
        einfo "CLI extras enabled (rich-based pretty output)"
    fi
    if use torch || use tensorflow || use jax; then
        einfo "Deep-learning framework integrations enabled"
    fi
    if use fastapi; then
        einfo "FastAPI inference server support enabled"
    fi
}
