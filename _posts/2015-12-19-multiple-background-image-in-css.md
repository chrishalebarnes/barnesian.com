---
layout: post
title: 'Quick Tip: Multiple Background Images in CSS'
date: 2015-12-19
categories:
  - Software Development
permalink: /multiple-background-image-in-css/
thumb:
  path: /assets/posts/multiple-background-image-in-css/multiple-background-images.png
  alt: screenshot of CSS styles using multiple background images
lede:
    Nearly every software developer who works with front-end code has probably used the CSS property [background-image](https://developer.mozilla.org/en-US/docs/Web/CSS/background-image). What some might not know is that background-image can take many images and set how those images are positioned. This could be particularly useful if you don’t have full control over the HTML that is being generated for whatever reason.
---

Nearly every software developer who works with front-end code has probably used the CSS property [background-image](https://developer.mozilla.org/en-US/docs/Web/CSS/background-image). What some might not know is that background-image can take many images and set how those images are positioned. This could be particularly useful if you don’t have full control over the HTML that is being generated for whatever reason. You could also have multiple elements and use an [nth-of-type](https://developer.mozilla.org/en-US/docs/Web/CSS/%3Anth-of-type) selector to achieve the same effect. Here is a quick demo of how you can use the [background-image](https://developer.mozilla.org/en-US/docs/Web/CSS/background-image), [background-size](https://developer.mozilla.org/en-US/docs/Web/CSS/background-size), and [background-position](https://developer.mozilla.org/en-US/docs/Web/CSS/background-position) in concert to apply three images to a single div on top of a span of text.

HTML:
```html
<div class="box">
  <div class="icon"></div>
  <span>
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </span>
</div>
```

CSS:
```css
.box {
  margin: 20px;
  border: 1px solid black;
  padding: 20px;
  background-color: #eee;
  min-width: 430px;  /* Set a min-width, so the images don't spill outside of the container */
}

.icon {
  height: 100px;
  width: 450px;        /* Set a fixed width, so the images don't float off to the left and right */
  margin: 0 auto;      /* Center the images */
  margin-bottom: 20px; /* Push the text away by 20px */
  background-image:
    url('https://www.barnesian.com/wp-content/uploads/2015/12/ruby.png'),
    url('https://www.barnesian.com/wp-content/uploads/2015/12/php.png'),
    url('https://www.barnesian.com/wp-content/uploads/2015/12/go.png');
  background-repeat: no-repeat, no-repeat, no-repeat;
  background-size:
    100px,       /* height and width of 100px */
    auto 100px,  /* height auto and width of 100px */
    100px;       /* height and width of 100px */
  background-position: left, center, right;  /* You can also set an offset here if you need to */
}
```

Those will produce the following result:

{% include post_image.md name="multiple-background-images.png" %}

Here’s a quick demo on JSFiddle:
<iframe src="//jsfiddle.net/4h5wL5gd/embedded/result,html,css,js/" allowfullscreen="allowfullscreen" width="100%" height="300" frameborder="0"></iframe>
