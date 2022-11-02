---
layout: post
title: Perfect Footers
date: 2017-02-15
categories:
  - Software Development
permalink: /perfect-footers/
thumb:
  path: /assets/posts/perfect-footers/footer.png
  alt: screenshot of a simple footer on a website
lede:
    Styling footers proves to be a bit tricky. On a site where there’s a lot of content, this is not an issue. However, if you want to have the page be full height and scroll when the content overflows, there is some subtlety to styling the footer. It’s pretty easy to accidentally have the footer float in the middle of the page when the content overflows and the page scrolls. It’s also pretty easy to have the content hide underneath the footer.
---
{% include post_image.md name="footer.png" %}

Styling footers proves to be a bit tricky. On a site where there’s a lot of content, this is not an issue. However, if you want to have the page be full height and scroll when the content overflows, there is some subtlety to styling the footer. It’s pretty easy to accidentally have the footer float in the middle of the page when the content overflows and the page scrolls. It’s also pretty easy to have the content hide underneath the footer. I am hardly the first person to write about this; this post was inspired by and slightly modified from [this blog post](http://matthewjamestaylor.com/blog/keeping-footers-at-the-bottom-of-the-page).

Here’s how to deal with that. First of all, if you don’t have a normalize and reset, you should probably do that. In the example I’ve included a quick reset of body and all of the header elements. Without that reset this won’t quite work like you might expect. The kernel of getting the page to be full height while allowing it to scroll is setting `html` to `height: 100%` and setting `body` to `min-height: 100%` and `position: relative`. With those styles, it allows the short pages to be full height, without scroll bars, and allows longer pages to scroll and keep the footer at the bottom. Finally, another important note: the main content container needs to have some padding so its content doesn’t hide underneath the footer.

A demo is worth many words; here’s a CodePen:
<iframe allowfullscreen="true" allowpaymentrequest="true" allowtransparency="true" class="cp_embed_iframe " name="cp_embed_1" scrolling="no" src="https://codepen.io/chrishalebarnes/embed/egoOoX?height=400&amp;theme-id=0&amp;slug-hash=egoOoX&amp;default-tab=result&amp;user=chrishalebarnes&amp;embed-version=2&amp;pen-title=Perfect%20Footer&amp;name=cp_embed_1" style="width: 100%; overflow:hidden; display:block;" title="Perfect Footer" loading="lazy" id="cp_embed_egoOoX" width="100%" height="400" frameborder="0"></iframe>
