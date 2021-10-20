# Rom building script for CircleCI
# coded by bruh™ aka Live0verfl0w

MANIFEST_LINK=git://github.com/ShapeShiftOS/android_manifest.git
BRANCH=android_11
ROM_NAME=ssos
DEVICE_CODENAME=vince
GITHUB_USER=kernelhacker69
GITHUB_EMAIL=rathore889047@gmail.com
WORK_DIR=$(pwd)/${ROM_NAME}
JOBS=8

# Set up git!
git config --global user.name ${GITHUB_USER}
git config --global user.email ${GITHUB_EMAIL}

# make directories
mkdir ${WORK_DIR} && cd ${WORK_DIR}

# set up rom repo
repo init --depth=1 -u ${MANIFEST_LINK} -b ${BRANCH}
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j${JOBS}

# clone device sources
git clone -b R https://github.com/GhostMaster69-dev/android_device_xiaomi_vince.git device/xiaomi/vince

git clone -b aosp-11 https://github.com/GhostMaster69-dev/android_vendor_xiaomi_vince.git vendor/xiaomi/vince

git clone -b stable https://github.com/GhostMaster69-dev/android_kernel_xiaomi_vince.git kernel/xiaomi/vince

git clone -b main --depth=1 https://github.com/GhostMaster69-dev/Cosmic-Clang.git prebuilts/clang/host/linux-x86/clang-14

cd ssos
cd build/soong && git fetch https://github.com/masemoel/build_soong_legion-r 11 && git cherry-pick b45c5ae22f74f1bdbb9bfbdd06ecf7a25033c78b && git cherry-pick e020f2130224fbdbec1f83e3adfd06a9764cca87 && cd ../..

# Start building!
. build/envsetup.sh
lunch ssos_vince-userdebug
make sepolicy -j1

