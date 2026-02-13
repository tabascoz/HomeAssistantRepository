# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

MY_PN="litellm"
DESCRIPTION="Call all LLM APIs using the OpenAI format (OpenAI, Azure, Anthropic, Cohere, Groq, TogetherAI, HuggingFace, etc.)"
HOMEPAGE="
    https://litellm.ai/
    https://github.com/BerriAI/litellm
    https://pypi.org/project/litellm/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# Core dependencies (always required)
RDEPEND="
    >=dev-python/aiohttp-3.8.0[${PYTHON_USEDEP}]
    >=dev-python/click-8.0.0[${PYTHON_USEDEP}]
    >=dev-python/importlib-metadata-6.0.0[${PYTHON_USEDEP}]
    >=dev-python/jinja2-3.1.0[${PYTHON_USEDEP}]
    >=dev-python/openai-1.0.0[${PYTHON_USEDEP}]
    >=dev-python/python-dotenv-1.0.0[${PYTHON_USEDEP}]
    >=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
    >=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
    >=dev-python/tiktoken-0.12.0[${PYTHON_USEDEP}]
    >=dev-python/tokenizers-0.22.1
"

# Optional / extra dependencies (enabled via USE flags)
IUSE="proxy server ui -extra"

RDEPEND+="
    proxy? (
        >=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
        >=dev-python/gunicorn-21.2.0[${PYTHON_USEDEP}]
        >=dev-python/uvicorn-0.23.0[${PYTHON_USEDEP}]
        >=dev-python/fastapi-0.100.0[${PYTHON_USEDEP}]
    )
    server? (
        >=dev-python/fastapi-0.100.0[${PYTHON_USEDEP}]
        >=dev-python/uvicorn-0.23.0[${PYTHON_USEDEP}]
        >=dev-python/backoff-2.2.0[${PYTHON_USEDEP}]
    )
    ui? (
        >=dev-python/streamlit-1.30.0[${PYTHON_USEDEP}]
    )
    extra? (
        >=dev-python/aleph-alpha-client-2.0.0[${PYTHON_USEDEP}]
        >=dev-python/anthropic-0.8.0[${PYTHON_USEDEP}]
        >=dev-python/cohere-5.0.0[${PYTHON_USEDEP}]
        >=dev-python/databricks-sdk-0.1.0[${PYTHON_USEDEP}]
        >=dev-python/google-generativeai-0.3.0[${PYTHON_USEDEP}]
        >=dev-python/groq-0.4.0[${PYTHON_USEDEP}]
        >=dev-python/mistralai-0.1.0[${PYTHON_USEDEP}]
        >=dev-python/openrouter-0.1.0[${PYTHON_USEDEP}]
        >=dev-python/replicate-0.15.0[${PYTHON_USEDEP}]
        >=dev-python/together-0.2.0[${PYTHON_USEDEP}]
        >=dev-python/boto3-1.26.0[${PYTHON_USEDEP}]
        >=dev-python/apscheduler-3.10.0[${PYTHON_USEDEP}]
    )
"

src_prepare() {
    default

    sed -i '/poetry-dynamic-versioning/d' pyproject.toml || die

    sed -i -e '/openai[[:space:]]*==/s/==/>=/' \
           -e '/tiktoken[[:space:]]*==/s/==/>=/' \
           -e '/pydantic[[:space:]]*==/s/==/>=/' pyproject.toml || die
}

pkg_postinst() {
    einfo "litellm provides a unified OpenAI-compatible interface to 100+ LLM providers."
    einfo "Optional features:"
    einfo "  USE=proxy  - Enable proxy server (litellm --config)"
    einfo "  USE=server - Enable OpenAI-compatible API server"
    einfo "  USE=ui     - Install Streamlit UI"
    einfo "  USE=extra  - Install support for many additional providers"
}
