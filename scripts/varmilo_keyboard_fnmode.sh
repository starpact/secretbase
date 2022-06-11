# https://askubuntu.com/questions/818413/how-can-i-toggle-the-fn-function-key
# https://help.ubuntu.com/community/AppleKeyboard#Change_Function_Key_behavior
# tmp: echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all
