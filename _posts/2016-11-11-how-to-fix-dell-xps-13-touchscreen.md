---
layout: post
title: How to Fix Dell XPS 13 Touchscreen and Suspend Issues In Fedora
date: 2016-11-11
categories:
  - Technology
  - Electronics
permalink: /how-to-fix-dell-xps-13-touchscreen/
lede:
    After updating Fedora on my Dell XPS 13 Developer Edition, the suspend/resume stopped functioning. After resuming from being suspended, the laptop would immediately reboot. There had also been a long running issue where the touchscreen would not work after resuming from being suspended. The latter did not bother me that much, since I don’t feel the need to use the touchscreen all that often. The former, however, was going to be a huge issue. After a lot of digging and trying out all kinds of things, I stumbled upon something that finally worked
---
After updating [Fedora](https://getfedora.org/) on my [Dell XPS 13 Developer Edition](http://www.dell.com/us/business/p/xps-13-linux/pd), the suspend/resume stopped functioning. After resuming from being suspended, the laptop would immediately reboot. There had also been a long running issue where the touchscreen would not work after resuming from being suspended. The latter did not bother me that much, since I don’t feel the need to use the touchscreen all that often. The former, however, was going to be a huge issue. After a lot of digging and trying out all kinds of things, I stumbled upon something that finally worked. As it turns out, this also seems to have fixed the touchscreen issue as well. I’m still not entirely sure if the update fixed the touchscreen or if this kernel parameter fixed the touchscreen. I’m also still not entirely sure what this parameter actually does or if there are some drawbacks to using it. Anyway, I wanted to write this down here in case it helped someone else who has the same issue.

The fix ended up being adding a parameter to the Linux kernel via Grub. That parameter is `acpi_sleep=nonvs`

Edit `/etc/default/grub` using whatever text editor you prefer and find the line that looks like this `GRUB_CMDLINE_LINUX="rhgb quiet"`. And you’ll need `sudo`
Add `acpi_sleep=nonvs` to the end of that string so it looks something like this
```shell
GRUB_CMDLINE_LINUX="<a bunch of other parameters>; rhgb quiet acpi_sleep=nonvs pcie_aspm=force acpi_osi=Linux"
```

Now you have to update Grub. In Fedora there is no [update-grub command](http://manpages.ubuntu.com/manpages/trusty/man8/update-grub.8.html) so you have to update it like this and then reboot. You’ll also need `sudo` to run this command.
```shell
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
```

According to the [kernel parameters documentation](https://github.com/torvalds/linux/blob/master/Documentation/kernel-parameters.txt), this parameter “prevents the kernel from saving/restoring the ACPI NVS memory during suspend/hibernation and resume.”

Thanks to [this helpful thread](http://askubuntu.com/questions/24048/suspend-fails-reboot-on-resume-and-no-hibernate-option) and this other [helpful thread over here](https://ask.fedoraproject.org/en/question/80362/how-do-i-update-grub-in-fedora-23/).
