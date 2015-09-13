---
layout: post
title: "Some resources worth checking out before you start a NodeJS project - Part 2"
date: 2015-09-13 00:39:29 +0000
comments: true
keywords: "nodejs, opsworks, debug, cluster, deployment"
---

[Part 1 is here]({% post_url 2015-09-07-some-resources-worth-checking-out-before-you-start-a-nodejs-project %})

It has been a week since the first post. After seeing the application running in production, I've got some more to share.

First thing is about debugging and troubleshooting. That's **evil**. As shared [here](http://www.quora.com/Why-did-Koding-switch-from-Node-js-to-Go) - "Your debugging still largely remains as guess work.". This is 100% true. And the problem got even worse in prod.

In dev phase, I've seen a lot of this kind of stack traces:
```
Trace: 
    at EventEmitter.<anonymous> (/project/src/routines/debug/exceptions.js:4:17)
    at EventEmitter.emit (events.js:88:20)
```

or this:

```
Error: Oh no! Event Error!
    at someAsyncHandler \[as _onTimeout\] (/Users/danielhood/Dev/Workspace/blab/routes/index.js:7:12)
    at Timer.listOnTimeout \[as ontimeout\] (timers.js:112:15)
```

Basically, in nodejs codebase, you will have anonymous functions and async function calls everywhere. Usually, with those error message, you don't even know which line of code is associated with the error. That sucks.

However, there's actually some solutions [here](http://www.nearform.com/nodecrunch/node-js-develop-debugging-techniques/). I wish I could read those tips before I started the project.

When the app got into prod, troubleshooting is tougher. The issue is that, usually, most app deployment will offer you a catch-all error log, either from web server (apache, nginx, etc), from app server (php-fpm, passenger, etc), or from the framework (CackPHP, Rails, etc). NodeJS, in contrast, has nothing out-of-box. The app process will simply die when an error occurs. Thus, from nowhere you can attain the error log. NewRelic couldn't do that as well.

And actually, that's why I like Ruby, and Rails. Even you are a newbie, you probably won't make the app too messed up. By simply choosing the framework, you got covered for many pitfalls you would encounter in the future, even though you might not be aware of. For example, CSRF protection, assets caching, etc.

OK, here comes the second issue. NodeJS, by default, runs in single process single thread mode. Other languages and frameworks are the same actually. The difference is that, when you deploy a non-nodejs app, the web server or app server usually spawn and manage multiple processes/threads for you. But with nodejs, you have no process manager by default. Therefore, you will need to spawn processes by yourself to utilize multiple cpu cores. This function is implemented in [cluster](https://nodejs.org/api/cluster.html). You will also need a process manager to oversee your application, and restart them when one fails. You have got several choices here, [nodemon](https://github.com/remy/nodemon), [pm2](https://github.com/Unitech/pm2), and [forever](https://github.com/foreverjs/forever).

As a result, I encountered a third problem in prod. In my app, I primarily have a bunch of background workers. I used [AWS OpsWorks](https://aws.amazon.com/opsworks/) to configure the NodeJS layer. Ever since I launched the app, I saw more and more tasks got stuck in my task queue with active status. Since I had no error log, nor I can find anything in NewRelic, it was a totally guess work.

At first, I thought it was becaused of uncaught exceptions. Spent a whole day refactoring all the code, try to wrap any suspects code that could throw error, and add error logs wherever essential.

The second day, the task queue is still stuck. Then I thought, ok, maybe the tasks actually got proceeded well, but the redis machine which stores the task queue got overloaded. Since, there are several thousands tasks get proceeded every 10 minutes. Therefore, I tried stopping all non-essential tasks. Unfortunately, that didn't help.

Maybe somewhere in the code, especially in async functions, throws error and I didn't wrap it? I third throught. And I got no idea how could I verify or test the hypo.

And Finially, the third day, I though, maybe the worker process got terminate/restarted in the middle of a task. I found [this post](https://forums.aws.amazon.com/thread.jspa?threadID=129654). OpsWorks actually ping port 80 every minute as health check for nodejs layer. And because my workers do not listen on port 80, it was considered unhealthy and got restarted every minute. AWS really should mention that in their starter's guide. At the end, I added a health check for workers listening on port 80. The issue got resolved, and I could take a rest.

Hope this post and part 1, could help some people that are planning to write app in node or deploy nodejs in AWS with opsworks.
