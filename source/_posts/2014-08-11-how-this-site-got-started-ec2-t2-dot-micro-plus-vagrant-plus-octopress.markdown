---
layout: post
title: "How this site got started: Setup EC2 (T2.micro) + Vagrant + Octopress (Ubuntu)"
date: 2014-08-11 00:56:23 +0000
comments: true
categories: [AWS, EC2, Vagrant, OctoPress, Dev]
keywords: "asw, ec2, vagrant, octopress, dev"
description: "This is a post that describes the process of setting up a vagrant + ec2 environment for a octopress blog"
---
Today, I decided to start making my own blog. The major reason is that I can't find enough blogs talking about Chef. This makes things perticularly difficult when I started working on Chef. Not to mention blogs in Chinese. Therefore, I wanna record what I learned, and share it with the IT folk in the world. I will write both in English & Chinese. Hopefully it could help the IT guys in China.

This post describes how I built the dev environment and the server stack of this blog.

The reasons why I chose EC2 + Vagrant + Octopress are that:
1) EC2: flexibility + 1 year free tier
2) Vagrant: easy-to-launch virtual environment + sync folder setting = fast start + favorite editor + no messing up my local env
3) OctoPress: IT-guys-oriented + everything static (no php, etc.) good for performance

今天决定要作个人博客。因为最近在做关于Chef的东西，网上很难找到相关的资料，所以chef做起来就异常艰难。更不用说什么中文的博客了。这个是主要原因。所以希望能够把我摸索出来的东西记录下来，分享给其他作IT的人。特别希望这个能帮助到中国的IT人。

这篇博客是关于我怎么搭建这个blog的开发环境和服务器stack的部署。

我用了 EC2 + Vagrant + Octopress，原因是:
1) EC2: 灵活性 + 一年免费
2) Vagrant: 最方便启用的虚拟环境 + 同步文件夹设定 = 立马开始 + 可以用最爱的编辑器 + 不会搞乱本地环境
3) OctoPress: IT人专用的blog + 纯静态 （不跑php等脚本) 性能好

<!-- more -->
# Part 1: Vagrant 第一部分： Vagrant
To be honest, Vagrant is pretty optional. Octopress comes with a local dev environment. However, I still prefer to have a dev box so that ruby, gem, bundle will not mess up my laptop. Vagrant is the perfect environment I want. To get started:

说实话，Vagrant是可以不用搭的。Octopress自带了一个简单的本地开发环境。不过我个人还是喜欢用一个独立的box来开发。因为ruby, gem, bundle很容易把我笔记本的环境搞得一团糟。所以Vagrant就正中我下怀了。那么我们开始吧。

First of all, my laptop is running Ubuntu 14.04. 事先声明，我的本子跑的是Ubuntu 14.04。

Open *Ubuntu Software Center*. Search for *VirtualBox* and *Vagrant*. Install them. 打开*Ubuntu Software Center*，搜索*VirtualBox*和*Vagrant*，安装。

Now, we are ready to launch vagrant box. Lets first setup a directory to contain the vagrant box config files. 现在vagrant就可以跑了。 先新建一个文件夹用来保存vagrant的配置文件`Vagrantfile`
{% codeblock lang:bash %}
$ mkdir -p ~/vagrant/octopress
{% endcodeblock %}

Lets initiate the box with the basic ubuntu image. 我们用basic ubuntu镜像来初始化这个vagrant box

