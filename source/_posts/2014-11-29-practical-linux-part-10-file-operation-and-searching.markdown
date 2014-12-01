---
layout: post
title: "Practical Linux - Part 10 - File Operation &amp; Searching | 文件操作与搜索"
date: 2014-11-29 17:02:09 +0000
comments: true
categories: [Linux]
keywords: "linux, file, search"
---
{% youtube UK0nPFQihnY %}
<!-- more -->
- Nov 4 - File Operation & Searching
  - http://vbird.dic.ksu.edu.tw/linux_basic/0220filemanager.php
  - linux.vbird.org/linux_basic/0330regularex.php
  - Wildcard
    - `*`
      - `ls -l /usr/bin/X*`
  - Searching
    - `which [-a]` for command
      - `which ls`
    - for file
      - `whereis`
        - `whereis ifconfig`
      - `locate [-ir]`
        - `locate passwd`
        - search from db
        - `updatedb`
      - `find`
        - `find / -mtime 0`
        - `find /etc -newer /etc/passwd`
        - `find /home -user ubuntu`
        - `find / -name passwd`
        - `find /var -type f`
        - `find /etc -name passwd -exec cat {} \;`
        - `find / -size +1000k`
        - `find /etc -name '*ssh*'`
  - Regex
    - `grep`
      - `last | grep 'root'`
      - `last | grep -v 'root'`
      - `dmesg | grep 'eth'`
      - `dmesg | grep -n 'eth'`
    - `sed`
      - `sed 's/old/new/g'`
    - `awk`
  - Assignment
    - log on your amazon vm
    - use `find` to find all the files under your home directory which has been modified within 3 weeks
    - use `grep` to find all the files containing `*` under `/etc`
    - use `sed` to replace 'exit' in file `.bash_history` with 'exat'