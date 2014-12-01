---
layout: post
title: "Practical Linux - Part 19 - Final | 期终"
date: 2014-11-29 17:02:11 +0000
comments: true
categories: [Linux]
keywords: "linux, final"
---
- Dec 9 - Final
  - Project
    - e.g. http://ec2-54-69-36-110.us-west-2.compute.amazonaws.com:3001/
    - make an nodejs express app running on your Amazon vm.
      - node process must be running as a deamon.
      - listen on the default 3000 port. (port 3002 ~ 3009 will be forwarded to your the 3000 port of you vm)
      - the home page should have content "Welcome to Express"
    - Hints & References
      - nodejs (the engin) - http://nodejs.org/
      - you may want to use nvm (the node version manager) - https://github.com/creationix/nvm
      - you may want to use npm (the package manager) - https://www.npmjs.org/
      - express (the web framework) - http://expressjs.com/
      - you may want to use forever (the daemonizer) - https://www.npmjs.org/package/forever