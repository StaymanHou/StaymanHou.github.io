---
layout: post
title: "DevOps Bootcamp 2015"
date: 2015-06-08 23:56:40 +0000
comments: true
categories: [DevOps, Version Control, Git, Vagrant, Docker, Automated Deployment, Fabric, Capistrano, CI, CD, Continuous Integration, Continuous Delivery, Jenkins, Configuration Management, Ansible, Chef, Continuous Monitoring]
keywords: "devops, version control, git, vagrant, docker, automated deployment, fabric, capistrano, ci, cd, continuous integration, continuous delivery, jenkins, configuration management, ansible, chef, continuous monitoring"
---
This is a collection of all of my videos tutorials and materials in my DevOps Bootcamp 2015
<!-- more -->
# DevOps Bootcamp - [Playlist with all the videos](https://www.youtube.com/watch?v=Rd1Y1yXn6Bk&list=PLFizdQFdhI4MxHbwThKW7Z1-u1h5bi_Ao)

* Apr 13 - Introduction
  * General course information - Title, Attendant, Grading, Book, Lecture & Practice
  * DevOps What & Why
    * Background
    * Overview
  * Syllabus
  * Final
  * _Forgot to record video_
* Apr 15 - Bash
  * DevOps & This course
  * http://www.tutorialspoint.com/codingground.htm
  * http://www.freeos.com/guides/lsst/
  * http://tldp.org/LDP/abs/html/exercises.html
{% youtube Rd1Y1yXn6Bk %}
* Apr 20 - Python
  * https://docs.python.org/2/tutorial/
  * python exercises - http://www.codecademy.com/tracks/python
{% youtube dfDLg90ilo %}
* Apr 22 - Ruby
  * http://www.tutorialspoint.com/ruby/index.htm
  * ruby exercises - http://www.codecademy.com/en/tracks/ruby
{% youtube iNFzwMSwBIE %}
* Apr 27 - Version Control - Git
  * http://git-scm.com/doc
  * branching 
    * https://www.atlassian.com/git/tutorials/comparing-workflows
    * http://nvie.com/posts/a-successful-git-branching-model/
  * git exercises - http://gitimmersion.com/
  * prepare vagrant & docker
    * virtualbox - https://www.virtualbox.org/wiki/Downloads
    * vagrant - http://docs.vagrantup.com/v2/installation/
    * vagrant box
      * https://cloud-images.ubuntu.com/vagrant/trusty/20150427/trusty-server-cloudimg-amd64-vagrant-disk1.box
      * https://cloud-images.ubuntu.com/vagrant/trusty/20150427/trusty-server-cloudimg-i386-vagrant-disk1.box
    * aws account
{% youtube iHY4smuMcnE %}
* Apr 29 - Manage Environments - Vagrant & Docker
  * Vagrant
    * http://docs.vagrantup.com/v2/getting-started/
  * Docker
    * CoreOS
    * guide - https://docs.docker.com/userguide/
      * https://github.com/docker-library/docs/tree/master/mysql
      * https://github.com/docker-library/docs/tree/master/wordpress
    * try it - https://www.docker.com/tryit/
{% youtube bM3b4e94T6Y %}
* May 4 - Automated Deployment - Fabric
  * https://github.com/StaymanHou/2015-dev-ops-sample-application
  * http://www.fabfile.org/
{% youtube kKzlWb4Ccz0 %}
* May 6 - Automated Deployment - Capistrano
  * capistrano - http://capistranorb.com/
  * sample rails app - https://github.com/StaymanHou/dev-ops-rails-sample-application
  * rvm - https://rvm.io/rvm/install
  * rvm & passenger - https://rvm.io/integration/passenger
  * ubuntu passenger nginx init.d script - https://gist.github.com/hisea/1548664
  * security group,key pair,iam
{% youtube jPHIVHVmVs8 %}
* May 11 - Continuous Integration - Git & Jenkins
  * recall git branching strategy - https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
  * CI - http://www.slideshare.net/drluckyspin/continuous-integration
  * http://www.thoughtworks.com/continuous-integration
  * https://getcomposer.org/
  * https://phpunit.de/
  * https://jenkins-ci.org/
  * _Forgot to record video_
