---
layout: post
title:  Work Around ISP Blocking Ports for Windows Home Server 2011
date:   2012-01-13
categories:
  - Software
permalink: /work-around-isp-blocking-ports-for-windows-home-server-2011/
redirect_from:
  - /2012/01/work-around-isp-blocking-ports-for.html
thumb:
  path: /assets/posts/work-around-isp-blocking-ports-for-windows-home-server-2011/HomeServerLoginScreen.png
  alt: screenshot of the Windows Home Server login screen
lede:
  Windows Home Server offers you remote access to all of your files, that is, if your ISP lets you run a server on ports 80, 443 and 4125. Not every home ISP allows you to run inbound traffic on those ports. Luckily you can work around this by redirecting traffic from the outside internet to your internal network. Before you do anything call your ISP and ask them if they will open up those three ports. Many times they will oblige and you can save yourself a headache. If that does not work and it is not against your terms of service, then there is a way to semi-elegantly work around the blocked ports.
---
{% include post_image.md name="HomeServerLoginScreen.png" %}

Windows Home Server offers you remote access to all of your files, that is, if your ISP lets you run a server on ports 80, 443 and 4125. Not every home ISP allows you to run inbound traffic on those ports. Luckily you can work around this by redirecting traffic from the outside internet to your internal network. Before you do anything call your ISP and ask them if they will open up those three ports. Many times they will oblige and you can save yourself a headache. If that does not work and it is not against your terms of service, then there is a way to semi-elegantly work around the blocked ports.

**Disclaimer: I am not responsible or liable if you break your ISP’s terms of service by working around their port blocking. Perform these instructions at your own risk. Call your ISP if you are uncertain.**
First the domain needs to be set up to point at your home router’s IP address. Microsoft gives WHS 2011 users an out and offers to give you a subdomain like DomainName.homeserver.com. It should also handle the IP address of your router switching, so there is no need to set up a static IP address with your ISP. Next, the router is configured to forward a port that is not blocked by your ISP and forward it to your internal networks port 80, 443 and 4125. Lastly, a subdomain of your own can be set up if you have an existing website similar to mine, or a domain name that you want to use specifically for your home server. Geekier stock can take that to the bank, but for everyone else I have screen by screen instructions below.

{% include post_image.md name="HomeServerDashboard.png" %}

Launch the Dashboard and click “Server settings” on the right

{% include post_image.md name="RemoteWebAccess.png" %}

Click “Remote Web Access” on the left pane. Under the “Domain name” section click “Set up”

{% include post_image.md name="GettingStartedDomainName.png" %}

Click “Next” to get started.

{% include post_image.md name="KindOfDomainName.png" %}

Select the “Get a personalized domain name from Microsoft” to get a SubDomain.homeserver.com style domain name. Of course you could set up your own domain as long as your ISP will give you a static ISP. Microsoft will handle the changing of your IP address through the homeserver.com domain. When your IP changes, the homeserver.com domain will adjust on the fly and you will still be able to get to your home server.

{% include post_image.md name="NewDomain.png" %}

Select “I want to set up a new domain name” and click next to continue.

{% include post_image.md name="SignIntoWindowsLive.png" %}

Sign into your Windows Live account and click next.

{% include post_image.md name="NewDomainSetup.png" %}

Select a (sub) domain name and click “Check availability” to see if it is taken already. Finally click “Set up” to complete the registration.

{% include post_image.md name="DomainNameProgress.png" %}

Wait while Microsoft registers a domain on your behalf.
{% include post_image.md name="DomainIsSetup.png" %}

Success! Click “Close” to continue. If your ISP does not block ports then you would be done here. For many of us, continue on!

{% include post_image.md name="RouterLogin.png" %}

You’ll need to configure your router to forward the correct ports. Make sure you either turn off UPNP in the router or choose not to set up the router in the wizard under “Server settings” By not letting WHS set up the router automatically, we can set the ports to forward to the right spot manually. One more caveat here: If you do not disable remote access to your router from outside of your home network, your SubDomain.homeserver.com will point to your router’s admin page. You might not want to expose that to the public internet without a strong password. You have been warned! Either sure up your password or disable WAN side administration.

{% include post_image.md name="RouterPortForwarding.png" %}

I will use my Linksys E2000 as an example. You need to get a port that is not blocked to forward to port 443 over the TCP protocol. That is the bare minimum to get any remote access at all. In this example I am forwarding 4430 to 443 over TCP. So we have the unblocked port 4430 from the outside internet redirecting to port 443 of the IP address of your home server on your internal network. That is it for https access only; you may wish to forward these ports as well:

* Port 443 is https (encrypted, secure)
* Port 80 is http (unencrypted)
* Port 4125 is WHS remote web desktop access

Remote web access should now work if you point your browser to [https://SubDomain.homeserver.com:4430/remote](https://subdomain.homeserver.com:4330/remote) If you are ok pointing your browser to that ugly URL then you are all done. You should have remote access to the web interface of your home server. If that is not quite good enough you can set up a redirect from a domain you already have, like I do with barnesian. I use Google Apps with Go Daddy, but these general steps should work with any domain name provider. You can set up a nice domain like SubDomain.barnesian.com which forwards to that ugly URL above.

{% include post_image.md name="GoDaddyDomainManager.png" %}

Log into your domain registrar’s dashboard and select your domain.

{% include post_image.md name="GoDaddySubDomain.png" %}

Select “Manage” to set up the subdomain.

{% include post_image.md name="SubdomainForward.png" %}

If you forwarded port 4430 to port 443 then you can set up the subdomain to point to that ugly URL we used earlier.
That is all! You can then go to SubDomain.YourDomain.com and you will be forwarded to your Windows Home Server’s web log in screen. All IP address switching should be handled by Microsoft and you have successfully routed around the port blocking. Enjoy!
**Disclaimer: I am not responsible or liable if you break your ISP’s terms of service by working around their port blocking. Perform these instructions at your own risk. Call your ISP if you are uncertain.**
Join me in the comments if you have any questions!
