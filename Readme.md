This is very basic NixOS configuration. 

I setup DWM as main window manager.

And Cinnamon and Gnome as Desktop Environment. 

My system runs very smooth and blazing fast. 

All works, include :
- NTFS read write
- Polkit authentication
- etc

## How to use this build?

I only put all my system configuration into one file. And some I put manually just by create dotfiles which located on `.config` folder.

Clone this repo then place the `configuration.nix` file and `DWM and ST` folder into `/etc/nixos/` folder then hit `nixos-rebuild switch`.

## screenshot

![nixos configuration + dwm build](https://github.com/rafimrfdn/nixos/blob/main/nixos-configuration-dwm-build-rafimrfdn.jpg)
