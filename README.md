# photix

## A debian linux live re-spin aimed at photographers and creatives.
![photix-live-linux-desktop-screenshot](https://github.com/pagepusher/photix/blob/main/photix-desktop.png)
### About the project
I needed it, so I built it; photix is a 'live' operating system aimed at photographers, creatives or anyone looking for a go anywhere, boot anything (almost anything; sorry Apple silicon) desktop that can be used to download photos from a digital camera, perform sophisticated raw photo processing and editing, browse the web and more. The iso image can be written to a usb stick or burned to a cd and since photix is a 'live' linux os, it runs entirely in memory and doesn't require installation. If you like it, you can also use it as a base for your own project or even install it on your computer for a clean, fast and modern desktop experience.

### Disclaimer
I'm not a developer or a scripting expert. I just researched how to do this and taught myself the techniques required. I'm 100% certain these scripts could be streamlined or improved. Whilst they have been extensively tested, they are offered here with no garuantee that they won't shred your hard drive, sell your data or steal your lunch. ;) Proceed at your own risk! 

### Features
- Clean, modern desktop – built on debian stable and the gnome desktop environment
- Raw photo processing – powerful photo library management and raw processing with darktable (think lightroom)
- Photo editor – image retouching and editing with gimp (think photoshop)
- Vector graphics – drawing complex scalable graphics with inkscape (think Illustrator)
- Publication design – create professional magazine, book and brochures with scribus (think InDesign) 
- System utilities – comes with a set of standard system utilities; web browser, file manager, terminal etc.
- Runs in live mode – write the .iso file to a usb key or cdrom and boot most modern computers (doesn't require installation)
- Hardware support – extra firmware packages so common wifi cards and other hardware function correctly
- Installable – if you like photix, you can install it on your computer and add extra software packages to create your perfect desktop

### Details
- Base: debian stable 64bit
- Desktop: gnome
- Build environment: debian stable (bookworm) running on windows 10/11 wsl2
- Build tool: live-build
- Customisations: dash-to-dock gnome-shell-extension, wallpaper
- Localisation: British, UK keyboard
- Software: darktable, gimp, scribus, inkscape

### Build your own!
It's easy to build the iso yourself, simply clone this repositiory or download the two files [build.sh](https://github.com/pagepusher/photix/blob/main/build.sh) & [tweaks.sh](https://github.com/pagepusher/photix/blob/main/tweaks.sh) into a folder of your choice on a debian based linux distro or a debian instance on Windows 10/11 WSL environment. Install the pre-requistite software:
```
sudo apt install live-build
```
Then make the two files executable.
```
chmod +x build.sh tweaks.sh
```
Then build the iso. (Requires elevated permissions so use the sudo command or run as root).
```
sudo ./build.sh
```
The script will run, download all the neccessary packages direct from debian servers, inject the tweaks.sh script into the newly built environment which will then be run as the os is being built to apply my customisations. Eventually, (this can take a long time depending on the power of your cpu), the script will complete and you will have a freshly milled iso file named: **photix-amd64.hybrid.iso**

### Test the iso
If you have qemu installed, you can test the iso. It will boot very slowly but it's a good way to test the build has worked. It is possible to use KVM accelerated qemu guest, information on how to do this can be found elsewhere on the web.
```
qemu-system-x86_64 -cdrom photix-amd64.hybrid.iso -m 4G -boot d
```

### Write the iso to a usb key
You can create a bootable usb key easily with a number of cross platform gui tools; **rufus** & **fedora media writer** being a couple of good examples. Failing that there is always good old **dd** on debian. Instructions on how to do this are specific to the machine being used and so are out of the scope of this page.
