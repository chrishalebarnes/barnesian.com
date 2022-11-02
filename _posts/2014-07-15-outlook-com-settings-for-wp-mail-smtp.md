---
layout: post
title: Outlook.com Settings for WP Mail SMTP
date: 2014-07-15
categories:
  - Software
permalink: /outlook-com-settings-for-wp-mail-smtp/
thumb:
  path: /assets/posts/outlook-com-settings-for-wp-mail-smtp/smtp_wordpress.png
  alt: screenshot of SMTP configuration in WordPress
lede:
  After migrating this blog to WordPress I found that I needed to setup email notifications for comments and the like. I ended up using the WP Mail SMTP plugin with Outlook.com. Anyway, Here are the settings that worked for using Outlook.com as an SMTP server for WordPress notifications.
---
{% include post_image.md name="smtp_wordpress.png" %}

After migrating this blog to WordPress I found that I needed to setup email notifications for comments and the like. I ended up using the [WP Mail SMTP plugin](https://wordpress.org/plugins/wp-mail-smtp/ "WP Mail SMTP") with Outlook.com. Anyway, Here are the settings that worked for using Outlook.com as an SMTP server for WordPress notifications.

**From Email:** Any email that you own that uses Outlook.com, Live.com or Hotmail

**From name:** Any Name you want.

**Mailer:** Send all WordPress Email via SMTP

**Return Path:** Unchecked

**SMTP Host:** smtp.live.com

**SMTP Port:** 587

**Encryption:** Use TLS Encryption. This is not the same as STARTTLS. For most servers SSL is the recommended option.

**Authentication:** Yes: Use SMTP Authentication

**Username:** Your Outlook.com email including the @outlook.com, @live.com or @hotmail.com

**Password:** Your Outlook, Live or Hotmail password.

Use the “Send a Test Email” section to make sure everything works.

If you have a firewall setup (and you should), you’ll have to let that traffic out as well. If you are using Linux and iptables here are the iptables rules that allow that traffic to get out while still blocking new incoming connections on port 587.

iptables -A OUTPUT -p tcp –sport 587 -m state –state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp –dport 587 -m state –state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp –sport 587 -m state –state RELATED,ESTABLISHED -j ACCEPT

And now you’ve got WordPress using Outlook.com for all of the notifications. Rejoice!
