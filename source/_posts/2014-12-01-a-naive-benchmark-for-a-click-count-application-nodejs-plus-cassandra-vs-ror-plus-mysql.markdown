---
layout: post
title: "A naive benchmark for a click count application: NodeJS + Cassandra VS ROR + MySQL 简单性能对比（基于一个点击计数应用）"
date: 2014-12-01 01:17:20 +0000
comments: true
categories: [NodeJS, Cassandra, Ruby on Rails, MySQL]
keywords: "nodejs, cassandra, ror, rails, mysql"
---
This post is about a naive benchmark: NodeJS + Cassandra VS Ruby on Rails + MySQL. There are plenty of benchmarks in the wild(db/web). However, it's still difficult to decide which stack solution to use for your application. Actually, it heavily depends on the application/use case/scenario. This benchmark is based on a very simple scenario: a click count application. This benchmark is very naive! Be aware of that when you use it as a reference.

这篇帖子写得是关于NodeJS + Cassandra VS Ruby on Rails + MySQL的性能对比。网上其实有很多很多这样的比较（数据库/网站框架）。但是我看了以后还是觉得很难决定用哪个产品来做哪个应用。大家都论调不同，视角不同，比较的人也很难说对所有的产品都精通，难免有偏颇，甚至有的可能有广告嫌疑。反正，性能的对比很大程度上依赖于应用/案例/场景。我的这个简单的比较是基于一个简单的点击计数的案例。（这个比较非常初步，仅供参考，可能以后会更深入的研究一下）
<!-- more -->
NodeJS + Cassandra VS ROR + MySQL

# Setup

* Both use an individual virtual machine (VirtualBox) with 1 core cpu & 2 GB Memory
* Install the stack in their respective vm
* Start the services (NodeJS, Cassandra, Ruby on Rails, MySQL) with no tunning - Use configuration come with default, minium modification to make it up & running
* Granularity is **hour**

# Application Implementation

## NodeJS + Cassandra

* Stack: Cassandra, node cassandra driver, Express, NodeJS, nvm, npm

* DB Schema (CQL): 
{% codeblock lang:sql %}
CREATE TABLE count_by_widget ( widgetID int, time timestamp, clicks counter, PRIMARY KEY (widgetID, time) ) WITH CLUSTERING ORDER BY (time DESC)
{% endcodeblock %}

* Query to insert a hit (CQL):
{% codeblock lang:sql %}
UPDATE count_by_widget SET clicks = clicks + 1 WHERE widgetID=? AND time=?
{% endcodeblock %}

* Application Code: For detailed code, see [my Github](https://github.com/StaymanHou/click_count_app_benchmark/tree/master/nodejs_cassandra)

* Command to start server:
{% codeblock lang:bash %}
NODE_ENV=production node bin/www
{% endcodeblock %}

## ROR + MySQL

* Stack: MySQL, mysql2 gem, Rails, Ruby, rvm, bundler

* DB Schema (ActiveRecord Migration): 
{% codeblock lang:ruby %}
class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks, {id: false} do |t|
      t.integer :widgetID
      t.timestamp :time
      t.integer :click

      t.timestamps
    end
    execute 'ALTER TABLE clicks ADD PRIMARY KEY (widgetID, time);'
  end
end
{% endcodeblock %}

* Query to insert a hit (ActiveRecord):
{% codeblock lang:ruby %}
class Click < ActiveRecord::Base
  def self.hit(wid)
    time = Time.new.beginning_of_hour
    Click.create(widgetID: wid, time: time, click: 1) if 0 == (Click.where(widgetID: wid, time: time).update_all 'click = COALESCE(click, 0) + 1')
  end
end
{% endcodeblock %}

* Application Code: For detailed code, see [my Github](https://github.com/StaymanHou/click_count_app_benchmark/tree/master/ror_mysql)

* Command to start server:
{% codeblock lang:bash %}
bundle exec passenger start -d -e production
{% endcodeblock %}

# Execution

To generate load, I used my python script. It send requests to a target url with multiple threads. I chose 3 urls associated with three click target ID's. The rule is simple, push the applications to the limit. If it can handle more, create more threads to generate more load until reach the limit.

# Result

| Stack         | Node+Cas    | ROR+MySQL    |
| ------------- | ----------- | ------------ |
| Max RPM       | 18,000      | 12,000       |
| Response Time | very fast   | fast         |

**NodeJS crashed when RPM goes to around 36,000**

# Conclusion

**Be aware that the data set is not large**

* _NodeJS + Cassandra_ can handle more requests. I think Cassandra is faster to perform counter increment.

* _NodeJS + Cassandra_ response the request faster, because it's non-blocking. Requests can be responsed while db query is still running in NodeJS.

* _Ruby on Rails + MySQL_ is more stable. It didn't crash when it's overloaded. Maybe I didn't implement the NodeJS correctly? Please comment.

* _NodeJS + Cassandra_ is much easier to develop for this use case. e.g. Insert & Update are same in cassandra. That means you don't have to create a new row before the click increment query.

* _NodeJS + Cassandra_ retreives data faster, since the data is sorted by timestamp in storage. On the other side, _MySQL_ requires scanning over the entire table and then sort.

* _Cassandra_ has a better scalability. By adding Cassandra nodes, performance can be improved in a linear fashion.

# Future Study

This benchmark is very naive. The following points can be improved in the future.

* Larger data set

* Mix & Match:
** NodeJS + MySQL
** Ruby on Rails + Cassandra

* More DB:
** MongoDB
** CouchDB

* More web framework:
** PHP
** Django

* Reading operation performance

# Reference

* [Cassandra VS MongoDB](http://planetcassandra.org/nosql-performance-benchmarks/)
* [Couchbase VS Cassandra](http://www.couchbase.com/press-releases/couchbase-dominates-cassandra-datastax-and-mongodb-newly-released-nosql-performance-benchmark)
__the two links above are really conflicting__
* [Rails VS NodeJS](http://robbinfan.com/blog/40/ruby-off-rails) __nodejs的吞吐量貌似没有它说的那么牛，但是他对rails的优势劣势分析得还是挺中肯的__
* [Web App Framework Benchmarks](http://www.techempower.com/benchmarks/)