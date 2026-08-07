# Using the latest image from https://github.com/LANDIS-II-Foundation/Tool-Docker-Apptainer as a base
# This image must be built already on your computer
# To build it, you can download the https://github.com/LANDIS-II-Foundation/Tool-Docker-Apptainer repository and follow the instructions there
FROM landis-ii-v8-uclv2-release:ubuntu-26.04

ARG LANDIS_GITHUB="https://github.com/LANDIS-II-Foundation"

ARG LANDIS_DIR="/opt/landis-ii" ## use /opt for non-OS-bundled software
ARG LANDIS_CORE_DIR="$LANDIS_DIR/Core-Model-v8-LINUX"
ARG LANDIS_EXT_DIR="$LANDIS_CORE_DIR/build/extensions"
ARG LANDIS_REL_DIR="$LANDIS_CORE_DIR/build/Release"

ARG EXT_LOG_FILE="$LANDIS_DIR/build_exts.log"
ARG LIB_LOG_FILE="$LANDIS_DIR/build_libs.log"
ARG TESTS_DIR="$LANDIS_DIR/tests"

# Install pip if not already present (Ubuntu 26.04 may have python3-pip)
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-venv \
	git \
    && rm -rf /var/lib/apt/lists/*

# Adding the Python packages we need to make everything run
COPY ./additional_files/pip_requirements.txt /tmp
RUN pip3 install --break-system-packages --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r /tmp/pip_requirements.txt