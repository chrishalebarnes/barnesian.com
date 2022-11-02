---
layout: post
title: Fastmail Settings for WP Mail SMTP
date: 2020-03-25
categories:
  - Software
permalink: /fastmail-settings-for-wp-mail-smtp/
thumb:
  path: /assets/posts/fastmail-settings-for-wp-mail-smtp/fastmail-panel.png
  alt: screenshot of admin panel of SMTP plugin for WordPress
lede:
  After having migrated my mail provider from Outlook.com to Fastmail I needed to get the contact form up and running for WordPress. The Fastmail settings are plainly available and located over here https://www.fastmail.com/help/clients/defineimap.html.
---
{% include post_image.md name="fastmail-panel.png" %}

After having migrated my mail provider from [Outlook.com](https://outlook.com/) to [Fastmail](https://www.fastmail.com/) I needed to get the contact form up and running for [WordPress](https://wordpress.org). The Fastmail settings are [plainly available and located over here](https://www.fastmail.com/help/clients/defineimap.html).
```
SMTP Host: smtp.fastmail.com
Encryption: SSL
SMTP Port: 465
Auto TLS: On
Authentication: On
SMTP Username: your primary email address
SMTP Password: <your password, use at your own risk, it’s better to use WordPress variables for this>
```

While your primary password may work, it’s better to create a unique password per application using Fastmail. This password can be revoked easily if something goes wrong. In Fastmail, under `Settings -> Password & Security` you’ll see there is a section called App Passwords. Generate a new password here and put these two variables into `wp-config.php`
```php
define('WPMS_ON', true);
define('WPMS_SMTP_PASS', 'your per application password');
```
Use the “Send a Test Email” section to make sure everything works.

If you have a firewall setup (and you should), you’ll have to let that traffic out as well. If you are using Linux and iptables here are the iptables rules that allow that traffic to get out while still blocking new incoming connections on port 465. Note these must be run with `sudo`
```shell
iptables -A OUTPUT -p tcp –sport 465 -m state –state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp –dport 465 -m state –state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp –sport 465 -m state –state RELATED,ESTABLISHED -j ACCEPT
```
And now you’ve got WordPress using Fastmail for all of the notifications. Enjoy
