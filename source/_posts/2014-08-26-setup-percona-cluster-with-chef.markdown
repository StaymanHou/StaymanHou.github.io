---
layout: post
title: "Setup Percona Cluster with Chef"
date: 2014-08-26 02:05:08 +0000
comments: true
categories: [Chef, Percona, Ops]
keywords: "chef, percona, cluster, ops"
description: "This is a post that describes the process of setting up a percona cluster with chef"
---
During the last few month, I suffered a lot to utilize Chef. Chef is a awesome tool that automates the process of building infrastructures and helps to achieve configuration consistency among all your environment, both infrastructure and dev. This is [the home page of Chef](http://www.getchef.com/chef/)

However, it's troublesome to make it work for the first time, because both Chef and Percona are new for me. This makes the debugging procedure particularly hard, since it is not clear for me whether something's wrong in my chef setup, or the cookbook I made, or the Percona setting. I started from the usage example described in the cookbook [readme](https://github.com/phlipper/chef-percona#percona-xtradb-cluster). Crap. After struggling for a week or two, I figured out how to use it to build my own percona cluster. Here, I wanna share the usage and my very own understanding of this cookbook and Percona.

<!-- more -->
#What is Percona?

[Percona](http://www.percona.com/) is a fork of MySQL. It basically supports all the features of MySQL, with the optimized performance for InnoDB Engine. Besides, it provides cluster support. An HA(high availability) solution for MySQL. I also exploit this feature to setup a 3 nodes master-master redundant MySQL cluster.

#Install & Configure Percona

Installing and configuring Percona is easy. Follow the [instructions](http://www.percona.com/doc/percona-xtradb-cluster/5.5/howtos/ubuntu_howto.html) provided by Percona. You can also find a CentOS version of it. The install and configure procedure is pretty headless. The Percona cluster should be up and running now, if you did the steps exactly as in the instructions.

#Troubleshoot Percona

In contrast, troubleshooting percona is painful, if you do not understand what you did during the installation. The error message is horrible in general. Many time, I found myself in the position that I can't boot or reboot a node or all nodes. And can't find any reasonable error. Good news is that I've already struggled a lot before put it into production. If you encountered such problems, check the following things.

## a. `ps aux | grep mysql`

  This one is ridiculous, but remember to check it first. Sometimes you try to boot or reboot percona. And a few seconds after running the boot command, you get this message: `ERROR! The server quit without updating PID file`. If Percona hangs or crashes, chances are that some `mysql` processes will not be terminated. If this is the case, Percona will never be able to boot. Look for them. And run `kill -9 <pid>`, if there are suspicious processes.

## b. use `/etc/init.d/mysql restart-bootstrap` or `/etc/init.d/mysql bootstrap-pxc`

  If you are used to managing mysql servers, you probably always use `/etc/init.d/mysql restart` and `/etc/init.d/mysql start`. However, it's not always the practice in Percona world. Since we are implementing mysql cluster, the booting procedure of the first node is different from others. Regarding the first node of a cluster, you should always use `/etc/init.d/mysql restart-bootstrap` or `/etc/init.d/mysql bootstrap-pxc`. And use `/etc/init.d/mysql restart` and `/etc/init.d/mysql start` for the rest. Sometimes you may experience the symptom that the start procedure takes 5 ~ 10 minutes and fails. Check you `my.cnf`file. Look for the following line:

  ```
  wsrep_cluster_address=gcomm://192.168.70.61,192.168.70.62,192.168.70.63
  ```
  
  Check if any of the nodes is running percona, if not. You probably want to run `/etc/init.d/mysql restart-bootstrap` or `/etc/init.d/mysql bootstrap-pxc`. Make sure to kill all other mysql processes before do it.

## c. xtrabackup

## d. not synced

## To be continued