#!/bin/sh
# build script to generate photix live distro
#
# clean any previous builds
lb clean
#
# list of desktop packages to install
SYS="gdm3 \
task-laptop \
gnome-core \
gnome-shell-extension-dashtodock"
#
# list of apps to install
APPS="epiphany-browser \
darktable \
gimp \
inkscape \
scribus"
#
# hostname
HOST=photix
#
# config the build environment
lb config noauto --archive-areas "main contrib non-free non-free-firmware" \
--architecture amd64 \
--distribution bookworm \
--hdd-label $HOST \
--image-name $HOST \
--iso-publisher $HOST \
--iso-volume $HOST \
--debian-installer live \
--debian-installer-gui false \
--bootappend-live "boot=live components hostname=photix locales=en_GB.UTF-8 keyboard-layouts=UK" \
--debootstrap-options "--variant=minbase" \
--memtest none \
--apt-indices false \
--firmware-chroot true \
--win32-loader false \
--firmware-binary true \
--firmware-chroot true \
--parent-archive-areas "main contrib non-free non-free-firmware"
#
# write the package list
echo $SYS > config/package-lists/system.list.chroot
echo $APPS > config/package-lists/apps.list.chroot
#
# add background wallpaper
# mkdir -p config/includes.chroot/usr/share/backgrounds
# cp photix-wallpaper.jpg config/includes.chroot/usr/share/backgrounds
#
# add tweaks script 
cp tweaks.sh config/hooks/live/customise.hook.chroot
#
# add customised boot splash
cp -r /usr/share/live/build/bootloaders/isolinux config/bootloaders
# cp photix-splash.png config/bootloaders/isolinux/splash.png
cp -r /usr/share/live/build/bootloaders/grub-pc config/bootloaders
# cp photix-splash.png config/bootloaders/grub-pc/splash.png
#
# let's make sure apt is configured correctly
printf "#!/bin/sh \n
sed -i 's/main/main contrib non-free non-free-firmware/' /etc/apt/sources.list \n
apt update \n
apt install --yes firmware-linux-free \
firmware-linux-nonfree \
firmware-atheros \
firmware-iwlwifi \
firmware-zd1211 \
firmware-realtek \
firmware-bnx2 \
firmware-brcm80211 \
firmware-cavium \
firmware-libertas \
firmware-ti-connectivity" > config/hooks/live/apt.hook.chroot
#
# set low-res splash screen
sed -i 's/gfxmode=auto/gfxmode=1024x768/' config/bootloaders/grub-pc/config.cfg
#
# remove annoying beep
sed -i 's/play 960/#play 960/' config/bootloaders/grub-pc/config.cfg
#
# let's build the thing
echo "we're ready to build!"
lb build

