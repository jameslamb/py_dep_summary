#!/bin/bash

PY_PKG_PATH=${1}
OUT_FILE=${2}
CONDA_ENV_NAME="license_check"

# failure is a natural part of life
set -e

# Create env only if it doesn't exist
if ! (conda env list | grep -q "${CONDA_ENV_NAME}"); then \
    echo "${CONDA_ENV_NAME} conda environment doesn't exist. Creating..." && \
    conda create \
        -y \
        --name ${CONDA_ENV_NAME} \
        python=3.6; \
else
    echo "Conda env ${CONDA_ENV_NAME} already exists, not updating."
fi

source activate ${CONDA_ENV_NAME}

pushd ${PY_PKG_PATH}

    python -m pip install pip-licenses
    python setup.py install

popd

echo "Writing license info to ${OUT_FILE}"
pip-licenses \
    --with-urls \
    --format=json > ${OUT_FILE}
echo "Done writing license information"

source deactivate

echo "Tearing down conda env"

conda-env remove --name ${CONDA_ENV_NAME}

echo "Done"
