#! /bin/bash

VERSION="0.0.12"

export DEBIAN_FRONTEND="noninteractive"
export DEB_BUILD_OPTIONS="nocheck notest terse"
export DPKG_GENSYMBOLS_CHECK_LEVEL=0

# Clone Upstream
git clone https://github.com/elFarto/nvidia-vaapi-driver -b v"$VERSION"
cp -rvf ./debian ./nvidia-vaapi-driver/
cd ./nvidia-vaapi-driver

# Get build deps
apt-get build-dep ./ -y

# Build package
LOGNAME=root dh_make --createorig -y -l -p nvidia-vaapi-driver_"$VERSION".git || echo "dh-make didn't go clean"
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
