# https://askubuntu.com/questions/818413/how-can-i-toggle-the-fn-function-key
# https://help.ubuntu.com/community/AppleKeyboard#Change_Function_Key_behavior
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf

# fedora
sudo dracut -f
# ubuntu
sudo update-initramfs -u -k all
