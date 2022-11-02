---
layout: post
title: Using Vagrant with Ubuntu Server on Windows
date: 2013-03-03
categories:
  - Software Development
permalink: /using-vagrant-with-ubuntu-server-on-windows/
thumb:
  path: /assets/posts/using-vagrant-with-ubuntu-server-on-windows/RunningVagrant.png
  alt: screenshot of Vagrant running PowerShell on Windows Server
lede:
  Recently I’ve been looking into using Vagrant to manage my virtual servers at home. I have a Windows Home Server 2011 box that manages my backups along with some virtual servers. Vagrant lets you take a base template virtual server, configure it, and spin up a new instance. As a consequence, you can spin up a new instance and guarantee the configuration of that server. Also if a friend comes over and wants his very own LAMP server to hack on, I can just spin out a new one.
---
{% include post_image.md name="RunningVagrant.png" %}

Recently I’ve been looking into using [Vagrant](http://www.vagrantup.com/) to manage my virtual servers at home. I have a Windows Home Server 2011 box that manages my backups along with some virtual servers. Vagrant lets you take a base template virtual server, configure it, and spin up a new instance. As a consequence, you can spin up a new instance and guarantee the configuration of that server. Also if a friend comes over and wants his very own LAMP server to hack on, I can just spin out a new one.

First off, let’s be clear about what we are doing. We want the ability to spin up a new instance that pulls an IP address from DHCP, so that others can use the server. You will be downloading a base template virtual machine, a configuration file from my Github account, an install script from my Github account and finally spinning up a new instance of the template machine with Apache, MySQL, and PHP installed. Let’s get started!

You’ll have to have at least two things installed. Download and install the latest version of [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](http://downloads.vagrantup.com/).
I’ll be using the following directory structure:
```shell
F:\VirtualMachines\Vagrant\Provisioners
F:\VirtualMachines\Vagrant\UbuntuTestEnvironment
```

Open up a Powershell prompt by typing “powershell” into the start menu and hitting enter. Create the two directories by typing this:
```shell
mkdir F:\VirtualMachines\Vagrant\Provisioners
mkdir F:\VirtualMachines\Vagrant\UbuntuTestEnvironment
```

{% include post_image.md name="SetupVagrantDirectory.png" %}

Change into the `UbuntuTestEnvironment` directory you created like this:
```shell
cd F:\VirtualMachines\Vagrant\UbuntuTestEnvironment`
```

Download the Vagrantfile I [created on Github](https://github.com/chrishalebarnes/VagrantFiles/blob/master/UbuntuLAMP/Vagrantfile) to the UbuntuTestEnvironment directory. If you can’t be public with these files you could always put them on a file server. We could use a browser and click the link, but what’s the fun in that? Use the Powershell like this:
```powershell
(New-Object System.Net.WebClient).DownloadFile('[http://raw.github.com/chrishalebarnes/VagrantFiles/master/UbuntuLAMP/Vagrantfile](http://raw.github.com/chrishalebarnes/VagrantFiles/master/UbuntuLAMP/Vagrantfile)',(gl).Path+'Vagrantfile')
```

A lot of folks are using Chef to manage the configuration of the new Vagrant instances, but that seemed like overkill for what I want to do at home. I’ll be using a pretty simple Bash script to install Apache, MySQL, and PHP. It’s also on Github right [here](https://github.com/chrishalebarnes/VagrantFiles/blob/master/UbuntuLAMP/Vagrant-LAMP.sh). Download it to the Provisioners directory in the same fashion like this:
```powershell
(New-Object System.Net.WebClient).DownloadFile('[http://raw.github.com/chrishalebarnes/VagrantFiles/master/UbuntuLAMP/Vagrant-LAMP.sh](http://raw.github.com/chrishalebarnes/VagrantFiles/master/UbuntuLAMP/Vagrant-LAMP.sh)',(gl).Path+'../ProvisionersVagrant-LAMP.sh')
```

Now you can spin up a new instance like this:
```shell
vagrant up
```

Woof. That is powerfully simple. If you open up VirtualBox you should see a new virtual machine is running. You are benefitting from the sane defaults that Vagrant provides. Let’s back up for a second and have a look at the files you just downloaded from my Github account. It looks like this:
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url =
    "http://files.vagrantup.com/precise64.box"
  config.vm.network :bridged
  config.vm.provision :shell,
    :path > "../Provisioners/Vagrant-LAMP.sh"
end
```

So that is the boilerplate Vagrantfile plus a few other things.

Taking each line in order:

* lucid64 is the name of the pre-packaged Vagrant box that is provided by the nice folks who make Vagrant.
* The url in config.vm.box_url is the download location. You could just as easily download the .box file and somewhere and point the url at the file location.
* The network is bridged, so that it pulls an IP address from my router. That way someone external to my Home Server can use the new instance of Ubuntu Server.
* Finally we point it at the Bash script that is located in the Provisioners directory. That script will get run after boot and will install a bunch of things that we want.

You can also have a look at the Bash script that installs everything. It does the following:

* Installs Apache
* Installs PHP
* Installs MySQL with a random password
* Spits out the IP address it pulled and the MySQL credentials to use

{% include post_image.md name="Credentials.png" %}

You can take the IP address that the script prints out to test if Apache is working. Take the IP address, open a browser, and put it in your browser’s address bar and you should see “It works!” in giant letters. Likewise, you should be able to use [MySQL Workbench](http://dev.mysql.com/downloads/workbench/) to get access to the database server or SSH into the box and use the command line client. You should also see the new server running from VirtualBox.

{% include post_image.md name="VirtualBoxVM.png" %}

Now that you have a server up and configured, you can also destroy it. From the same directory type this:
```shell
vagrant destroy
```

{% include post_image.md name="VagrantDestroy.png" %}

You can spin up new environments by creating a new directory, changing into that directory, downloading the Vagrantfile, and typing “vagrant up”. Vagrant opens up all kinds of possibilities for automating what is usually a rather tedious task. It works well on Windows, but setting up a Windows Server is still a bit rough around the edges. And now I leave you to deploy the PHP application that you are presumably spinning this server up for. Have fun!
