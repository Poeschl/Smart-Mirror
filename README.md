# Smart Mirror

This contains the code I use for running a Smart Mirror.
Its basically a kiosk chromium browser running on boot.

## Install

The install script is assuming an Raspberian image with desktop packages and the user `pi`.
If this requirement is met, execute the `install.sh` script.

It will disable the screensaver as well as hiding the mouse on idle.
Chromium will be inserted as autostart application.

## Configuration

To configure the page the browser is starting change the `START_URL` parameter in the `run.sh` script in the `pi` user folder.
