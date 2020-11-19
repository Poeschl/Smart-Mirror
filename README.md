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

## Screen rotation

To change the screen rotation according to your setup edit the file `/boot/config.txt` and insert one of the below lines at the end.

```bash
display_rotate=0 # default rotation
display_rotate=1 # 90° rotation
display_rotate=2 # 180° rotation
display_rotate=3 # 270° rotation
```

After a restart the orientation should be correct.
