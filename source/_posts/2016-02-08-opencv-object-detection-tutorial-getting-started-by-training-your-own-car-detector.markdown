---
layout: post
title: "OpenCV Object Detection Tutorial - Getting Started by Training Your Own Car Detector"
date: 2016-02-08 22:15:37 +0000
comments: true
categories: [Computer Vision, OpenCV]
keywords: "computer vision, OpenCV, cascade classifier, NodeJS"
---
I've mentioned the visual recognition solutions in a previous [blog post](//blog.staymanhou.com/blog/2016/02/08/visual-recognition-slash-computer-vision-as-of-feb-2016/). However, I was not able to find a service that locates a specified object in an image. So I started out my OpenCV journey. There are human and face classifier available, well-trained. If you want to detect something else, you will probably end up with training a classifier yourself. Unfortunately, I was not able to find a complete tutorial about how to train a classifier. If you run into the same situation, I hope this post can help you.

<!-- more -->

#Intro

What is *[OpenCV](http://opencv.org/)*? OpenCV (Open Source Computer Vision) is a library of programming functions mainly aimed at real-time computer vision - [Wiki](https://en.wikipedia.org/wiki/OpenCV). It has C++, C, Python and Java interfaces, but today we will use the [OpenCV NodeJS package](https://github.com/peterbraden/node-opencv).

What is *object detection*? It's the task of finding and identifying objects in an image. For example, in this tutorial, we will be finding cars in images. It should return a rectangle (in the form of x, y, width, and height). See the example result below.

{% img center /images/posts_detected_car.jpg 'image' 'detected car' %}

What is *cascade classifier*? Object Detection using Haar feature-based cascade classifiers is an effective object detection method proposed by Paul Viola and Michael Jones in their paper. First, a classifier (namely a cascade of boosted classifiers working with haar-like features) is trained with a few hundred sample views of a particular object (i.e., a face or a car), called positive examples, that are scaled to the same size (say, 20x20), and negative examples - arbitrary images of the same size.

The word “cascade” in the classifier name means that the resultant classifier consists of several simpler classifiers (stages) that are applied subsequently to a region of interest until at some stage the candidate is rejected or all the stages are passed.

#Installation

First, let's install all the required programs. I'm using Ubuntu, you should be able to find the installation instructions for your OS as well.

We will install OpenCV from the Ubuntu repository:

```bash
sudo apt-get install libopencv-dev
```

Also, we need to install nvm, node, and the node OpenCV package. Note that these are not required. If you are going to use its C, C++, Java, or Python API, install the corresponding package.

Install nvm

```bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash
```

Close the terminal and open a new one. Install node

```bash
nvm install node
```

Install node opencv package

```bash
npm install opencv
```

#Dataset

We will train a car detector. And we will use the [UIUC Image Database for Car Detection](https://cogcomp.cs.illinois.edu/Data/Car/). Click the download on that page. Extract the .tar.gz file on your PC. Let's say our workspace is `/tmp/car_detection`, the extracted directory should be `/tmp/car_detection/CarData`. You should be able to find `TrainImages`, `TestImages`, and `TestImages_Scale` under the directory, together with some other java and text files. We will use the images in `TrainImages` to train our classifier. There are two categories of images. `neg-*.pgm` are backgrounds or negative samples, which don't have a car in it. `pos-*.pgm` are positive samples, which have a car in it.

#Prepare the training data

We will need to prepare the training data so that opencv can know the positive samples and negative samples.

First we create a `/tmp/car_detection/cars.info` file. This file contains the path of the positive image files, as well as the number of objects and the location of the objects, one per line. Find the complete file [here](https://gist.github.com/StaymanHou/a7bbc5a0b0e69fafcd5b)

```
image_path, number_of_objects, object_0_x, object_0_y, object_0_width, object_0_height[, object_1_...]
/tmp/car_detection/CarData/TrainImages/pos-0.pgm 1 0 0 100 40
```

Now, we should convert and normalize the positive samples into a vector file. The following command will take the `cars.info` normalize the samples into 50x20 vectors, and output into `cars.vec`

```bash
cd /tmp/car_detection/
opencv_createsamples -info cars.info -num 550 -w 50 -h 20 -vec cars.vec
```

You can verify the output with the following command

```bash
opencv_createsamples -vec cars.vec -w 50 -h 20
```

Time to tell OpenCV where are our backgrounds/negative samples. Create a `/tmp/car_detection/bg.txt` file. This file contains the path of the negative image files, one per line. Find the complete file [here](https://gist.github.com/StaymanHou/374ca442759073320116)

#Train the classifier

All right, with the training data prepared, we now can train our classifier. The training result will be written into `data` directory

```
mkdir data
opencv_traincascade -data data -vec cars.vec -bg bg.txt -numPos 500 -numNeg 500 -numStages 12 -w 50 -h 20 -featureType LBP -maxFalseAlarmRate 0.3
```

A few comments on the options. `-numPos` specifies the number of positive samples to use in training. Due to the algorithm, this number must be a little less than the actual available dataset. `-numStages` specifies the number of stages of the classifier. The more stages, the more accurate it will be, but it will also take longer to train. `-featureType` specifies the feature type. We use `LBP` here. Another option is `HAAR`. It will take much longer to train, but produces a better accuracy. `-maxFalseAlarmRate` specifies the max false alarm rate. The training will continue until it meets these criteria.

There are two essential metrics for the outcome. Hit rate and false alarm rate. If you care about the false alarm rate, you should probably specify something like 0.1 in the training command. However, if it is too lower, the training might take forever.

The training process took a few minutes on my workstation, which has 4 cores 2722 MHz.

Once the training completes, you should be able to find the file `/tmp/car_detection/data/cascade.xml`. This is the classifier you trained.

#Use the classifier

GREAT! Now, let's see how it works. Create a nodejs file which will use the classifier we just trained to locate the cars. `/tmp/car_detection/opencv-car.js`

```js
var cv = require('opencv');

cv.readImage("/tmp/car_detection/CarData/TestImages_Scale/test-1.pgm", function(err, im){
  im.detectObject('/tmp/car_detection/data/cascade.xml', {}, function(err, cars){
    for (var i=0;i<cars.length; i++){
      var x = cars[i]
      im.rectangle([x.x, x.y], [x.width, x.height]);
    }
    im.save('./out.jpg');
  });
})
```

Check out the `out.jpg` file to see the result. Sometimes you will see false detections. Since the training just took a few minutes, don't expect too much. Want a better accuracy? Try to tweak the training parameters.

#Latest research update

While I'm writing this post, I saw a [news](http://phys.org/news/2016-02-algorithm-accuracy-pedestrian.html) about pedestrian recognition. Deep learning became a buzz word recently. Everyone is open sourcing their deep learning libraries. Combine the deep learning technology and the visual recognition technology seems to be a great idea. Hope to see more of this research.
