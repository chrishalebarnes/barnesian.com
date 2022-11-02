---
layout: post
title:  Bandwidth Limiting Workaround for Stuttering Netflix in Windows Media Center
date:   2011-08-21
categories:
  - Technology
permalink: /bandwidth-limiting-workaround-for-stuttering-netflix-in-windows-media-center/
redirect_from:
  - /2011/08/bandwidth-limiting-workaround-for.html
thumb:
  path: /assets/posts/bandwidth-limiting-workaround-for-stuttering-netflix-in-windows-media-center/wmc.png
  alt: screenshot of Netflix button in Windows Media Center
lede:
  If you are experiencing stuttering and video tearing due to your home theater PC not being able to decode Silverlight, Netflix has unintentionally done you a favor recently. As they note here on the Netflix blog they added a bandwidth management section to their website. That section has also come out to the U.S. In doing so they unintentionally offered a workaround for the fact that Silverlight is not GPU accelerated and chokes on many Atom HTPCs during HD playback.
---
{% include post_image.md alt="Netflix on WMC homescreen" name="wmc.png" %}

If you are experiencing stuttering and video tearing due to your home theater PC not being able to decode Silverlight, Netflix has unintentionally done you a favor recently. As they note here on the [Netflix blog](https://blog.netflix.com/2011/03/netflix-lowers-data-usage-by-23-for.html) they added a bandwidth management section to their website. That section has also come out to the U.S. In doing so they unintentionally offered a workaround for the fact that Silverlight is not GPU accelerated and chokes on many Atom HTPCs during HD playback.

*   Go to [http://www.netflix.com/](http://www.netflix.com/)
*   In the upper right click “Your Account & Help”
*   About halfway down the page you will see this

{% include post_image.md alt="netflix menu" name="netflixmenu1.png" %}

*   Click on “Manage Video Quality” and you will see this page

{% include post_image.md alt="Netflix menu 2" name="netflixmenu2.png" %}

*   Select a different bandwidth and click save. “Better Quality” worked with my dual core atom HTPC.
*   Be sure to click “Save”!
*   Dance.

One last tip. If that did not work or for some reason you need to temporarily change the bitrate you can do so with a hidden menu in Media Center.

*   Start playing whatever you wanted to watch, but was stuttering
*   Hold Alt-Shift and left click anywhere in the middle of the picture

{% include post_image.md alt="Diagnostic Netflix Menu 1" name="netflixmenu3.png" %}

*   Select “Stream Manager” from the drop down list.

{% include post_image.md alt="Diagnostic Netflix Menu 2" name="netflixmenu4.png" %}

*   Check the box that says “Manual Selection”
*   Select a new Buffering Rate, 1500 was the best that worked with my dual core Atom PC
*   Click “Apply”
*   Rewind the video or seek anywhere to get it to rebuffer. As long as you see this screen, then it should rebuffer with the changed bitrate

{% include post_image.md alt="Netflix Loading" name="netflixmenu5.png" %}

*   Dance, because you are done.

Both of these methods should work to cure the GPU acceleration Silverlight blues. That said, you will not be watching in HD, but you will be watching. Hit me up in the comments if that did or did not work for you!