Add the basic image to your local boxes. In my case, I chose 14.04 x64. You can use any version & architecture you want. Remember to change the box name and the url accordingly. You are able to find all the available ubuntu images [here](https://cloud-images.ubuntu.com/vagrant) 先把这个镜像加载到你的本地上。我用的是14.04 x64。你可以根据你的情况选择不同的ubuntu版本和架构。根据情况修改加载box的名字和url。在[这里](https://cloud-images.ubuntu.com/vagrant)可以找到可用的镜像
{% codeblock lang:bash %}
$ vagrant box add ubuntu/trusty64 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
{% endcodeblock %}
Go to your vagrant box directory and initiate it. `cd`到刚才vagrant文件夹里面，然后初始化。
{% codeblock lang:bash %}
$ cd ~/vagrant/octopress
$ vagrant init ubuntu/trusty64
{% endcodeblock %}

Find out these two lines in the default `~/vagrant/octopress/Vagrantfile` and replace the value. In my case: 在`Vagrantfile`里面找到这两行，然后改成如下所示：
{% codeblock lang:ruby %}
[...]

  config.vm.network :private_network, ip: "192.168.33.101"

  [...]

  config.vm.synced_folder "~/Personal/blog.staymanhou.com", "/data/blog.staymanhou.com"

[...]
{% endcodeblock %}
The attribute `config.vm.synced_folder` will sync the directory `~/Personal/blog.staymanhou.com` on my host machine with the `/data/blog.staymanhou.com`. You could think them are some sort of shared folder. Therefore, `~/Personal/blog.staymanhou.com` will be the diretory that contain my blog source code. 这样的话，两个文件夹：在你机子上的`~/Personal/blog.staymanhou.com`和你vagrant虚拟机里的`/data/blog.staymanhou.com`就同步了. 可以把他们想成是共享文件夹。所以以后直接编辑`~/Personal/blog.staymanhou.com`，你虚拟机里的文件也就跟着改了

We can boot the box now. In your `~/vagrant/octopress` directory. 初始化号以后我们就可以启动这个vagrant虚拟机了
{% codeblock lang:bash %}
$ vagrant up
{% endcodeblock %}
After the box is up, run the following command to ssh into the box. 虚拟机启动好以后下面的指令
{% codeblock lang:bash %}
$ vagrant ssh
{% endcodeblock %}
We are now inside of the running box! 这样我们就进到虚拟机啦！是不是很简单呀

Lets setup the web server stack in this box. Then it will be turned into your dev environment. 让我们在新的虚拟机上设置网站服务栈吧。之后这个就成为你的开发环境咯。

Always update the package info first. 永远是先更新所有包的信息
{% codeblock lang:bash %}
$ sudo apt-get 
{% endcodeblock %}
Install `rvm` - ruby version manager 安装`rvm`
{% codeblock lang:bash %}
$ curl -sSL https://get.rvm.io | bash -s stable
{% endcodeblock %}
And followed by: 然后
{% codeblock lang:bash %}
$ source ~/.rvm/scripts/rvm
{% endcodeblock %}
Install `ruby 2.1.2` with `rvm`: 用`rvm`安装`ruby 2.1.2`
{% codeblock lang:bash %}
$ rvm install 2.1.2
{% endcodeblock %}
Install `bundler` 安装`bundler`
{% codeblock lang:bash %}
$ gem install bundler
{% endcodeblock %}
Ruby is now ready. ruby环境就搭好了

We will also need a js engine for javascript runtime. This will be used by octopress later. 另外我们还需要一个javascript runtime引擎，一会儿octopress会用上它
{% codeblock lang:bash %}
$ sudo apt-get install nodejs
{% endcodeblock %}

And the most important - **`Nginx`** 以及最要紧的**`Nginx`**
{% codeblock lang:bash %}
$ sudo apt-get install nginx
{% endcodeblock %}


{% codeblock lang:bash %}
$ sudo apt-get install nginx
{% endcodeblock %}
After install nginx, lets make the config file for your site. 安装完成之后，来做配置文件
{% codeblock lang:bash %}
$ vi /etc/nginx/sites-available/blog.staymanhou.com
{% endcodeblock %}
Put the following content in the the available site config file. Change the domain name accordingly. 把下面的内容放进去，把域名换成你自己的
{% codeblock lang:nginx %}
server {
  listen 80;
  ### This setting tells Nginx to use this configuration if it gets a request for
  ### yourblog.com
  server_name blog.staymanhou.com;

  ### This is the location on the web server where your Octopress files are
  ### published. Setting this here means you don't have to set it for any of the
  ### individual locations you define below.
  root /data/blog.staymanhou.com/public;

  ### This tells Nginx to use "index.html" as the default index page everywhere
  index index.html;

  ### This disables automatic directory index creation, since no one will be
  ### browsing your directories anyway
  autoindex off;

  location / {
    try_files $uri $uri/ =404;
  }

  location ~ /\. { access_log off; log_not_found off; deny all; }
  location ~ ~$ { access_log off; log_not_found off; deny all; }
  location = /robots.txt { access_log off; log_not_found off; }
  location = /favicon.ico { access_log off; log_not_found off; }

}
{% endcodeblock %}

Great! the setup in the box is done. The web server will serve the documents in `/data/blog.staymanhou.com/public` directory. Don't worry, the directory doesn't exist now. And therefore, nginx will give you 404 not found or 403 forbidden. We will get it to work soon. Exit the vagrant box by hitting `Ctrl + D`. Halt the box by running: 好，到此为止，vagrant的配置就搞定了，访问的时候它会伺服`/data/blog.staymanhou.com/public`的内容。当然现在可能会告诉你 403或者404，莫慌，跑完下面的配置，它就该正常工作了。按`Ctrl + D`从vagrant虚拟机里面跳出来，然后终止它。
{% codeblock lang:bash %}
$ vagrant halt
{% endcodeblock %}

# Part 2: OctoPress 第二部分： OctoPress

Ok, now, fork and clone the [OctoPress](https://github.com/imathis/octopress) repo into your github and local machine. 现在把[OctoPress](https://github.com/imathis/octopress)给fork到你自己的github，再clone到本地
{% codeblock lang:bash %}
$ cd ~/Personal/blog.staymanhou.com
$ git clone <your octopress repo uri> .
{% endcodeblock %}
You can now edit the code with your favorate text editor. My favorate is Sublime Text. If you haven't tried it, give it a shot. 这样你就可以用自己最顺手的编辑器编辑了，我喜欢Sublime Text。没试过的话，建议尝试

Let's go back into the vagrant box. 现在回到vagrant虚拟机
{% codeblock lang:bash %}
$ cd ~/vagrant/octopress
$ vagrant up
$ vagrant ssh
{% endcodeblock %}
You will find that the newly clone code is also in the directory `/data/blog.staymanhou.com`. It is because we have configured vagrant to sync it. Inside the box: 你会发现刚clone来的代码已经在`/data/blog.staymanhou.com`里了。因为我们刚才设置了同步文件。在vagrant里面跑这个
{% codeblock lang:bash %}
$ cd /data/blog.staymanhou.com
$ bundle install
{% endcodeblock %}
This will install all the gems that are required by OctoPress. 这个会把所有需要的gem都安装好
Running next command to generate the pages of your blog. 跑下面这个指令，博客的页面就生成啦
{% codeblock lang:bash %}
$ rake generate
{% endcodeblock %}
Now, your blog is up and running in your dev box.
To take a look at it. Go back to your local machine by fire up a new terminal. Add the new line `192.168.33.101 blog.staymanhou.com` in your hosts file. 现在，你的博客已经在开发环境下跑起来了。想先看一眼？回到本机。加一行`192.168.33.101 blog.staymanhou.com`到你的hosts文件
{% codeblock lang:bash %}
$ echo '192.168.33.101 blog.staymanhou.com' >> /etc/hosts
{% endcodeblock %}
I manage my hosts file with a firefox adon `HostAdmin`. Give it a shot. 我比较喜欢用一个叫`HostAdmin`的firefox插件来管理我的hosts文件
Now, if we enter `blog.staymanhou.com` in a browser, we will be able to view your blog! You can modify the `_config.yml` to do some basic customization. Here is my `_config.yml`: 现在在浏览器里面输入`blog.staymanhou.com`就可以看到网站拉。通过修改`_config.yml`，你可以做一些自定义的设置。这个是我的：
{% codeblock _config.yml %}
# ----------------------- #
#      Main Configs       #
# ----------------------- #

url: http://blog.staymanhou.com
title: Stayman's Blog
subtitle: 'A blog belongs to a system admin & hacker.'
author: Stayman Hou 侯越辰
simple_search: https://www.google.com/search
description: "This is Stayman's blog. Stayman is a Christian. He has some experience over system administration. Have some hacking skills. This blog covers the following topics: IT, server, Linux, dev, personal life, and Christianity. You could find helpful thing here, either technique-related or life-related. 侯越辰的博客。基督徒，系统维护，hacking。包括一下的话题：信息技术，服务器，Linux，开发，个人生活，基督教。希望你可以在这里得到技术和人生上的帮助。"

# Default date format is "ordinal" (resulting in "July 22nd 2007")
# You can customize the format as defined in
# http://www.ruby-doc.org/core-1.9.2/Time.html#method-i-strftime
# Additionally, %o will give you the ordinal representation of the day
date_format: "ordinal"

# RSS / Email (optional) subscription links (change if using something like Feedburner)
subscribe_rss: /atom.xml
subscribe_email:
# RSS feeds can list your email address if you like
email:

# ----------------------- #
#    Jekyll & Plugins     #
# ----------------------- #

# If publishing to a subdirectory as in http://site.com/project set 'root: /project'
root: /
permalink: /blog/:year/:month/:day/:title/
source: source
destination: public
plugins: plugins
code_dir: downloads/code
category_dir: blog/categories
markdown: rdiscount
rdiscount:
  extensions:
    - autolink
    - footnotes
    - smart
highlighter: pygments # default python pygments have been replaced by pygments.rb

paginate: 10          # Posts per page on the blog index
paginate_path: "posts/:num"  # Directory base for pagination URLs eg. /posts/2/
recent_posts: 5       # Posts in the sidebar Recent Posts section
excerpt_link: "Read on &rarr;"  # "Continue reading" link text at the bottom of excerpted articles
excerpt_separator: "&lt;!--more--&gt;"

titlecase: true       # Converts page and post titles to titlecase

# list each of the sidebar modules you want to include, in the order you want them to appear.
# To add custom asides, create files in /source/_includes/custom/asides/ and add them to the list like 'custom/asides/custom_aside_name.html'
default_asides: [asides/recent_posts.html, asides/googleplus.html, asides/github.html] #, asides/delicious.html, asides/pinboard.html

# Each layout uses the default asides, but they can have their own asides instead. Simply uncomment the lines below
# and add an array with the asides you want to use.
# blog_index_asides:
# post_asides:
# page_asides:

# ----------------------- #
#   3rd Party Settings    #
# ----------------------- #

# Github repositories
github_user: StaymanHou
github_repo_count: 10
github_show_profile_link: true
github_skip_forks: true

# Twitter
twitter_user:
twitter_tweet_button: true

# Google +1
google_plus_one: false
google_plus_one_size: medium

# Google Plus Profile
# Hidden: No visible button, just add author information to search results
googleplus_user: 111718847796837023988
googleplus_hidden: false

# Pinboard
pinboard_user:
pinboard_count: 3

# Delicious
delicious_user:
delicious_count: 3

# Disqus Comments
disqus_short_name: staymansblog
disqus_show_comment_count: false

# Google Analytics
google_analytics_tracking_id: UA-53641328-1

# Facebook Like
facebook_like: false
{% endcodeblock %}

# Part 3: EC2 (Server Stack Setup) 第三部分： EC2 (服务栈设置)

Here is the most exciting part. We will soon make your blog publicly available. 这里就是最精彩的部分了，马上我们的博客就要真实上线了

Launch a T2.micro instance. In my case, I want to use two EBS volumes. One for system, the other for site data. Lets allocate 15GB for each volume. Attache them as /dev/xvda and /dev/xvdb. 新建一个T2.micro instance。我的话，想要用两个EBS卷，一个用来放系统，一个用来放网站的东西。我各配了15G，分别作为/dev/xvda和/dev/xvdb连接上去

Use the command `lsblk` to verify the volumes that you attached. 用`lsblk`指令确认一下卷都对得上号儿
{% codeblock lang:bash %}
$ lsblk
{% endcodeblock %}
/dev/xvdb is probably now a raw block without any file system. Let's format the volumes into ext4. If you have no idea what this is about, just follow it. /dev/xvdb现在很可能是个裸块儿，还没有文件系统，我们把它格式化一下。如果你不太明白的话，跑这个指令就行了
{% codeblock lang:bash %}
$ sudo mkfs -t ext4 /dev/xvdb
{% endcodeblock %}

The formating process may take a while. After that, let's mount the formated sf on to `/data` directory. This is gonna be the place where we will put your site files. 格式化可能会用一些时间，完了之后我们把这个文件系统挂载到`/data`这个文件夹上面，这个路径之后就是我们放网站文件的地方
{% codeblock lang:bash %}
$ sudo mkdir /data
$ sudo mount /dev/xvdb /data
{% endcodeblock %}

To make your second volume always available after reboot, edit the `/etc/fstab` file 为了让它每次重启之后都自己会挂载，我们要编辑`/etc/fstab`文件
{% codeblock lang:bash %}
$ sudo vi /etc/fstab
{% endcodeblock %}
And add this line 里面加上这一行
{% codeblock /etc/fstab %}
/dev/xvdb /data ext4  defaults,nofail 0 2
{% endcodeblock %}
Test if the new config takes place 测试一下好不好使
{% codeblock lang:bash %}
$ sudo mount -a
{% endcodeblock %}

Create a new user for the site files only. That meets the principle of least privilege. 新建一个用户，专门作为网站文件的owner，这个是最小权限原则
{% codeblock lang:bash %}
$ sudo adduser bloguser --disabled-password
$ sudo mkdir -R /data/www/staymanhou.com/blog
$ sudo chown bloguser:bloguser /data/www/staymanhou.com/blog
{% endcodeblock %}

Lets install `Nginx`. 安装`Nginx`
{% codeblock lang:bash %}
$ sudo apt-get update
$ sudo apt-get install nginx
{% endcodeblock %}

And then create common.conf and the site config. This will make your available both through http and https. Probably you don't want https, feel free to comment it out. 然后写入common.conf和网站配置文件。这个例子里面会网站同时跑http和https，你多半不需要https，可以注释掉
{% codeblock lang:bash %}
$ sudo vi /etc/nginx/common.conf 
{% endcodeblock %}

{% codeblock lang:nginx /etc/nginx/common.conf %}
### This file contains common configuration and location directives for the
### HTTP and HTTPS versions of my Octopress blog

### Common root location
  location / {
      try_files $uri $uri/ =404;
  }

### Common deny, drop, or internal locations
  location ~ /\. { access_log off; log_not_found off; deny all; }
  location ~ ~$ { access_log off; log_not_found off; deny all; }
  location = /robots.txt { access_log off; log_not_found off; }
  location = /favicon.ico { access_log off; log_not_found off; }
{% endcodeblock %}

{% codeblock lang:bash %}
$ vi /etc/nginx/sites-enabled/blog.staymanhou.com 
{% endcodeblock %}
{% codeblock lang:nginx /etc/nginx/sites-enabled/blog.staymanhou.com %}
### The first server block is the HTTP server
server {
  server_name blog.staymanhou.com;
  root /data/www/staymanhou.com/blog;
  listen 80;
  index index.html;
  autoindex off;

  ### And now, rather than list a bunch of locations here, we just tell Nginx to
  ### go find the "common.conf" file and read that instead. We're going to add
  ### stuff into common.conf in just a sec.
  include common.conf;  
}

### The second server block is the HTTPS server, which has the "listen 443"
### line to tell Nginx that traffic for it will come on TCP port 443. The
### HTTP server above doesn't have a "listen 80" line because when the "listen"
### directive is omitted, "listen 80" is implied.
server {
  server_name blog.staymanhou.com;
  root /data/www/staymanhou.com/blog;
  listen 443;
  index index.html;
  autoindex off;
  include common.conf;

### The next set of directives tells Nginx that this server uses SSL, and then
### supplies it with the configuration settings necessary to make SSL work
  ssl on;
  ssl_certificate /etc/nginx/ssl/blog.staymanhou.com.crt;
  ssl_certificate_key /etc/nginx/ssl/blog.staymanhou.com.key;
}
{% endcodeblock %}

Make the site enabled by add a soft link in the `sites-enabled` directory. And then restart nginx to apply it. 用软联启用网站的配置。然后重启nginx
{% codeblock lang:bash %}
$ sudo ln -s /etc/nginx/sites-available/blog.staymanhou.com /etc/nginx/sites-enabled/blog.staymanhou.com
$ sudo /etc/init.d/nginx restart
{% endcodeblock %}

Last step. Enable your vagrant box to deploy your blog onto your by adding you vagrant box ssh public key.
In your vagrant box. `cat` your public key as user `vagrant`. 最后一步，让你的vagrant虚拟机可以把你的博客部署到EC2上。看一下你`vagrant`用户的公钥
{% codeblock lang:bash %}
$ cat ~/.ssh/id_rsa.pub
{% endcodeblock %}

In the EC2 instance. Open the `authorized_keys` file for user `bloguser`, and add you vagrant box ssh prublic key in it. 在你的EC2 instance里面把这个公钥加入`authorized_keys`
{% codeblock lang:bash %}
$ sudo su bloguser
$ mkdir .ssh
$ cat 'yoursshpublickeyhere' > authorized_keys
$ chmod 700 .ssh
$ chmod 600 .ssh/authorized_keys
{% endcodeblock %}

Open the Rakefile of the blog with your favorite editor. Edit the `Rsync Deploy config` to match the configuration on your EC2 instance. 打开你博客的Rakefile，找到`Rsync Deploy config`这个部分，根据情况改，一下参考
{% codeblock lang:ruby Rakefile %}
[...]
## -- Rsync Deploy config -- ##
# Be sure your public key is listed in your server's ~/.ssh/authorized_keys file
ssh_user       = "bloguser@blog.staymanhou.com"
ssh_port       = "22"
document_root  = "/data/www/staymanhou.com/blog"
rsync_delete   = true
rsync_args     = ""  # Any extra arguments to pass to rsync
deploy_default = "rsync"
[...]
{% endcodeblock %}

Now, deploy your site, let everyone see it. 现在，把你的博客上传上去把，大家就能看到拉
{% codeblock lang:bash %}
$ rake deploy
{% endcodeblock %}

That's it. If everything goes right, you will get your blog running in both vagrant box as dev env, and EC2 as prod env. Enjoy free (for a year and no heavy traffic) blogging with OctoPress. If your blog gets popular, you probably want add Varnish in front of it, and upgrade your instance. 大功告成。如果一切都作对了的话，你的博客应该正式上线了，在vagrant的开发环境也应该OK。用OctoPress随便玩吧，一年的时间是免费的，只要你没有什么很大的流量的话。如果你的博客越来越热门了，可以考虑在前面加一个Varnish，然后升级一下instance。