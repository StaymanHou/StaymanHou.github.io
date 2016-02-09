---
layout: post
title: "Visual Recognition / Computer Vision as of Feb 2016"
date: 2016-02-08 21:09:02 +0000
comments: true
categories: [Computer Vision, Visual Recognition]
keywords: "computer vision, visual recognition, OpenCV, IBM Watson, Google cloud vision, Clarifai, Valossa"
---
Recently I did some research on computer vision aka visual recognition due to a project. Surprisingly, I found out that this is yet another cutting-edge research field. Big companies are in this market. Meanwhile, new startups are also pushing the tech limit and trying to get a piece.

<!-- more -->

#First of all, what is computer vision?

Computer vision is a field that includes methods for acquiring, processing, analyzing, and understanding images and, in general, high-dimensional data from the real world in order to produce numerical or symbolic information. in the forms of decisions. - [Wiki](https://en.wikipedia.org/wiki/Computer_vision)

#Here are the products I found that offer visual recognition as a service.

## IBM Watson

IBM has been promoting Watson for a while. You probably have heard about that. One of its use cases is visual recognition. You can try out their service [here](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/visual-recognition.html). Their demo should be good enough to demonstrate the functionality. However, it's a little disappointing to me, because it's essentially just a classifier. You through in a bunch of training images. e.g. Image #1-50 are apples. Image #51-100 are bananas. Image #101-150 are random. After training, Watson can tell you whether an image contains apple, banana, or none of them.

## Google Cloud Vision

Unfortunately, it's still under limited preview. Therefore, I didn't have a chance to try it yet. However, according to its description page, it's a lot more powerful than Watson. It can detect objects, inappropriate content, perform sentiment analysis, extract text. In addition, it looks like you don't have to train the model. Google have already done the training for you. Which will probably make your life a lot easier. Check out their service [here](https://cloud.google.com/vision/)

## Clarifai

[Clarifai](http://www.clarifai.com/) These folks are focused. They also developed the use cases for the ecosystem surrounding the visual recognition technology. Apart from images, they can also process videos.

## Valossa

[Valossa](http://www.valossa.com/) Another startup focused on Video recognition and search. The interesting feature they are promoting is that it can *understand* the videos. It processes visual as well as audio. And their search engine feels powerful which can *understand* the search queries instead of traditional texted based search.

# Summary

Roughly speaking, all these solutions do the same thing. Convert videos & audios into text. However, there are other use cases for computer vision. For example, in my case, I need to detect, but also LOCATE, specified object in images. As a result, I found [OpenCV](http://opencv.org/). That provides more flexibility compared to the services above, but also requires extra work to make it work. I'll cover a getting started tutorial in [another blog post](http://blog.staymanhou.com/blog/2016/02/08/opencv-object-detection-tutorial-getting-started-by-training-your-own-car-detector/), as well as latest research update in the field.
