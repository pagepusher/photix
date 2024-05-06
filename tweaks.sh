#!/bin/sh
# photix tweaks script
#
# create local settings database
printf "user-db:user\nsystem-db:local" > /etc/dconf/profile/user
mkdir -p /etc/dconf/db/local.d
#
# set the default wallpaper
printf "[org/gnome/desktop/background]\n
picture-uri='file:///usr/share/backgrounds/gnome/blobs-d.svg'\n
picture-options='zoom'\n
primary-color='#241f31'\n
secondary-color='#000000'" > /etc/dconf/db/local.d/00-background
#
# set the favourite apps
printf "# sets web, nautilus, darktable, gimp, inkscape & scribus as default favorites for all users\n
[org/gnome/shell]\n
favorite-apps = ['org.gnome.Epiphany.desktop', 'org.gnome.Nautilus.desktop', 'org.darktable.darktable.desktop', 'gimp.desktop', 'org.inkscape.Inkscape.desktop', 'scribus.desktop']" > /etc/dconf/db/local.d/00-favorite-apps
#
# enable the dash to dock gnome extension
printf "[org/gnome/shell]\n
# list all extensions that you want to have enabled for all users\n
enabled-extensions=['dash-to-dock@micxgx.gmail.com']" > /etc/dconf/db/local.d/00-extensions
#
# set dark gtk theme
printf "[org/gnome/desktop/interface]\n
gtk-theme='Adwaita-dark'" > /etc/dconf/db/local.d/00-theme
# update the settings database
dconf update
