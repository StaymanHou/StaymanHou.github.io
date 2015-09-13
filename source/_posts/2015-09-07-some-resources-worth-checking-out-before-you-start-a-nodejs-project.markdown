---
layout: post
title: "Some resources worth checking out before you start a NodeJS project - Part 1"
date: 2015-09-07 00:18:46 +0000
comments: true
keywords: "nodejs, dynamodb, cloudsearch, natural language process"
---
[Part 2 is here]({% post_url 2015-09-13-some-resources-worth-checking-out-before-you-start-a-nodejs-project-part-2 %})

Last week I rushed through a nodejs project. It's my first nodejs project that launched in production. Learned a lot about nodejs and got a deeper grasp about it. Wanna share about my experience and my understanding so far in this post. I'm also gonna list a bunch of resources that I went through and feel worth reading.

First of all, to get started with JavaScript, I'd recommend read the book [JavaScript: The Definitive Guide](http://www.amazon.com/JavaScript-Definitive-Guide-David-Flanagan/dp/0596000480). I think it can both serve as a beginner tutorial and a advanced guide. It basically covers everything about the language. From lex, syntax, to the underlying concept and mechanism. I, indeed, agree that JS is a horribly designed language. It's easy to start writing some functioning program without a good understanding. However, it's quite tricky for beginners to comprehend how the language actually works. This book even worths reading a second time. Propably write a good amount of JS code before start the second read.

Ready to dive deeper into this language? Go to this book: [Node.js Design Patterns](http://www.barnesandnoble.com/p/nodejs-design-patterns-mario-casciaro/1120828744/2672148860235?st=PLA&sid=BNB_DRS_Marketplace+Shopping+Books_00000000&2sid=Google_&sourceId=PLGoP2715&k_clickid=3x2715&kpid=2672148860235). It covers the culture and philosophy of the community behind the language. It also clears out some very essential ideas that people need to deal with in practical tasks. For example, callback pattern, sync vs async, and etc. I'd say this language is very against human nature. Although good design patterns (even in other languages) often requires developer to go a little wicky wacky, NodeJS requires you to think in a totally oppesite way. If you code in a straight forward manner, I bet it will become a mess in 100 lines.

The very first thing you want to avoid is the **Callback Hell**. It will simply make your code unreadable and unmanagable. Try every means to avoid that. I made several callback hells at the beginning of the project. Ended up with hours and hours of work to refactor those.

The second thing is async vs sync. You will see callbacks everywhere if you write in JS. However, you usually cannot tell which one is sync and which one is async. At least, I couldn't tell. At the beginning, I though all the functions that need to pass a callback are async functions. That's simply not true. One reason that drove me to use Node for this project is performance. The problem is that if you are not utilizing asycn functions, you loss the benefit of using the language. So watch out for that.

All right. There's still some good thing about Node.

First, [nvm - node version manager](https://github.com/creationix/nvm) and [npm - node package manager](https://www.npmjs.com/). If you come from Ruby world, those are your old friends. They are life savers. Delivers you from **Dependency Hell**. Need to mention, it's recommended install nvm and npm as a non-root user, your app don't need that previlege. Avoid install packages with the `-g` switch. Include your `./npm/bin` in your `$PATH` instead.

Next, there are a lot of packages available in npm. I believe the amount is much greater than gems in Ruby.(Checkout yourself). Gems are rich in the webapp field, espacially Rails + RDBMS. However, looks like npm packages covers everything. For this project, I need to handle natural language processing. Couldn't find much gems. I had quite a good time struggle whether to choose Ruby or Node.

A list of popular npm packages - https://www.npmjs.com/browse/star. I almost covered over half of them in this project.

Web frameworks - [express](https://github.com/strongloop/express), [restify](https://github.com/restify/node-restify), [hapi](https://github.com/hapijs/hapi), [sails](https://github.com/balderdashy/sails) and [loopback](https://github.com/strongloop/loopback). For my project, the frontend is pretty simple. So I chose Express. **Rails** is still my favorate, though.

A list of natural language processing pachages. There are more not listed here. This is awesome.
* [wordnet.js](https://github.com/spencermountain/wordnet.js)
* [moby](https://github.com/zeke/moby)
* [pos](https://github.com/dariusk/pos-js)
* [natural](https://github.com/NaturalNode/natural)
* [gingerbread](https://github.com/RobinvdVleuten/gingerbread)

Pretty much that's it for now. Wish I could write more if I have got some time. Hope you enjoy the post.
