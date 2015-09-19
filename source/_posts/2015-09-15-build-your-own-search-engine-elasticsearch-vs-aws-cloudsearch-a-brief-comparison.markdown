---
layout: post
title: "Build your own Search Engine - ElasticSearch, AWS CloudSearch and Sphinx - A brief comparison"
date: 2015-09-15 01:45:47 +0000
comments: true
keywords: "search engine, elasticsearch, aws cloudsearch, sphinx, multiple language, korean"
---

Recently, I've built two search engines, 1) NodeJS + CloudSearch, and 2) Rails + ElasticSearch. And have a third work in progress, which utilizes Sphinx. For the third one, I'm only working on the ops part. I think these are the most popular options for search engine. I'm going to share a few thoughts here. Also briefly mention Solr here, I didn't try that, but it looks pretty good for heavy workload.

All right. First of all, why even bother building a search engine? Take a look at this [post](https://lucidworks.com/blog/full-text-search-engines-vs-dbms/). In short, nature language processing (NLP), informatioin retrieval (IR), and search engine are very complex. How complex is it? Go to [this course](https://www.coursera.org/course/textretrieval) to learn more if you wish. You need something specialized for that. While relational database also offers full text search feature now, that's still not their forcus. It's not optimized for performance nor capable of processing complicated text search query. On the other side, specialized search engine will have many features built in, as well as, be able to extent or customize feature & behaviour via configuration and plugins. The only thing you loss by using a search engine is the ability to join tables. That could be big depending on your use case.

## ElasticSearch

Quite staight forward to setup via chef cookbook. Ansible playbook is also available. It's fairly easy to scale, but certainly CloudSearch is the most simple to setup, manage and scale since it's a fully managed service. It's open source. That means the cost is lower than CloudSearch. Get started in a few minutes.

Another good thing about ES is that the ecosystem is rich, you have a variety of plugins for different languages, and features. For example, for Chinese alone, there're five analyzers. There are also plug n play gems for Ruby on Rails. I used [Searchkick](https://github.com/ankane/searchkick). Perfect integration with ActiveRecord, and worked with ORM that implements ActiveModel interfaces. Super easy to use.

## AWS CloudSearch

It's fully managed. That means there's no need for you to figure out how to configure the service, no need to worry about operation/maintenance, and no need to think about scalability. Besides, it has certain intergration with other AWS services, S3 and DynamoDB, to be specific. Fairly simple for ops.

However, the ecosystem is not quite matured yet. Can not find any easy to use node package. Have some gems for ruby, but looks like not fully developed yet.

## Sphinx

I didn't have many experience for this yet. Spent a few hours trying to install it via Chef, but end up unsuccessful by far. That make me fell that ES has a better user experience, at least good to get started.

Sphinx itself doesn't take care of data store actually, most likely you will still need setup MySQL/postgresql/Percona as its data store. That means you will need to manage two layers in order to use it. That also implies that it won't scale very well for huge amount of data.

Despite of those, it's still pretty good for dev. Gems available for Rails - [Thinking Sphinx](https://github.com/pat/thinking-sphinx). Similar with Searchkick. Plug n play.

In addition, it can directly talk to MySQL (and other RDBMS). That makes it a little easier to import the documents if you have some existing data already.

## One note about multi language

Regarding multi language support, I had a hard time make it even work properly in ES. Didn't try it for CloudSearch. The trouble first started when someone created a document with certain Korean keywords, while searching those keywords returns nothing.

First thing came in my mind is encoding/charset issue. However, it turns out that's not the case, everything is indeed encoded in utf. And the charset is same.

Later, after some research and asking a Korean speaker, I realize that Korean char has two presentations. Composed & Decomposed. There's a gem [Gimchi](https://github.com/junegunn/gimchi) for that. You will understand that after looking at the Gimchi example.

What I end up with doing is using unicode lib to compose every string before put it into database. And compose all the search query as well.

However, I'm still expecting for issues once more languages get inputed into the system. And ultimately, I'll separate all the languages, cuz each language requires separate processer to achieve optimized search result.
