# dnf
```bash
sudo dnf install \
    alacritty kitty \
    flameshot \
    fcitx5 fcitx5-autostart fcitx5-chinese-addons fcitx5-configtool \
    google-chrome-stable \
    gnome-tweaks \
    wireshark
```

# flatpak
    * org.telegram.desktop
    * com.dropbox.Client
    * com.netease.CloudMusic
    * org.gimp.GIMP
    * us.zoom.Zoom
    * com.valvesoftware.Steam
    * com.github.marktext.marktext

# Netease Music
```bash
cp /var/lib/flatpak/exports/share/applications/com.netease.CloudMusic.desktop ~/.local/share/applications/
# append --force-device-scale-factor=2.0
```

# Varmilo Keyboard
https://askubuntu.com/questions/818413/how-can-i-toggle-the-fn-function-key
https://help.ubuntu.com/community/AppleKeyboard#Change_Function_Key_behavior
```bash
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf

sudo dracut -f # fedora
sudo update-initramfs -u -k all # ubuntu
```
