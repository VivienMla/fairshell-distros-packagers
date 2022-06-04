This directory contains Docker recipes to create packages (RPM, Deb) build environments.
It allows one to create functionnal packages for the supported Linux distributions; the
packaging process _does probably not_ respect each distribution, contributions are welcome.

# Preparation
Ensure the Docker runtime is installed, and run 'make' in this directory to rebuild all.

HTTP/HTTPS proxies can be specified by defining the `http_proxy` and `https_proxy` environment variables
before running `make`.

This creates Docker images named as `fairshell-<distribution>-builder` (like `fairshell-fedora-builder`).

# Usage
To create a package from sources for a specific distribution, run a Docker container
associated with the distribution and specify:
- the VERSION, NAME of the package to build;
- the UID and GID of the user (used to set the correct permissions on the generated package files),
  typically this should be `$(id -u)` and `$(id -g)` respectively.
- the tarball file using the `-v` option to map it to the `/tarball.tar.gz` file in the Docker
  container
- the output directory where the generated packages will be, also using the `-v` option to map it to the `/out`
  directory in the Docker container.

For example:
~~~
docker run --rm -e "VERSION=1.0.0" -e "NAME=ThePackage" \
     -e "UID=$(id -u)" -e "GID=$(id -g)" \
     -v "/path/to/sources.tar:/tarball.tar.gz:ro" -v "/path/to/out-directory:/out" "fairshell-debian-builder"
~~~

The command returns 0 if the package(s) was(were) built, and another value if an error occurred.