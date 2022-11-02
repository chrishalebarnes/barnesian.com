---
layout: post
title:  'Relaunch 1.X: A Launcher for Windows Media Center (Updated)'
date:   2011-05-09
categories:
  - Software
permalink: /relaunch-1-x-a-launcher-for-windows-media-center-updated/
redirect_from:
  - /2011/05/relaunch-launcher-for-windows-media.html
thumb:
  path: /assets/posts/relaunch-1-x-a-launcher-for-windows-media-center-updated/relaunch150.png
  alt: screenshot of Relaunch running
lede:
  Relaunch is a little utility that will add a tile to the Extras Library in Windows Media Center. The .net Framework 4.x is required. Also let’s be clear, this is my first .net app. When Hulu Desktop came out there was a launcher written. There is a launcher for boxee. I got tired of the individual launchers and decided to write a universal one.
---

{% include post_image.md name="relaunch150.png" %}

## [Relaunch 2.0](https://www.barnesian.com/relaunch-2-02-a-launcher-for-windows-media-center-updated/) has been released. Find it [here](http://www.barnesian.com/2012/03/relaunch-20-launcher-for-windows-media.html).

Relaunch is a little utility that will add a tile to the Extras Library in Windows Media Center. It can be [downloaded here](https://github.com/chrishalebarnes/Relaunch/releases/download/v2.03/Relaunch203.exe) and the [source is here](https://github.com/chrishalebarnes/Relaunch). The .net Framework 4.x is required. Also let’s be clear, this is my first .net app. When Hulu Desktop came out there was a launcher written. There is a launcher for boxee. I got tired of the individual launchers and decided to write a universal one.

Relaunch will add any program to Extras. When launched from extras Media Center minimizes and waits for that program to close. It does so by using [this method](http://techlifeweb.com/how-to-build-your-own-app-launcher-for-windows-media-center/). It makes a little executable using an [AutoIt](http://www.autoitscript.com/site/autoit/) script in the Public Documents folder. It adds a mcl file to the folder in local app data as [described here](http://www.hack7mc.com/2009/01/adding-apps-to-extras-library-easy-way.html). You can use any one of the browsers for webapps or choose program for any generic Windows program. The browsers will open in kiosk or fullscreen mode. Past the break there are a few images that you can use. If you find it useful, let me know! I’d love to get a little feedback to improve the utility. This is also my first attempt at c#, visual studio, and .net, so I am sure there is much to learn.
[Download](https://github.com/chrishalebarnes/Relaunch/releases/download/v2.03/Relaunch203.exe) and [Github Page](https://github.com/chrishalebarnes/Relaunch)

**Update**: Relaunch creates 3 files. An MCL file, an exe file and it copies the image. If you wish to delete or remove an extras tile that was created with Relaunch, delete these files and restart media center. The exe and image files are located in “C:UsersPublicDocumentsRelaunch” and the MCL file is located in “C:Users\*USERNAME\*AppDataRoamingMedia Center Programs” I hope to add an easier way to do this at some point.

**Update:**I added the ability to close the application by launching media center with the green button in version 1.5. There is a new drop down where you can specify the green button to close the app and relaunch media center or wait for the app to close to relaunch media center. The picture has also been updated to reflect the changes.

{% include post_image.md name="clicker.jpg" %}


{% include post_image.md name="espn3.jpg" %}


{% include post_image.md name="hulu.jpg" %}


{% include post_image.md name="youtube.jpg" %}
