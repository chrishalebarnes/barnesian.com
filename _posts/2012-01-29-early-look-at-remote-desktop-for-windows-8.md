---
layout: post
title: Early Look at Remote Desktop For Windows 8
date: 2012-01-29
categories:
  - Software
permalink: /early-look-at-remote-desktop-for-windows-8/
redirect_from:
  - /2012/01/early-look-at-remote-desktop-for.html
thumb:
  path: /assets/posts/early-look-at-remote-desktop-for-windows-8/StartScreenDevPreview.png
  alt: screenshot of the Windows 8 remote desktop app
lede:
  Perhaps the only app that is bundled with the Windows 8 Developer Preview that is not only a demo of the new runtime (WinRT) is the Remote Desktop app. This is more in line with what we should see from all of the typical Windows utilities in the new Metro UI context. Instructions and screen shots for using RDC in Windows 8 are after the break.
---
{% include post_image.md name="StartScreenDevPreview.png" %}

Perhaps the only app that is bundled with the Windows 8 Developer Preview that is not only a demo of the new runtime (WinRT) is the Remote Desktop app. This is more in line with what we should see from all of the typical Windows utilities in the new Metro UI context. Instructions and screen shots for using RDC in Windows 8 are after the break.

Be sure to turn on “Network discovery” if you have not already. In the Developer Preview it was turned off by default. Find it here:

Control Panel>Network and Internet>Network and Sharing Center>Advanced sharing settings

{% include post_image.md name="NetworkDiscovery.png" %}

As per usual enter the IP address that you want to remote into.

{% include post_image.md name="MetroRemoteDesktop.png" %}

Click “Use another account” if you need to change the user name. Otherwise, enter the password and click “OK” to continue.

{% include post_image.md name="MetroRemoteDesktopCredentials.png" %}

Unless you have a real certificate, remote desktop will complain about the identity of the PC. That is ok; click connect to continue as long as you know exactly which computer you are connecting to.

{% include post_image.md name="RemoteDesktopWarning.png" %}

You are now into the remote desktop session. You may notice it is slightly different than in Windows 7. There is no bar at the top of the screen to indicate that you are in a remote session. You can Alt-Tab to get away from the session window or click and drag from the left part of the screen to bring in the next app. You can even do a half screen metro app with a remote session on the other side.

{% include post_image.md name="RemoteDesktopComplete.png" %}

Just like other parts of Windows 8, you can launch the old (un-metro) remote desktop interface. You need to know the exe name. From the start screen just type “MSTSC”

{% include post_image.md name="MSTSC.png" %}

After entering that, you will be switched to the desktop interface and the more familiar RDC app will be launched. Unfortunately if you search for “Remote Desktop,” the only app that shows up is the metro version, so you will have to know the exe name.

{% include post_image.md name="OldRemoteDesktop.png" %}

That is an early look at remote desktop from a Windows 8 machine to a Windows 7 (professional) machine. Microsoft has a few oddities to fix in Windows 8 before it goes gold. Keep in mind this is a pre-beta, developer preview. Things may (and should) change a little bit. Hopefully the search returns results a little better in the future. Over time, this tablet style interface should become second nature, but for now it seems my instincts are always wrong.

As always, share a few thoughts in the comments.
