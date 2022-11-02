---
layout: post
title: How to Transfer Files to the Raspberry Pi using SFTP
date: 2012-09-08
categories:
  - Software
permalink: /how-to-transfer-files-to-the-raspberry-pi-using-sftp/
redirect_from:
  - /2012/09/how-to-transfer-files-to-raspberry-pi.html
thumb:
  path: /assets/posts/how-to-transfer-files-to-the-raspberry-pi-using-sftp/WinSCP.png
  alt: screenshot of transfering files via WinSCP
lede:
  After setting up the Raspberry Pi, you’ll likely need to transfer some files to it. Since the Pi already has an SSH server, you can use SFTP to transfer files to your user’s home directory. Read past the break to have a look at using WinSCP to transfer files.
---
{% include post_image.md name="WinSCP.png" %}

After setting up the [Raspberry Pi](http://amzn.to/1KSE2de), you’ll likely need to transfer some files to it. Since the Pi already has [an SSH server](https://www.barnesian.com/2012/09/how-to-access-raspberry-pi-with-ssh.html), you can use SFTP to transfer files to your user’s home directory. Read past the break to have a look at using [WinSCP](http://winscp.net/eng/download.php) to transfer files.

Download and install an SFTP client for Windows.[I use WinSCP which can be found here.](http://winscp.net/eng/download.php)

* After installing WinSCP, launch it from the start menu.
* Provide the Pi’s IP address in “Host name:” text box
* Enter your username in “User name:” and your password in “Password

{% include post_image.md name="WinSCPLogin.png" %}

* Similar to setting up PuTTY you will be prompted to accept a security key. Click “Yes” to accept.

{% include post_image.md name="AcceptKey1.png" %}

* You can now drag and drop files from the left pane to the right pane

{% include post_image.md name="UploadFiles.png" %}

* Upon dragging a file over to the right pane you will see this box asking where to put the file. You should be able to upload to your home directory and nowhere else. You can copy to your home directory and then move the file wherever you want with an SSH shell.

{% include post_image.md name="CopyFiles.png" %}

* Click “Copy” to complete the transfer. You can then move the file wherever you want with the [cp command](http://ss64.com/bash/cp.html) in the [SSH shell](https://www.barnesian.com/2012/09/how-to-access-raspberry-pi-with-ssh.html).

If you’ve got a LAMP server set up, you could move files into /var/www to have Apache serve the files up. You could use this to upload PHP and HTML files to write a website served by the Pi. Anyway, you’ve now got read and write access to your Pi’s file system.
