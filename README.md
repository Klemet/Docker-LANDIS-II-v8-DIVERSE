# Docker-LANDIS-II-v8-UCL2-DIVERSE

Currently based on the Docker-LANDIS-II-v8-UCL2-release image from https://github.com/LANDIS-II-Foundation/Tool-Docker-Apptainer, except that we install Python packages necessary to run Magic Harvest and other things for the project DIVERSE.

The base image is pulled from GHCR (`ghcr.io/landis-ii-foundation/landis-ii-v8-uclv2-release:ubuntu-26.04`) and pinned by its content digest in the `Dockerfile`, so builds are reproducible and no local build of the base image is needed. To move to a newer base image, get its digest with `docker buildx imagetools inspect ghcr.io/landis-ii-foundation/landis-ii-v8-uclv2-release:ubuntu-26.04` and update the `sha256:...` in the `FROM` line.

To build with Powershell, run from the main folder containing the different images and files :

docker build . -t landis-ii-v8-uclv2-diverse