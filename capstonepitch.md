Coursera Data Science Capstone Project
========================================================
author: Hank
date: 1/29/2016
transition: rotate
font-family: 'Helvetica'

A simple but effective [word predictor](https://jinqianhan.shinyapps.io/capstone/) for simple sentences and phrases

Objectives
========================================================

The main goal of this project was to develop a shiny application for real world questions - word prediction based on context of the sentence

In order to successfully build the algorithm and product, we need to integrate skills from every course of the specialization from exploratory data analysis, data cleaning, machine learning, and data product building.

To do this, we must understand the natural language processing data type and data sets that they are normally presented (as collection of twitter, blog posts, news headlines, etc)

Methods
========================================================

The app works by sampling a fraction of 3 datasets from twitter tweets, blog posts, and news headlines, and then combines them to form a corpus

After a corpus is generated, and cleaned for profanity, case, punctuation, and numbers, we utilize a tokenizer function that converts the corpus into bigrams, tri-grams, and quad-grams.

We then utilize a function to convert those n-grams into a frequency dictionary, which is then referenced when the user types in a word, phrase, or sentence

The algorithm used to determine the next word is using the stupid backoff model, where the app first takes the last 3 words of the sentence and checks it against the 4-gram frequency table. If not present, then it backs off to check the next lower n-gram frequency dictionary.

User interface
========================================================

The user interface of this application is simple and easy to use. Because it processes the frequency tables in the app, it may take 1 or 2 minutes for the app to load. Press 'enter' or submit to predict the next word.

![App Screenshot](screenshot.png)


For additional information
========================================================
- The word predictor app is hosted on shinyapps.io: [https://jinqianhan.shinyapps.io/capstone/](https://jinqianhan.shinyapps.io/capstone/)

- The code for this application, related data, presentations  etc. are on this GitHub repo: [https://github.com/jinqianhan/capstone](https://github.com/jinqianhan/capstone)

- This slide deck is located on rpubs: [http://rpubs.com/jinqianhan/capstone](http://rpubs.com/jinqianhan/capstone)

I hope you find the app useful!

 
 
