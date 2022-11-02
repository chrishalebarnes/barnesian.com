---
layout: post
title: IE8 Specific CSS Hack
date: 2014-10-22
categories:
  - Software Development
permalink: /ie8-specific-css-hack/
thumb:
  path: /assets/posts/ie8-specific-css-hack/ie8hack_feat.png
  alt: screenshot of this IE8 hack working
lede:
  Here is a quick hack that could be useful depending upon the context. :root is a pseudo selector that selects the root element on the page. That’s almost always the <html> element. That’s not what’s interesting though. The :root pseudo selector is only supported in IE9 and up, which means you can use it to target browsers less than IE9. Do note that, it only targets less than IE9, so you can’t target IE7 or IE6 specifically. As an example here is a square div that is green in IE9 and up, but is red in IE8 and lower. Test it out with the IE developer tools by changing the browser’s rendering engine.
---
{% include post_image.md name="ie8hack_feat.png" %}

Here is a quick hack that could be useful depending upon the context. :root is a pseudo selector that selects the root element on the page. That’s almost always the <html> element. That’s not what’s interesting though. The :root pseudo selector is only supported in IE9 and up, which means you can use it to target browsers less than IE9. Do note that, it only targets less than IE9, so you can’t target IE7 or IE6 specifically. As an example here is a square div that is green in IE9 and up, but is red in IE8 and lower. Test it out with the IE developer tools by changing the browser’s rendering engine.
```css
/* IE8 and Under */
.square {
    height: 5em;
    width: 5em;
    background–color: red;
}

/* IE9+ */
:root .square {
    height: 5em;
    width: 5em;
    background–color: green;
}
```

will style a div like this:
```html
<div class=“square”></div>
```
[Here is a quick demo.](http://barnesian.com/demos/ie8hack.html) Try to toggle IE8 mode in the dev tools and it should switch from green to red.
