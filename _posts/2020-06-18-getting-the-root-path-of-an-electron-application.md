---
layout: post
title: Getting The Root Path of an Electron Application
date: 2020-06-18
categories:
  - Software Development
permalink: /getting-the-root-path-of-an-electron-application/
thumb:
  path: /assets/posts/getting-the-root-path-of-an-electron-application/rootPath.png
  alt: Some code resolving the root path of an Electron application
lede:
  If you wound up here somehow, you are no doubt confused about how to get the root directory of an Electron app. It’s surprisingly complicated depending on the environmental setup. The path works a little differently in development mode than it does in a fully packaged application in an asar archive. If you’re having trouble, make sure you test both scenarios.
---
If you wound up here somehow, you are no doubt confused about how to get the root directory of an Electron app. It’s surprisingly complicated depending on the environmental setup. The path works a little differently in development mode than it does in a fully packaged application in an [asar archive](https://github.com/electron/asar). If you’re having trouble, make sure you test both scenarios.

There’s an [API that was added at some point that does exactly this](https://www.electronjs.org/docs/api/app#appgetapppath). Unfortunately, that won’t work in the renderer process. If you’re in the background process, then that should work just fine. Also worth noting, if you’re doing file access and dealing with paths, you probably \*\* should \*\* be in the background process. Take a minute to think about that and whether or not you should refactor to make that a reality. There’s also another way to get at this, as suggested by [this StackOverflow post](https://stackoverflow.com/questions/37213696/how-can-i-get-the-path-that-the-application-is-running-with-typescript).

```js
require('electron').remote.app.getAppPath();
```

For whatever reason, perhaps an outdated Electron version, that did not work when I tried it. There’s a surprisingly simple solution to this. If you’re using a bundler, this may be a little different.

Here’s the trick that works no matter what. Put a file at the root of the application, called `rootPath.js` and return `__dirname`. [__dirname in Node](https://nodejs.org/docs/latest/api/globals.html#globals_dirname) is the directory of the currently executing file. Since it is at the root, this will always give you the root path.

```js
export default function rootPath() {
  return __dirname;
}
```

Import it however you usually import things, and call it and you’ll get the root path.

```js
import rootPath from 'rootPath';
import path from 'path';
//or
const rootPath = require('rootPath');
const path = require('path');

const somePath = path.resolve(`${rootPath()}/some/path/to/something`);
```

That’s it! After some hand wringing, that works all the time, everywhere, no matter what. Undoubtedly, it won’t work for someone, and we’ll hear from them in the comments.
