---
layout: post
title: "Practical Linux - Part 07 - User/Permission System | 用户与权限系统"
date: 2014-10-15 02:08:15 +0000
comments: true
categories: [Linux]
keywords: "linux, user, permission"
---
{% youtube 19F3Qod5Kzg %}
<!-- more -->
- Oct 14 - User/Permission System
  - http://linux.vbird.org/linux_basic/0410accountmanager.php
  - Steps to setup text mode on boot: http://ubuntuhandbook.org/index.php/2014/01/boot-into-text-console-ubuntu-linux-14-04/
  - uid & gid
    - Linux knows id not name
  - /etc/passwd
    - username:password:uid:gid:description:home_dir:shell
  - /etc/shadow
    - username:hashed_password:modification_date:...
  - /etc/group
    - groupname:gpassword:gid:groupuser
    - initial group - gid in /etc/passwd
    - effective group - egid - e.g. create file
  - ACL
  - switch user
    - reasons
      - good habit
      - limit permission
      - some programs do not support root
  - user shell
    - /sbin/nologin
  - user info
    - `last`
    - `w` / `who`
    - `wall` - broadcast
  - commands
    - `users` - show
    - `useradd` - add
      - -D default value
    - `adduser` - add
    - `passwd` - modify
      - root can reset password
    - `usermod` - modify
    - `userdel` - delete
    - `groups`
    - `newgrp` - change egid
    - `groupadd`
    - `groupmod`
    - `groupdel`
    - `su -`
    - `sudo <command>`
      - interval
    - `visudo` - /etc/sudoers
  - Assignment
    - log on your amazon vm
    - create a new user 'oct14'
    - create a new group 'ftpusers'
    - add user 'oct14' into group 'ftpusers' (also keep the original group of the user)
    - switch user to root
    - use `touch` command to create a new file in /root