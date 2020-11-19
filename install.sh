#!/usr/bin/env bash
set -e

echo "Update apt"
sudo apt-get update

echo "Install unclutter to hide the mouse cursor..."
sudo apt-get install unclutter -y --no-install-recommends

echo "Adjust autostart (Screensaver, run script)..."
sudo sed -i.bak '/.*xscreensaver.*/d' /etc/xdg/lxsession/LXDE-pi/autostart
printf "
@xset s off
@xset -dpms
@xset s noblank

@/home/pi/run.sh
" | sudo tee -a /etc/xdg/lxsession/LXDE-pi/autostart

echo "Update chromium..."
sudo apt-get install chromium-browser -y --no-install-recommends

echo "Create run script"
printf "#!/usr/bin/env sh
set -x

START_URL="https://http.cat/200"

/usr/bin/chromium-browser --app=$START_URL
  --kiosk
  --noerrdialogs
  --disable-session-crashed-bubble
  --disable-infobars
  --check-for-update-interval=604800
  --disable-pinch
" | sudo tee -a /home/pi/run.sh
sudo chmod +x /home/pi/run.sh

echo "Restart lightdm"
sudo service lightdm restart
