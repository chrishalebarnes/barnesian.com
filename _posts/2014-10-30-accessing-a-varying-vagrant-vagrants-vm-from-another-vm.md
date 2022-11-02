---
layout: post
title: Accessing a Varying Vagrant Vagrants VM From Another VM
date: 2014-10-30
categories:
  - Software Development
permalink: /accessing-a-varying-vagrant-vagrants-vm-from-another-vm/
thumb:
  path: /assets/posts/accessing-a-varying-vagrant-vagrants-vm-from-another-vm/wordpress-in-ie8.png
  alt: screenshot of WordPress running in IE8
lede:
  For the uninitiated, Varying Vagrant Vagrants is a project that builds a virtual machine running WordPress by using Vagrant. It configures a virtual machine with Nginx and serves up a few different versions of WordPress. Unrelatedly, Microsoft provides virtual machines] for testing various versions of Internet Explorer.
---
{% include post_image.md name="wordpress-in-ie8.png" %}

For the uninitiated, [Varying Vagrant Vagrants](https://github.com/Varying-Vagrant-Vagrants/VVV "Varying Vagrant Vagrants Github Repo") is a project that builds a virtual machine running [WordPress](https://wordpress.org/ "Wordpress Homepage") by using [Vagrant](https://www.vagrantup.com/ "Vagrant Homepage"). It configures a virtual machine with [Nginx](http://nginx.org/ "nginx homepage") and serves up a few different versions of WordPress. Unrelatedly, Microsoft provides[virtual machines](https://www.modern.ie/en-us/virtualization-tools#downloads "Downloads Page for IE Virtual Machines") for testing various versions of Internet Explorer. I needed to test something in IE8, so [vagrant up,](https://docs.vagrantup.com/v2/getting-started/index.html "Vagrant Up Documentation") fire up the IE virtual machine, apologize to the memory of your laptop and away we go! It turns out the way Nginx is configured doesn’t make it easy to access the server from another machine on the same host. Varying Vagrant Vagrants will automatically update the hosts file on your local machine, but of course it cannot do this for another virtual machine you fire up. It turns out that, to access the server from one of the IE virtual machines, you need to add a few entries to the Windows hosts file on the IE virtual machine.

The Windows hosts file is located at `C:\Windows\System32\drivers\etc\hosts` and needs to be opened up as an Administrator. Assuming the Vagrant box has an IP address of 192.168.50.4, which is the default, the hosts file should have these lines added to it.

```shell
192.168.50.4 vvv
192.168.50.4 vvv.dev
192.168.50.4 local.wordpress.dev
192.168.50.4 local.wordpress-trunk.dev
192.168.50.4 src.wordpress-develop.dev
192.168.50.4 build.wordpress-develop.dev
```
