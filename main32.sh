DEBIAN_FRONTEND=noninteractive

# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports

# Clone Upstream
git clone https://github.com/elFarto/nvidia-vaapi-driver -b v0.0.9
cp -rvf ./debian ./nvidia-vaapi-driver/
cd ./nvidia-vaapi-driver

# Get build deps
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
apt-get install build-essential -y
apt-get install crossbuild-essential-i386 lib32gcc-11-dev -y
apt-get build-dep ./ -y -a i386

# Build package
dpkg-buildpackage -a i386

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