* May 13 - Continuous Delivery - Jenkins
  * http://www.slideshare.net/wakaleo/automated-acceptance-testing-and-continuous-delivery
  * DB migration
  * https://phinx.org/
  * https://wiki.jenkins-ci.org/display/JENKINS/Build+Pipeline+Plugin
  * https://wiki.jenkins-ci.org/display/JENKINS/Delivery+Pipeline+Plugin
{% youtube D_MCcgmMigo %}
* May 18 - Configuration Management - Ansible
  * http://www.slideshare.net/danilop/infrastructure-as-code-manage-your-architecture-with-git
  * http://www.slideshare.net/johnthethird/ansible-presentation-24942953
  * http://docs.ansible.com/index.html
{% youtube ODZ4K0oJojc %}
* May 20 - Configuration Management - Ansible (Cont.)
  * https://galaxy.ansible.com/
  * https://github.com/ansible/ansible-examples/tree/master/lamp_simple
  * https://github.com/StaymanHou/2015-dev-ops-sample-ansible
{% youtube qXnZhdrhd_M %}
* May 27 - Configuration Management - Chef
  * https://learn.chef.io
  * http://docs.chef.io
{% youtube AaPjO-3jcxI %}
* Jun 1 - Configuration Management - Chef - ChefDK, Test Kitchen, ChefSpec & ServerSpec
  * Chef basic review - http://i.ytimg.com/vi/2BCNpHNZzy8/maxresdefault.jpg
  * ChefDK - https://downloads.chef.io/chef-dk/
  * Test Kitchen - http://kitchen.ci/
  * Test Kitchen Drivers
    * EC2 - https://github.com/test-kitchen/kitchen-ec2
    * Vagrant - https://github.com/test-kitchen/kitchen-vagrant
    * Docker - https://github.com/portertech/kitchen-docker
  * ServerSpec - http://serverspec.org/
    * http://kitchen-ci.org/docs/getting-started/writing-server-test
{% youtube plGIuYBWdj8 %}
* Jun 3 - Final Project Overview & Chef (Cont.?)
  * ChefSpec - https://github.com/sethvargo/chefspec
    * Knife Spec - https://github.com/sethvargo/knife-spec
  * antipatterns - http://www.slideshare.net/JulianDunn/beginner-chef-antipatterns
{% youtube aNshyQAlKFk %}
* Jun 8 - Continuous Monitoring & Trouble Shooting - Collectd / StatsD / Graphite / DataDog / NewRelic / ELK Stack
  * Collectd
    * https://collectd.org/
    * https://collectd.org/wiki/index.php/Table_of_Plugins
    * https://github.com/coderanger/chef-collectd
  * StatsD
    * https://github.com/etsy/statsd
    * https://github.com/domnikl/statsd-php
    * https://github.com/Shopify/statsd-instrument
    * https://github.com/tim-group/java-statsd-client
    * https://github.com/librato/statsd-cookbook
  * Graphite
    * http://graphite.wikidot.com/high-level-diagram
    * http://graphite.wikidot.com/screen-shots
    * https://github.com/hw-cookbooks/graphite
  * DataDog
    * https://www.datadoghq.com/
  * NewRelic
    * http://newrelic.com/application-monitoring
  * ELK
    * https://www.elastic.co/products
    * loggly / papertrail / splunk
  * _No video record
* Jun 15 - Final & Review
  * https://github.com/showcases/devops-tools
* Final Project Requirement
  * dev environment - Vagrant / Docker
  * 2 web nodes
  * 1 db node
  * 1 Git server / GitHub / BitBucket / etc
  * 1 Jenkins server + Fabric / Capistrano + Chef workstation / Ansible workstation
  * 1 Chef server (Optional)
  * Automated Deployment
  * CI / CD pipeline
  * Configuration Management
  * 10 min presentation
* Final Project Bonus
  * Extract app DB info from the application code
  * Application programming language is not PHP
  * Jenkins authentication setup
  * Jenkins pretty test report
  * UI test / Lint test / Static analysis / etc...
  * Blue green deployment
  * Ansible Dynamic Inventory
  * Utilize Chef
  * Monitoring stack