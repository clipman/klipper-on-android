#!/bin/bash

wget -O /etc/default/klipper https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_klipper
wget -O /etc/init.d/klipper https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_klipper
wget -O /etc/default/moonraker https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_moonraker
wget -O /etc/init.d/moonraker https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_moonraker
wget -O /etc/default/socat https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_socat
wget -O /etc/init.d/socat https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_socat
wget -O /usr/local/bin/xterm https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/usr_local_bin_xterm
wget -O /root/xterm.sh https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/xterm.sh

chmod +x /etc/init.d/klipper
chmod +x /etc/init.d/moonraker
chmod +x /etc/init.d/socat
chmod +x /usr/local/bin/xterm
chmod +x /root/xterm.sh

update-rc.d klipper defaults
update-rc.d moonraker defaults
update-rc.d socat defaults

nano /etc/default/socat
nano /usr/local/bin/xterm
nano /root/xterm.sh
