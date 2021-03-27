# Node.js

Javascript is a language that allows you to create interactive elements for a website and so it usually runs in a browser.
Node.js lets you run javascript outside your browser.
The node package manager `npm` lets you install Node.js programs from a repository.
Once you are set up, you can do all kinds of things; listen to network traffic, building utilities, building web-applications etc.

- [Installation](#installation)
- [Getting started](#getting-started)
- [Modules](#modules)
- [References](#references)

## Installation

Two ways, either `sudo apt install nodejs` or use the `nvm` tool.
Below I use `nvm`.

Note that with `npm`, most of what you install is project specific and lives in its own directory.

Use the [node version manager](https://github.com/nvm-sh/nvm):
```
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.37.2/install.sh | bash
```

To download, compile and install latest node:

```
$ nvm install node
v15.12.0 is already installed.
Now using node v15.12.0 (npm v7.6.3)
$ nvm use node
Now using node v15.12.0 (npm v7.6.3)
```

To see all the possible versions you can use:

```
nvm ls-remote
```

You now have node.js and npm.

```
$ node -v
$ npm -v
```

## Getting started 

Create and populate a `package.json` file by running `npm init` (see `npm help json` for detailed help) and following the prompts.
You can run a Node.js command prompt by typing `node` or you can create a javascript file `index.js` that contains: 

```javascript
console.log("This is a first test")
```

and run it with:

```sh
$ node index.js
This is a first test
```

## Modules

You can import the code from other scripts (either your own or from `npm`) by using the `require` directive.
To install from `npm` and include in the `package.json` file:

```sh
$ npm install underscore --save
$ cat package.json
{
  "name": "testing",
  "version": "1.0.0",
  "description": "A test",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "underscore": "^1.12.1"
  }
}
```

Now include it in `index.js` with:

```javascript
var myunder = require('underscore');
// print out methods from underscore module:
console.log(myunder);
```

If you want to create your own modules, you need to export the functionality of interest by doing:

```javascript
var a = 1;
module.exports.a = a;
```

import with 

```javascript
var m = require('./mymodule');
m.a;
```

## References

+ https://stackoverflow.com/questions/35062852/npm-vs-bower-vs-browserify-vs-gulp-vs-grunt-vs-webpack
