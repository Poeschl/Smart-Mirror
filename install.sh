#!/usr/bin/env bash
set -e

echo "Update apt"
sudo apt-get update

echo "Install unclutter to hide the mouse cursor"
sudo apt-get install unclutter -y --no-install-recommends

echo "Disable screensaver"
sudo sed -i.bak '/.*xscreensaver.*/d' /etc/xdg/lxsession/LXDE-pi/autostart
printf "
@xset s off
@xset -dpms
@xset s noblank
" | sudo tee -a /etc/xdg/lxsession/LXDE-pi/autostart

echo "Update chromium"
sudo apt-get install chromium-browser -y --no-install-recommends

echo "Create run script"
mkdir /home/pi/start
printf '#!/usr/bin/env sh
set -e

START_URL="https://http.cat/200"

/usr/bin/chromium-browser \
  --app=$START_URL \
  --kiosk \
  --noerrdialogs \
  --disable-session-crashed-bubble \
  --disable-infobars \
  --check-for-update-interval=604800 \
  --disable-pinch
' > /home/pi/start/fullscreen-browser.sh
sudo chmod +x /home/pi/start/fullscreen-browser.sh
printf "@/home/pi/start/fullscreen-browser.sh" | sudo tee -a /etc/xdg/lxsession/LXDE-pi/autostart

echo "Install tools for display turn off"
cp cec /home/pi/start/cec 
printf "@cd /home/pi/start/cec && ./start.sh" | sudo tee -a /etc/xdg/lxsession/LXDE-pi/autostart

echo "Restart lightdm"
sudo service lightdm restart
