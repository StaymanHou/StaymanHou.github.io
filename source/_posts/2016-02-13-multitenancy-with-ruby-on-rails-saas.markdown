---
layout: post
title: "Multitenancy with Ruby on Rails (SaaS, Subdomain, and Account) - Intro, Resources, and Benchmark"
date: 2016-02-13 15:11:54 +0000
comments: true
categories: [Ruby on Rails, Multitenancy]
keywords: "ruby on rails, multitenancy, saas, subdomain, apartment, acts_as_tenant, milia"
---

Have been building several multitenant applications, mostly SaaS applications, as well as giving advice to application builders. Wanna shares some thoughts resources on this topic. I also want this to be a short ultimate getting started page if you are just about to build a Rails multitenant application or an application that creates a seperate subdomain for each user / account.

<!-- more -->

I'll share the resources and benchmark first. Then I'll talk a little bit more about my journey.

#First of all, what is a multitenant application?

You can check out the Wiki's definition [here](https://en.wikipedia.org/wiki/Multitenancy). Roughly speaking, it's an application that shares a single software, while each tenant has its own dedicated resources. 

#What are the architecture models for multitenancy?

Check out [this great talk](https://www.youtube.com/watch?v=DMP0leGZpo4) by Matt Tavis. Generally speaking, the problem lays here - what will be shared, and what will not be.

##Legacy

Only share the same codebase. Provision separate servers and resources for each tenant. The version that is deployed on individual tenant may also be different from each other. This is the most straightforward approach. No extra dev effort will be required.

*Use case*: Tenants require the software to be deployed on their on-premise environments

*Problems*: When you get over a dozen of tenants, it will be hard to manage all the environments. Releasing new versions will be a headache. It will also be wasting quite an amount of computing resources.

##Containerize

This is pretty much the same as the one above. Only that this approach uses container technology to minimize the footprint of each tenant application. That means codebase and hardware are shared across tenants.

*Use case*: Optimize footprint of a legacy app with little change. Develop a new app and do not want to put the multitenancy logic in the app code (avoid this use case if possible).

*Problems*: Docker adds an additional layer in your solution stack. Change management.

##Shared Service

Codebase and all resources are shared across tenants. Mostly only one version is live. The application needs to handle the logic of distinguishing tenant of each request.

*Use case*: Whenever possible, primarily new applications

#Multitenancy for Rails

I'm assuming are starting a new application. Therefore, we will talk about the shared service model for you multitenancy rails app.

Here is a great talk about the topic - https://youtu.be/OaiQ7Piogmk

And here is a great book - https://leanpub.com/multi-tenancy-rails-2

Basically, here is a list of things need to be considered to compose your multi-tenant strategy:
* tenant controllers - how the current tenant will be determined
* data models - how the data are separated in database(s)

##Tenant Controllers

There are three ways to determine the current tenant:
* Domain/subdomain based - each domain/subdomain is associated with a tenant. e.g. tenant1.myapp.com/tenant1.com
* URL based - each URL prefix is associated with a tenant. e.g. myapp.com/tenant1
* Login/session based - each session user/account is associated with a tenant. e.g. myapp.com (login as tenant1)

There's not much different between these approaches in regard to operation side.

In Rails, you also need to set current_tenant/current_account in the appropriate controllers. Same as Devise set `current_user` so that it will available in controllers and views. In addition, `current_tenant` should be automatically used as a scope when querying model data.

##Dat Models

There are three strategies to separate the data:
* Separate DB - Data are stored in different databases for each tenant. e.g. db_host: tenant1.db.localdomain
* Separate Schema - Data are stored in a different schema for each tenant. e.g. db_database: tenant1_myapp
* Shared Schema - Data are stored in a shared schema for all tenants. e.g. (almost) all table will have a `tenant_id` foreign key field

In my opinion, always share everything whenever possible, or unless you have a good reason to separate them.

###Separate DB

Cons
* Resource & connection overhead
* Creating new account requires creating new database
* Caching layer
* Not transparent to Rails

###Separate Schema

Pros
* Transparent to Rails

Cons
* Some resource overhead
* Creating new account requires creating a new schema. Database user requires the privilege to create/drop schemas
* Rails migrations need to be changed

###Shared Schema

Pros
* Low resource overhead
* Native to Rails
* Creating new account requires nothing special
* Simple to aggregate/share data across tenants

Cons
* Requires extra work for large data sets

#Multitenancy Gems

I have the habit of checking [the ruby toolbox](https://www.ruby-toolbox.com/) for available gems that implement the desired functionalities out of the box. It would be hard to believe that there's no gem handling multitenancy. And [here](https://www.ruby-toolbox.com/categories/Multitenancy) are the gems. The top 3 are: `Apartment`, `ActsAsTenant, and `Milia`. All of them are still being maintained though each takes a different approach.

##[apartment](https://github.com/influitive/apartment)

`apartment` takes the separate schema approach. It has several built-in tenant controllers (called elevators in `apartment`, which is kind of vivid), including subdomain, domain. It may require extra configuration to handle database schemas, migrations, database user privileges, background job. This gem assumes that all the models belong to a tenant by default. You will need to explicitly declare that models that are public/global/shared.

##[acts_as_tenant](https://github.com/ErwinM/acts_as_tenant)

`acts_as_tenant` takes the shared schema approach. It also has several built-in tenant controllers including account, domain and, subdomain. This gem assumes all the models are public/global/shared, and requires you to declare the models that should act as tenant

##[milia](https://github.com/dsaronin/milia)

Compared to the previous two gems, which address the multitenancy problem in general, `milia` is more specified in its solution. It is also shared schema model. It does not have built-in tenant controllers, but should be pretty simple to setup one yourself. It assumes you will have tenants (organizations) and users (members) belonging to organizations. It also assumes that you will use `devise` for authentication, which is basically the default for rails. It's a little tricky to get started because of its documentation and the fact that it has `devise` integration built-in. However, if this is what you are exactly looking for, I'd say go for it.

#My Multitenancy Journey with Rails

All right, time to share some stories.

The very first multitenancy application I encountered was an advertising platform. Built from scratch with Rails. I was not aware of the term multitenancy at that moment. Went through the standard data modeling. Basically, all the models belong to the user model. After launch, I shortly got new request that we need to implement account. That led to a major migration. All the models need to belong to a new account model. And there's a many-to-many relationship between user and account. The project ended up using the shared schema model. Wrote a few helpers to set/switch the tenant. It's roughly our own implement of milia. And it's less DRY.

Later one of my friends asked me about how to build a SaaS eLearning platform with subdomains for each account. I spent hours to do the research, only to find that people say Rails is not strong in handling subdomains. The primary reason is that I didn't know the keyword - multitenancy. I have no idea why I believed that result. There are tons of SaaS application using subdomains. There must be some gem.

My next multitenancy app is a landing page CMS. I learned about the term, multitenancy, shortly before we started the project. In short, tenants can create their own landing page. They can also monitor the performance, run A/B test, and so on. We used `apartment` gem with its domain elevator. Development went OK. However, things got tricky on the operation side when the number of tenants grew. It takes longer to run the migrations. Also had some small issues setting up tests. Database backup and recovery is also more time consuming.

Then, I worked on a blogging platform. The highlight is that in this platform, tenants can share the same post. We used `acts_as_tenant` gem with its built-in subdomain tenant controller. I totally have no complain about the gem. Everything worked out perfectly. Just wanna mention that the post model does not act as tenant. It's a global model.

As a conclusion, I think the multitenancy solutions are pretty matured for Rails. And my recommended principal is share everything whenever possible.
