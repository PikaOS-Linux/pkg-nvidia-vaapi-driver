DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://github.com/elFarto/nvidia-vaapi-driver -b v0.0.10
cp -rvf ./debian ./nvidia-vaapi-driver/
cd ./nvidia-vaapi-driver

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
