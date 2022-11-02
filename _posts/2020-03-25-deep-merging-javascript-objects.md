---
layout: post
title: Deep Merging JavaScript Objects
date: 2020-03-25
categories:
  - Software Development
permalink: /deep-merging-javascript-objects/
thumb:
  path: /assets/posts/deep-merging-javascript-objects/merge-objects-code.png
  alt: screenshot of code that deep merges JavaScript objects
lede:
  Deep merging objects in JavaScript is a bit tricky. Here’s one solution; there are many many others. While this was fun to write, you’ll probably want to go use the merge function in lodash instead. None the less here’s some code golf
---
{% include post_image.md name="merge-objects-code.png" %}

Deep merging objects in JavaScript is a bit tricky. Here’s one solution; there are many many others. While this was fun to write, you’ll probably want to go [use the merge function in lodash instead](https://lodash.com/docs#merge). None the less here’s some code golf

```js
function merge(...sources) {
  return sources.reduce((target, source) => {  // enumerate the sources
    return Object.entries(source).reduce((result, [key, value]) => {  // enumerate the properties
      if(Array.isArray(value)) {
        if(Array.isArray(result[key])) {
          result[key] = result[key].concat(value); // got two arrays, merge them
        } else {
          result[key] = value;  // clobber it, either undefined or not an array
        }
      } else if(value === Object(value)) {
        if(result[key] === Object(result[key])) {
          result[key] = merge(result[key], value); // two objects, recurse and merge them
        } else {
          result[key] = merge(value); // recurse and clobber it, either undefined or not an object
        }
      } else {
        result[key] = value;  // must be a primitive, clobber it
      }
      return result;
    }, target);
  }, {});
}
```
