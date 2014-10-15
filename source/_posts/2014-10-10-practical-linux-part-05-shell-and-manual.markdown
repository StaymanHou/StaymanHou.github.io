---
layout: post
title: "Practical Linux - Part 05 - Shell &amp; Manual | Shell与帮助手册"
date: 2014-10-10 20:45:10 +0000
comments: true
categories: [Linux]
keywords: "linux, shell, man, manual"
---
{% youtube H0WFxVD6BM0 %}
<!-- more -->
- Oct 7 - Shell & Manual
  - Shell
    - Bash
      - Commands
        - `command [-options] [--options] parameter1 parameter2...`
        - whitespace in command
        - `Enter` to execute
        - `\` to escape newline
        - case sensitive
      - Indicator
        - [username@hostname workingpath]identity
          - workingpath: ~ = home
          - identity = $ | #
      - Examples
        - ls -al ~
        - ls        -al ~
        - ls -a -l ~
        - date
        - Date
        - DATE
        - date +%Y/%m/%d 
        - date +%H:%M
      - Shortcuts
        - `tab`
        - `Ctrl-c`
        - `Ctrl-d`
  - Man (Manual)
    - How many available command? `ls -l /usr/bin | wc -l`
    - `man`
    - Example: `man date`
      - man page code man7.org/linux/man-pages/man7/man-pages.7.html
      - navigation:
        - space | up | down | page up | page down | home | end
      - searching:
        -  `/date` | `?date` | n | N
      - quit:
        - q
    - `man -f man`
    - `man 1 man`
  - Practice
    - try the examples
    - try placing extra whitespace in your commands
    - execute the commands we've mentioned so far
      - `cd`
      - `ls`
      - `ssh`
      - `cat`
      - `date`
      - *`ping`
      - *`ifconfig`
    - execute a multi-line command
    - checkout the manual of `sudo` & `su` command
      - exam the difference of home directory & identity
    - checkout the manual of the commands we've mentioned so far, try to browse and understand the info
      - `cd` `ls` `ssh` `cat` `date` *`ping` *`ifconfig` `wc`
  - Assignment
    - checkout the manual of `touch` command
    - log on your amazon vm
    - create the following empty files in your home directory
      - 'touchme.txt'
      - 'touch me'
      - 'Touch Me'