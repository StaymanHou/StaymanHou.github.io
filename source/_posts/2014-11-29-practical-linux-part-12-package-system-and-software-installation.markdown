---
layout: post
title: "Practical Linux - Part 12 - Package System &amp; Software Installation | 软件包系统与安装"
date: 2014-11-29 17:02:09 +0000
comments: true
categories: [Linux]
keywords: "linux, package, software, install"
---
{% youtube mk-ssB9hR_U %}
<!-- more -->
- Nov 11 - Package System & Software Installation
  - Package System
    - (off-line) - rpm & dpkg
    - (online & dependency) - yum & apt
    - rpm & yum - linux.vbird.org/linux_basic/0520rpm_and_srpm.php#intro_import2
  - dpkg
    - Why? (vs tar + make + gcc...)
      - easy to install
      - easy to upgrade
      - efficient - pre-compiled
      - track install info
  - apt
    - How?
      - repository
      - header
  - commands
    - dpkg - http://www.tecmint.com/dpkg-command-examples/
      - install `-i`
      - query
        - list `-l`
        - search `-S`
        - status `-s`
      - verify / signature `-V`
      - config `--configure`
      - remove `-r`
      - purge `-P`
    - apt - www.tecmint.com/useful-basic-commands-of-apt-get-and-apt-cache-for-package-management/
      - query
        - list `apt-cache pkgnames`
        - search `apt-cache search apache2`
        - info `apt-cache show apache2`
      - update `apt-get update`
      - upgrade `apt-get upgrade` (every package)
      - install `apt-get install apache2` (upgrade single package)
      - remove `apt-get remove apache2`
      - purge `apt-get purge apache2`
  - Which to use
    - apt > offical repo > third-party repo > dpkg > tar & make
  - Assignment
    - log on your Amazon vm
    - install curl
    - use curl to save the google home page into a new directory 'nov11'
    - uninstall the related package so that the `ping` command will not be found in the system