#!/bin/bash

wget -O /etc/default/klipper https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_klipper
wget -O /etc/init.d/klipper https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_klipper
wget -O /etc/default/moonraker https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_moonraker
wget -O /etc/init.d/moonraker https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_moonraker
wget -O /etc/default/crowsnest https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_crowsnest
wget -O /etc/init.d/crowsnest https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_crowsnest
wget -O /etc/default/socat https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_socat
wget -O /etc/init.d/socat https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_socat
wget -O /etc/default/xterm https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_xterm
wget -O /etc/init.d/xterm https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_xterm
wget -O /usr/local/bin/xterm https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/usr_local_bin_xterm

chmod +x /etc/init.d/klipper
chmod +x /etc/init.d/moonraker
chmod +x /etc/init.d/crowsnest
chmod +x /etc/init.d/socat
chmod +x /etc/init.d/xterm
chmod +x /usr/local/bin/xterm

update-rc.d klipper defaults
update-rc.d moonraker defaults
update-rc.d crowsnest defaults
update-rc.d socat defaults
update-rc.d xterm defaults

nano /etc/default/socat
nano /etc/default/xterm
