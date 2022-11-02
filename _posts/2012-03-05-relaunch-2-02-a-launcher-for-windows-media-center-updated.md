---
layout: post
title: 'Relaunch 2.02: A Launcher for Windows Media Center (Updated) '
date: 2012-03-05
categories:
  - Software
permalink: /relaunch-2-02-a-launcher-for-windows-media-center-updated/
redirect_from:
  - /2012/03/relaunch-20-launcher-for-windows-media.html
thumb:
  path: /assets/posts/relaunch-2-02-a-launcher-for-windows-media-center-updated/Relaunch2.png
  alt: screenshot of the Relaunch application running
lede:
  Relaunch is a 2 foot UI utility to add a new tile to the Extras Library of Windows Media Center. It requires the .net framework 4.x. It is a portable app and does not require installation. All it really does is write an autoit script, and an MCL file for you using this method. Note that it does not change Media Center in any way. If you go delete the files, the tiles you created will go away. If you used Relaunch 1.x to add tiles, be careful to read my note at the end of this post.
---
{% include post_image.md name="Relaunch2.png" %}

Relaunch is a 2 foot UI utility to add a new tile to the Extras Library of Windows Media Center. It requires the [.net framework 4.x](http://www.microsoft.com/net). It is a portable app and does not require installation. All it really does is write an autoit script, and an MCL file for you using [this method](http://www.techlifeweb.com/2011/02/02/how-to-build-your-own-app-launcher-for-windows-media-center/). Note that it does not change Media Center in any way. If you go delete the files, the tiles you created will go away. If you used Relaunch 1.x to add tiles, be careful to read my note at the end of this post.
[Download](https://github.com/chrishalebarnes/Relaunch/releases/download/v2.03/Relaunch203.exe) and [Github Page](https://github.com/chrishalebarnes/Relaunch)

It has been a while since I first released [Relaunch 1.0](http://www.barnesian.com/2011/05/relaunch-launcher-for-windows-media.html) and I have learned a lot in the process of updating it, including hearing some feedback from people who are using it. Admittedly Relaunch 1.0 should have been 0.1, but nonetheless I am sticking with it and naming this 2.0. Besides, [what’s in a version number anyway?](http://www.codinghorror.com/blog/2007/02/whats-in-a-version-number-anyway.html)
The new version will read in the apps you currently have configured and allow you to delete them. It also adds a list of [known 10 foot UI websites](http://www.barnesian.com/2012/01/10-foot-ui-webapps-for-your-htpc.html). If you choose a pre-configured web app, then Relaunch will automatically use an embedded image for the thumbnail in Media Center. You can choose the Custom option if you would rather roll your own tile.

* “Current Tiles” lists all of the tiles that you have created with Relaunch by reading the MCL file in C:Users\\AppDataRoamingMedia Center Programs
* “App to Launch” specifies whether you want to use a built in application to launch from media center or a “Custom” application where you specify the path or URL to launch
* “Trigger” specifies how media center is relaunched
  * Green Button will close the app you launched whenever Media Center comes into focus, aka when you hit the green button
  * Close App will launch Media Center when the application you launched exits
* “Add” will add the tile to media center with the URL, name and image you specify or by choosing one of the built in options
* “Remove” will delete whatever tile you added previously if it is selected in the “Current Tiles” list
* the “Fullscreen” checkbox specifies whether you want the browser you have chosen to run without the window chrome, like tabs and menus. The option will disappear if it is a “Program” and not a browser.

**Note:**There is a major difference between Relaunch 1.x and 2.0 that **requires you to delete the tiles made with 1.x and re-add them with Relaunch 2.0**. This is because the path to where Relaunch stores its files has changed. To remove the Relaunch 1.x tiles you have to delete 3 files. There is an MCL file in

> *“ C:Users\\AppDataRoamingMedia Center Programs”*

and there is an exe and image file **per** each tile in

> *“C:UsersPublicDocumentsRelaunch”*

If you used any version of Relaunch 1.x please delete the files it generated in those two directories.
With Relaunch 2.0 it stores the MCL in the same spot

> *“C:Users\\AppDataRoamingMedia Center Programs”*

and it now stores the exe and image files in

> *“C:Users\\AppDataLocalRelaunch”*

Here are the download links:
[Download](https://github.com/chrishalebarnes/Relaunch/releases/download/v2.03/Relaunch203.exe) and the code is up on [Github](https://github.com/chrishalebarnes/Relaunch)
