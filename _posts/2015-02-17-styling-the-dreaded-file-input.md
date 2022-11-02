---
layout: post
title: Styling the Dreaded File Input
date: 2015-02-17
categories:
  - Software Development
permalink: /styling-the-dreaded-file-input/
thumb:
  path: /assets/posts/styling-the-dreaded-file-input/file-input-featured.png
  alt: screenshot of a file input that is styled
lede:
    Styling a file input turns out to be quite difficult since CSS can’t reach into the control to get access to the elements.
---
{% include post_image.md name="file-input-featured.png" %}

Styling a file input turns out to be quite difficult since CSS can’t reach into the control to get access to the elements.

This HTML
```html
<input type=“file”></input>
```

renders to this control

{% include post_image.md name="file-input.png" %}

See how there is both a button and a label? That’s what makes things difficult. To style the elements, you have to replace them and style the replacements.
```html
<div class=“file-upload”>
    <input type=“file” />
    <button>Browse</button>
    <label>No File</label>
</div>
```

Set the opacity to 0 and have the file input overlay on top of the button and label. When it’s clicked, the file input is actually being clicked even though it’s transparent.
```css
.file–upload {
  white–space: nowrap;
}

.file–upload > input[type=“file”] {
  opacity: 0;            /* Set this to 0.2 and background-color: red to see how it overlays */
  width: 10em;           /* Enough width to cover the button and the label */
}

.file–upload button {
  margin–left: –10.3em;  /* move the button left to overlay the transparent file input */
  padding: 1em 1.5em 1em 1.3em;
  color: #fff;
  background: #008cba;
  border–width: 0;
  transition: background–color 300ms ease–out;
}

.file–upload button:hover {
  background–color: #0078a0;
}
```

Here, the opacity of the file input is set to 0.2 and the background-color is red. See how it overlays the button and label?

{% include post_image.md name="file-input-overlay.png" %}

When a file is added the element has a value of “C:\fakepath\somefilename.txt”, so you have to remove that and replace the value of the adjacent label with the file name. To get the label to update with the file name, you need this JavaScript (with JQuery).
```js
$('.file-upload input[type=”file”]').change(function() {
  var label = $(this).parent().find('label');
  if($(this).val() === '') {
      label.text('No File');
  } else {
      label.text($(this).val().replace('C:\\fakepath\\',''));
  }
});
```
Here’s a demo on [JSFiddle](https://jsfiddle.net/j4tf1yuq/):
