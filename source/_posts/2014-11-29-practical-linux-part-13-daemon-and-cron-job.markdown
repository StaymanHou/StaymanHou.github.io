---
layout: post
title: "Practical Linux - Part 13 - Daemon &amp; Cron Job | 守护进程与计划作业"
date: 2014-11-29 17:02:10 +0000
comments: true
categories: [Linux]
keywords: "linux, daemon, cron"
---
{% youtube _faatbUJidU %}
<!-- more -->
- Nov 13 - Daemon & Cron Job
  - linux.vbird.org/linux_basic/0560daemons.php
  - linux.vbird.org/linux_basic/0430cron.php
  - Daemon
    - What?
      - Deamon - A Process of Some Service
    - Category
      - Signal-control
      - Interval-control
    - Naming
      - xxxxd
    - Service & Port
      - `cat /etc/services`
    - Start & Config
      - `/etc/init.d/*`
      - `/etc/sysconfig/*` | `/etc/default/*`
      - `/etc/<service>d.conf`, `/etc/<service>d.d/*`
      - `/var/lib/*` - data
      - `/var/run/*` - pid file
      - e.g.
        - `/etc/init.d/crond start`
        - `service crond start`
        - (status, stop, restart)
      - `update-rc.d`
  - Cron/Crontab
    - What?
      - time-based job scheduler
    - `atd` & `crond`
    - e.g.
      - `logrotate`
      - `locate`
    - `atd` - linux.vbird.org/linux_basic/0430cron.php
    - `crond`
    - `crontab [-u username] [-l|-e|-r]`
  - Assgnment
    - Log on your Amazon vm
    - Install cron
    - make sure the cron deamon is running
    - create a cron job that runs `touch nov13` every 5 minutes on Tuesday & Thursday - make sure it creates the file
    - stop crond