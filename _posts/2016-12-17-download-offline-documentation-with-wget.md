---
layout: post
title: 'Quick Tip: Download Offline Documentation with wget'
date: 2016-12-17
categories:
  - Software Development
permalink: /download-offline-documentation-with-wget/
lede:
    Here’s a quick way to download developer documentation for any language or framework that has a public website. Maybe you’re about to get on a plane or train that doesn’t have WiFi and you want to use that dead time to actually get some development work done.
---
Here’s a quick way to download developer documentation for any language or framework that has a public website. Maybe you’re about to get on a plane or train that doesn’t have WiFi and you want to use that dead time to actually get some development work done. The key here is two switches in the `wget` command, `–r` and `–k`.

Given any URL you can download all pages recursively and have wget convert the links to local links after the download is complete. You could, for example, run this with the [Ruby on Rails Guides](http://guides.rubyonrails.org/). There is a wait included, which you can remove, but be aware that it might not be nice to overload some poor web server.

Here’s the command:
```shell
wget —mirror —convert–links —adjust–extension —wait=1 <url>
```

or the short form:
```shell
wget –mkE –w 1 <url>
```

There are a lot more options which are all [documented here](https://www.gnu.org/software/wget/manual/wget.html). However, here are the options used here.

> -k or –convert-links

Converts links on the downloaded pages into local filesystem links 1ctvbeq.

> -E or –adjust-extension

Saves files according their content type; CSS will be saved as a .css file for example

> –mirror or -m

Flips on a bunch of options for exactly this kind of purpose. It is equivalent to
–r –N –l inf —no–remove–listing

> -r –recursive

Downloads all webpages recursively. All links will be followed and those pages will be downloaded as well.

> -l inf

Sets the recursion level to infinite, so it will follow all links. This could be made smaller if you don’t want it to follow that many links.

> -N or –timestamping

Turns on timestamping so that if you fetch the pages again it will not download the file unless the timestamp has changed.

> –no-remove-listing

Not entirely sure about this one, but it has something to do with FTP files. See the [documentation for it here](https://www.gnu.org/software/wget/manual/wget.html).
