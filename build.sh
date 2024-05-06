#!/bin/sh
# shell script to generate the photix live linux iso image
#
# clean any previous builds
lb clean
#
# the 'SYS' variable is a list of system packages to install
SYS="gdm3 \
task-laptop \
gnome-core \
gnome-shell-extension-dashtodock"
#
# the 'APPS' variable is a list of creative apps to install
APPS="epiphany-browser \
darktable \
gimp \
inkscape \
scribus"
#
# the 'HOST' variable is the hostname of our build
HOST=photix
#
# let's configure the build environment
# see the live-build documentation for more info on these options
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
# write the package lists to the config folder
echo $SYS > config/package-lists/system.list.chroot
echo $APPS > config/package-lists/apps.list.chroot
#
# uncomment the next two lines to add a custom background wallpaper file named 'photix-wallpaper.jpg'
# mkdir -p config/includes.chroot/usr/share/backgrounds
# cp photix-wallpaper.jpg config/includes.chroot/usr/share/backgrounds
#
# add the tweaks script
cp tweaks.sh config/hooks/live/customise.hook.chroot
#
# add the bootloader
cp -r /usr/share/live/build/bootloaders/isolinux config/bootloaders
# uncomment the next  2 lines to add a custom boot screen wallpaper named 'photix-splash.png'
# cp photix-splash.png config/bootloaders/isolinux/splash.png
cp -r /usr/share/live/build/bootloaders/grub-pc config/bootloaders
# cp photix-splash.png config/bootloaders/grub-pc/splash.png
#
# let's make sure that the package manager apt is configured correctly
# we'll also load in the extra firmware during this step
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
# set low-res boot splash screen
sed -i 's/gfxmode=auto/gfxmode=1024x768/' config/bootloaders/grub-pc/config.cfg
#
# remove the annoying boot screen beep
# seems to only work for bios boot, not UEFI
sed -i 's/play 960/#play 960/' config/bootloaders/grub-pc/config.cfg
#
# let's build this thing
echo "OK, we're ready to build!"
lb build

