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
    gdal-bin \
    libgdal-dev \
    && rm -rf /var/lib/apt/lists/*

# Adding the Python packages we need to make everything run
COPY ./additional_files/pip_requirements.txt /tmp
RUN pip3 install --break-system-packages --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r /tmp/pip_requirements.txt

# Adding a bug fix for Library succession that are not yet deployed on the official repositories but that we need in DIVERSE.
# The bug fix have been deployed on a forks on Github through Klemet's account; see https://github.com/Klemet/Library-Succession.
# We simply copy the precompiled .dll resulting from this fix, which is in /additional_files,
# so as to avoid re-installing the dotnet SDK necessary to compile it (these SDKs are used in the base landis-ii-v8-uclv2-release
# image, but uninstalled at the end of the build so as to free up space in the final image).
# We remove the previous .dll
RUN rm $LANDIS_REL_DIR/Landis.Library.Succession-v10.dll && rm $LANDIS_EXT_DIR/Landis.Library.Succession-v10.dll
# We copy the new one
COPY ./additional_files/Landis.Library.Succession-v10.dll $LANDIS_REL_DIR
COPY ./additional_files/Landis.Library.Succession-v10.dll $LANDIS_EXT_DIR