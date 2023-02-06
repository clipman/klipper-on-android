# Using Android to run Klipper, Moonraker, Mainsail/Fuidd, and KlipperScreen
## Alternative Version: https://github.com/gaifeng8864/klipper-on-android (uses fluidd and simplifies the script creation)

### Disclaimer: this is an ongoing work, still some changes pending. will try to update it when i can.
#### Original work by @RyanEwen (https://gist.github.com/RyanEwen/ae81fc48ad00397f1026915f0e6beed9)
#### Current setup i own: Artillery Genius Pro with Klipper Firmware + Lenovo Tab M8 running Klipper+Moonraker+Mainsail+klipperscreen
## Requirements
- A rooted Android device with the following installed:
  - Linux Deploy app: https://play.google.com/store/apps/details?id=ru.meefik.linuxdeploy
  - XServer app: https://play.google.com/store/apps/details?id=x.org.server
  - Octo4a app: https://github.com/feelfreelinux/octo4a
- An OTG+Charge cable up and running for the same device ( please check this video for reference: https://www.youtube.com/watch?v=8afFKyIbky0)
- An already flashed printer using Klipper firmware. 
  - For reference : https://3dprintbeginner.com/how-to-install-klipper-on-sidewinder-x2/

- Init scripts for Klipper and Moonraker (scripts folder).
- XTerm script for KlipperScreen (scripts folder).
 
## Setup Instructions
- Create a container within Linux Deploy using the following settings:
  - **Bootstrap**:
    - **Distro**: `Debian` (buster)
    - **Installation type**: `Directory`  
    *Note: You can choose `File` but make sure it's large enough as you can't resize it later and 2 GB is not enough.*  
    - **Installation path**: `/data/local/debian`  
    *Note: You can choose a different location but if it's within `${EXTERNALDATA}` then SSH may fail to start.*  
    - **User name**: `android`  
    *Note: You can choose something else if you make sure to update the scripts in this gist accordingly.*  
  - **INIT**:
    - **Enable**: `yes`
    - **Init system**: `sysv`
  - **SSH**:
    - **Enable**: `yes`
  - **GUI**:
    - **Enable**: `yes`
    - **Graphics subsystem**: `X11`
    - **Desktop environment**: `XTerm`
- SSH into the container.
- Install Git and KIAUH: 
  ```bash
  sudo apt install git
  git clone https://github.com/th33xitus/kiauh.git
  ```
- Install Klipper, Moonraker, Mainsail (or Fluidd), and KlipperScreen:
  ```bash 
  kiauh/kiauh.sh
  ```
  *Note: KlipperScreen in particular will take a very long time (tens of minutes).*  
- Find your printer's serial device for use in Klipper's `printer.cfg`:  
  It will likely be `/dev/ttyACM0` or `/dev/ttyUSB0`. Check if either of those appear/disappear under `/dev/` when plugging/unplugging your printer.  
  
  If you cannot find your printer in `/dev/`, then you can check Octo4a app which includes a custom implementation of the CH34x driver. IMPORTANT: You don't need to run OctoPrint within it so once in the main screen of the app just stop it if it's running. To do this:   
    - Install Octo4a from https://github.com/feelfreelinux/octo4a/releases
    - Run Octo4a and let it install OctoPrint (optionally tap the Stop button once it's done installing).
    - Make sure Octo4a sees your printer (it will be listed with a checked-box next to it).
    - Now you need to go back to Linux Deploy and edit the container settings:
      - **MOUNTS**:
          - **Enable**: `yes`
          - **Mount points**: press on the "+" button
            - Source: `/data/data/com.octo4a/files`
            - Target: `/root/octo4a`
    - `/root/octo4a/serialpipe` is the serial port you need to use in your `printer.cfg`
- Make the serial device accessible to Klipper:
    ```bash
    chmod 777 /root/octo4a/serialpipe
    ```
- Install the init and xterm scripts from this gist:  
  ```bash
  wget -O /etc/default/klipper https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_klipper
  wget -O /etc/init.d/klipper https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_klipper
  wget -O /etc/default/moonraker https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_default_moonraker
  wget -O /etc/init.d/moonraker https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/etc_init.d_moonraker
  wget -O /usr/local/bin/xterm https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/usr_local_bin_xterm
  wget -O /root https://raw.githubusercontent.com/clipman/klipper-on-android/main/scripts/xterm.sh
  
  chmod +x /etc/init.d/klipper 
  chmod +x /etc/init.d/moonraker 
  chmod +x /usr/local/bin/xterm
  chmod +x /root/xterm.sh

  update-rc.d klipper defaults
  update-rc.d moonraker defaults
  ```
- Stop the Debian container.
- Start XServer XSDL.
    - One time setup: 
        - Tap 'Change Device Configuration'
        - Change Mouse Emulation Mode to Desktop, No Emulation
- Start the Debian container.
- KlipperScreen should appear in XServer XSDL and Mainsail and/or Fluidd should be accesible using your Android device's IP address in a browser.

## Misc
You can start/stop Klipper and Moonraker manually by using the `service` command (eg: `sudo service start klipper`).  
Logs can be found in `/home/android/klipper_logs`.

아래와 같이 수동으로 재실행이 가능합니다.

  ```bash
  /etc/init.d/moonraker restart 
  /etc/init.d/klipper restart

  /root/xterm.sh start 
  /root/xterm.sh stop
  ```

## Telegram Bot
You can find the instructions how to setup the Telegram Bot [here](https://github.com/d4rk50ul1/klipper-on-android/blob/main/telegram_instructions.md)

## Troubleshooting (ongoing section based on comments)
- There might be the case that when accessing Mainsail through Browser, you get an error message and no connection to moonraker: mainsail Permission denied while connecting to upstream in `klipper_logs/mainsail_error.log`. To fix this you must change the file `/etc/nginx/nginx.conf`, change `user www-data;` to `user android;` 
