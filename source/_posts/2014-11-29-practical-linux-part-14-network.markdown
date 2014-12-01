---
layout: post
title: "Practical Linux - Part 14 - Network | 网络"
date: 2014-11-29 17:02:10 +0000
comments: true
categories: [Linux]
keywords: "linux, network"
---
{% youtube opFNScFISYI %}
<!-- more -->
- Nov 18 - Network
  - Principle: linux.vbird.org/linux_server/0110network_basic.php
  - Commands: linux.vbird.org/linux_server/0140networkcommand.php
  - Debugging: linux.vbird.org/linux_server/0150detect_network.php#step_1_nic
  - Security: linux.vbird.org/linux_server/0210network-secure.php
  - Assignment:
    - Log on your Amazon vm
    - install any packages you need to accomplish the assignment
    - determine how many virtual network interface your vm has
      - (excluding lo)
    - what's the hostname of your vm
    - find your virtual ip address
    - determine the ave round-trip time between your vm and google.com
    - determine the name server of google.com
    - trace the route between your vm and google.com
    - configure the firewall to block any outbound smtp traffic (port 25)
      - !!! test it on your local vm first. this may block yourself from logging into your vm