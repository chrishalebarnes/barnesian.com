---
layout: post
title: The Alien’s Guide to Setting Up a Raspberry Pi
date: 2012-09-08
categories:
  - Software Development
permalink: /the-aliens-guide-to-setting-up-a-raspberry-pi/
redirect_from:
  - /2012/09/the-aliens-guide-to-setting-up.html
thumb:
  path: /assets/posts/the-aliens-guide-to-setting-up-a-raspberry-pi/RaspberryPi.jpg
  alt: picture of a Raspberry Pi
lede:
  The Raspberry Pi is a small Linux computer that has captured the imagination of the hardware hacking community. If you’ve decided to jump in, this guide will help you get started with the device using Windows 7. The Raspberry Pi boots off of an SD card. The operating system we will use is Rasbian “wheezy” which is provided by RasberryPi.org. That’s a funny title, isn’t it? My intention is to provide a guide that an alien could use to set up a Raspberry Pi. Most guides assume some prior knowledge of computing including this one, but hopefully anyone can follow this and get up and running with the Raspberry Pi.
---
{% include post_image.md name="RaspberryPi.jpg" %}

The [Raspberry Pi](http://amzn.to/1KSE2de) is a small Linux computer that has captured the imagination of the hardware hacking community. If you’ve decided to jump in, this guide will help you get started with the device using Windows 7. The Raspberry Pi boots off of an SD card. The operating system we will use is Rasbian “wheezy” which is provided by [RasberryPi.org](http://www.rasberrypi.org/). That’s a funny title, isn’t it? My intention is to provide a guide that an alien could use to set up a Raspberry Pi. Most guides assume some prior knowledge of computing including this one, but hopefully anyone can follow this and get up and running with the Raspberry Pi.

### Insert the SD Card

* Insert the SD card into the computer – you might use a [USB card reader](http://www.amazon.com/gp/product/B000YBH4YU/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=B000YBH4YU&linkCode=as2&tag=then00-20) if your computer doesn’t have an SD card reader. You should be prompted with the screen below. You don’t need to open the folder; instead, note the drive letter that the SD card was assigned and write it down as we will use this later. In my example it is E: If you are prompted to format the SD card choose FAT32. You can close this by hitting the X in the upper right corner.

{% include post_image.md name="SDPrompt.png" %}

### Download and Unzip Raspian

* Head over to [raspberrypi.org](http://www.raspberrypi.org/downloads) and [download the latest Rasbian “wheezy”](http://www.raspberrypi.org/downloads)
* Also download the [Win32DiskImager](http://www.softpedia.com/get/CD-DVD-Tools/Data-CD-DVD-Burning/Win32-Disk-Imager.shtml)

  * Note that by default the files should download to *C:Users<USER_NAME>Downloads*
* Open File Explorer (search for “explorer” in the start menu) and click on “Downloads” in “Favorites” in the upper left corner

{% include post_image.md name="DownloadsFolder.png" %}

* Right click on on the wheezy Raspbian file and click “Extract All…”

{% include post_image.md name="ExtractAll.png" %}

* Uncheck the box next to “Show extracted files when complete”
* Click on “Extract”

{% include post_image.md name="ExtractFiles.png" %}

* Right click on wind32diskimager file and click “Extract All…”

{% include post_image.md name="ExtractAll22.png" %}

* Check the box next to “Show extracted files when complete” and click “Extract”

{% include post_image.md name="ExtractFiles22.png" %}

### Writing the Image to the SD Card

* Now double click on ‘Win32DiskImager” and accept the UAC prompt by clicking “Yes”

{% include post_image.md name="ExeToChoose.png" %}

* Add the Raspian img file using the blue file folder icon

{% include post_image.md name="Win32DiskImager.png" %}

* Under “Device” choose the drive letter that you wrote down earlier in the first step. Again, for this example the drive letter was E:

{% include post_image.md name="Win32DiskImagerDriveToChoose.png" %}

* Finally, click “Write”

{% include post_image.md name="Win32DiskImagerClickWrite.png" %}

* You may get a scary warning, but this should be ok as long as you have the right drive letter. Click “Yes”

{% include post_image.md name="DismissWarning.png" %}

* Wait for the Progress bar to finish

{% include post_image.md name="ImageIsBurning.png" %}

* When it’s done it will prompt you. Click “OK” to continue.

{% include post_image.md name="WriteSuccessful.png" %}

* And feel free to click “Exit” on Win32DiskImager

{% include post_image.md name="ExitWin32DiskImager.png" %}

* Remove or eject the SD card from the computer. You now have an SD card that has the operating system, Raspbian.

### Connecting the Raspberry Pi and booting into Rasbian

* Put the SD card into the Raspberry Pi

{% include post_image.md name="RaspberryPiConnect1.jpg" %}


{% include post_image.md name="RaspberryPiConnect2.jpg" %}

* Plug in the power connector for the Raspberry Pi. The other end of the power connector can be plugged into the wall or into the USB port of the computer depending on the connector. As soon as you plug in the power connector the Pi will boot from the SD card

{% include post_image.md name="RaspberryPiConnect3.jpg" %}


{% include post_image.md name="RaspberryPiConnect4.jpg" %}

* Plug in the Ethernet cable into the Raspberry Pi. The other end of the Ethernet cable plugs into your router.

{% include post_image.md name="RaspberryPiConnect5.jpg" %}


{% include post_image.md name="RaspberryPiConnect6.jpg" %}

You should now have a Raspberry Pi that can boot into Raspbian. You won’t see any display quite yet, but you could connect a monitor to the HDMI or yellow RCA connector. The username is pi and the password is raspberry. You can also follow my [guide on connecting to the Pi remotely using ssh](https://www.barnesian.com/2012/09/how-to-access-raspberry-pi-with-ssh.html). Happy hacking!
