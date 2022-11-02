---
layout: post
title: How to Access the Raspberry Pi with SSH
date: 2012-09-08
categories:
  - Software
permalink: /how-to-access-the-raspberry-pi-with-ssh/
redirect_from:
  - /2012/09/how-to-access-raspberry-pi-with-ssh.html
thumb:
  path: /assets/posts/how-to-access-the-raspberry-pi-with-ssh/RaslberryPiSSH.png
  alt: screenshot of an ssh terminal
lede:
  After following my guide about how to set up the Raspberry Pi, you still need a way to access the Raspberry Pi. My favorite way of accessing the Pi is using SSH to access the command line.
---
{% include post_image.md name="RaslberryPiSSH.png" %}

After following my guide about [how to set up the Raspberry Pi](https://www.barnesian.com/2012/09/the-aliens-guide-to-setting-up.html), you still need a way to access the [Raspberry Pi](http://amzn.to/1KSE2de). My favorite way of accessing the Pi is using SSH to access the command line.
To get SSH working in Windows you’ll need to get the [PuTTY utility found here](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Use the “Windows installer for everything except PuTTYtel” from the <a href="http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html”>download page. Install PuTTY and you can use it to SSH into the Raspberry Pi.

### Finding the Pi’s IP Address

Without a monitor to ask the Pi for its IP address, you’ll need to log into your router and see what IP address was given to the Pi. For the example I will use my Linksys e2000 as a reference. The instructions will likely be similar for your router.

* Go to your router’s IP address in the browser, which is usually 192.168.1.1, and login.

{% include post_image.md name="RouterLogin.png" %}

* On the “Basic Setup” page click on DHCP Reservations.

{% include post_image.md name="RouterConfig.png" %}

* You’ll see there is a client with the name “raspberrypi” connected on LAN. Select it and add it to the DHCP reservation list. Finally note the Pi’s IP address as we will use it to log in to the Pi. After adding the DHCP reservation the Raspberry Pi will be assigned the same IP address every time it boots.

{% include post_image.md name="RouterAddClients.png" %}

### Logging in with PuTTY

* Launch PuTTY from the Start Menu.

{% include post_image.md name="PuttyLogin.png" %}

* Enter the IP address that you wrote down earlier into the “Host Name” box. Note that the default port for SSH is 22.
* Click “Open” to start the remote session on the Raspberry Pi.
* You will be prompted to accept a security key. Click “Yes” to accept.

{% include post_image.md name="AcceptKey.png" %}

* PuTTY will then prompt you for your username. These are the default credentials:

> |||
> |---|---|
> |Username|pi|
> |Password|raspberry|

* You should now have a command prompt!

{% include post_image.md name="SuccessfulSSH.png" %}

### A Better Way to use PuTTY

* Open notepad to create a new text file.
* Write these two lines in that file:

START <PATH_TO_PUTTY> pi@<IP_ADDRESS>
EXIT

* where <IP_ADDRESS> is the IP address from the DHCP reservation earlier and <PATH_TO_PUTTY> is the path to the PuTTY exe which is usually “C:”Program Files (x86)”PuTTYputty.exe”
* Save that file to your desktop.

* Now when you double click on that file, it will launch PuTTY with your username and IP address and ask for a password. Since the Pi has a DHCP reservation, the IP address should not change.

> ### Completing the Pi Configuration

* As your new shell suggests you should type “sudo raspi-config” to complete the configuration. You will get a window like this:

> {% include post_image.md name="RaspberryPiFinishConfig.png" %}

* Use the arrow keys to navigate and enter to select an action.
* First you really should change the password to something you know, so arrow down to “change_pass” .

> {% include post_image.md name="RaspberryPiFinishConfig2.png" %}

* Hit enter to continue.

{% include post_image.md name="NewPassword.png" %}

* Enter the new password twice to reset it and hit enter to save the password.

{% include post_image.md name="PasswordSuccess.png" %}

* Hit enter to continue.
* Back at the config screen arrow down to “change_timezone” and hit enter.
* Select the right time zone here and hit enter.

{% include post_image.md name="GeographicArea.png" %}


{% include post_image.md name="TimeZone.png" %}

* Back at the config screen, arrow down to and select “boot_behavior”.
* If you plan to use the Pi with SSH like I do, select “” and hit enter.

{% include post_image.md name="Desktop.png" %}

* And finally arrow down to and select “update” to update all the packages to the latest.
  * By selecting this it will return you to the shell and download a bunch of updates.
* After the update is done it will return you to the shell.

{% include post_image.md name="ConfigDone.png" %}

That will do it! Now you can SSH into the pi with your new password and do whatever you want. If you are new to the BASH Linux shell, here are a few commands that are useful. Also don’t forget that if you type part of a command or directory the tab key will auto complete what you are trying to type.

|||
|---|---|
|**Command**|**Function**|
|sudo shutdown –r 0|Restart in 0 seconds|
|sudo apt-get update|Update all packages|
|ls|List current directory contents|
|cd|Change directories|
|pico|Edit file in a text editor|
|sudo apt-get install <APP_NAME>|Installs application <APP_NAME> from the internet repositories|
|exit|Exits the shell session|

Note that if you prepend “sudo” to any command it runs it with the highest privileges, known as root in Linux.
What’s next? That’s up to you. Maybe try to [install Webmin](http://www.raspberrypi.org/phpBB3/viewtopic.php?f=63&t=6096), for a browser based console. Or try to [install the packages for a LAMP server](http://www.raspberrypioneer.com/2012/06/12/raspberry-pi-project-3-lampi-a-raspberry-pi-based-lamp-server/) and start writing some PHP or Python code. Have fun!
