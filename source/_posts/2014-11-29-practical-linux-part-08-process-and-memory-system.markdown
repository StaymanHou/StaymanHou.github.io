---
layout: post
title: "Practical Linux - Part 08 - Process &amp; Memory System | 进程与内存系统"
date: 2014-11-29 17:02:08 +0000
comments: true
categories: [Linux]
keywords: "linux, process, memory"
---
{% youtube X_oPWjAZz24 %}
<!-- more -->
- Oct 16 - Process & Memory System
  - What is process:
    - execute program
      - PID
      - UID/GID
      - example: bash
    - parent process & child process
      - example `bash <enter> ps -l`
      - fork & exec system call
    - daemon
  - Multi-processing
    - multiple online user
    - multiple processes
    - * tty1~7
  - Process Control
    - foreground & background
      - ctrl + c
    - `<command> &`
    - `<command> > /tmp/log.txt 2>&1 &`
    - stop ctrl + z
    - `jobs`
    - `fg [jobid]`
    - `bg [jobid]`
    - `kill -signal %jobid`
      - `kill -l`
      - 1, 2, 9, 15, 19
    - `killall`
    - `nohup <command> &`
    - `ps`
      - `ps aux`
      - `ps -lA`
      - `ps axjf`
      - `ps -l`
        - STAT - http://askubuntu.com/questions/360252/what-do-the-stat-column-values-in-ps-mean
    - `top`
      - load = processes using or waiting for CPU
      - PR = priority. PR = NI + 20
      - NI = Nice. the higher, the nicer
    - `renice [nice] <PID>`
    - `free`
    - /proc
      - uptime
      - version
      - vmstat
      - zoneinfo
    - `lsof`
  - Assignment
    - log on your amazon vm
    - make sure your vm has the following to process in the background even you log out:
      - a running process running `sleep 1209600 && echo "finally I'm awake. goodbye" > ~/log.txt`
      - a stopped process running `ping localhost`