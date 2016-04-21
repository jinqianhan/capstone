#setwd("./Capstone/Coursera-SwiftKey/final/en_US/")
library(ggplot2); library(reshape2); library(tm); library(slam); library(data.table); library(RWeka); library(magrittr)
set.seed(314)

## read in data from a connection, and convert data to consistent encoding format.
twitter <- readLines("en_US.twitter.txt", encoding = "UTF-8")
twitter <- iconv(twitter, "UTF-8", "ascii", sub = "")
twitter <- sample(twitter, length(twitter) * 0.02)

blogs <- readLines("en_US.blogs.txt", encoding = "UTF-8")
blogs <- iconv(blogs, "UTF-8", "ascii", sub = "")
blogs <- sample(blogs, length(blogs) * 0.02)


conn <- file("en_US.news.txt",open="rb")
news <-readLines(conn, encoding="UTF-8")
close(conn)
rm(conn)
news <- iconv(news, "UTF-8", "ascii", sub = "")
news <- sample(news, length(news) * 0.02)

cdata <- c(twitter, blogs, news)



profanity <- scan("profanity.txt", what = "" ,sep = "\n")

convCorpus <- function(corp) {
        corpus <- VCorpus(VectorSource(corp))
        corpus <- tm_map(corpus,  content_transformer(tolower))
        # corpus <- tm_map(corpus, removeWords, stopwords("english"))  # rm stopwords
        corpus <- tm_map(corpus, removePunctuation)
        corpus <- tm_map(corpus, removeNumbers)
        corpus <- tm_map(corpus, removeWords, profanity)
        # corpus <- tm_map(corpus, stemDocument, language = "english")
        corpus <- tm_map(corpus, stripWhitespace)
        corpus <- tm_map(corpus, PlainTextDocument)
        return(corpus) 
}




cc <- convCorpus(cdata)
cc <- tm_map(cc, PlainTextDocument)

tokenizer <- function(datadoc, n) {
        ngramtoken <- function(x) {
                NGramTokenizer(x, Weka_control(min=n, max=n))
        }
        ngram <- TermDocumentMatrix(datadoc, control = list(tokenize = ngramtoken))
        return(ngram)
}



c2 <- tokenizer(cc, 2)
c3 <- tokenizer(cc, 3)
c4 <- tokenizer(cc, 4)

tdmToFreq <- function(tdm) {
        freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
        word <- names(freq)
        data.table(word=word, freq=freq)
}

processGram <- function(dt) {
        dt[, c("pre", "cur"):=list(unlist(strsplit(word, "[ ]+?[a-z]+$")), 
                                   unlist(strsplit(word, "^([a-z]+[ ])+"))[2]), 
           by=word]
}

#finds max frequency ngram and returns word
maxfreq <- function(freqlist, wd) {
        if (sum(freqlist[freqlist$pre == wd]$freq) == 0)
                return (0)
        else {
                return (freqlist[freqlist$pre == wd & freqlist$freq == max(freqlist[freqlist$pre == wd]$freq)])
        }
}

#corpus bigram
cFreq2 <- tdmToFreq(c2)
processGram(cFreq2)
# de_max <- max(cFreq2[pre=="right"]$freq)
# cFreq2[pre == "right" & freq == de_max]
head(cFreq2)

predict2 <- function(word) {
        if (is.null(ncol(maxfreq(cFreq2, word))))
                return (NULL)
        return (maxfreq(cFreq2, word)$cur[1])
}


#corpus trigram
cFreq3 <- tdmToFreq(c3)
processGram(cFreq3)
# cFreq3[pre == "right" & freq == de_max]
head(cFreq3)
predict3 <- function(word) {
        if (is.null(ncol(maxfreq(cFreq3, word))))
                return (NULL)
        return (maxfreq(cFreq3, word)$cur[1])
}



#corpus 4gram
cFreq4 <- tdmToFreq(c4)
processGram(cFreq4)
# cFreq4[pre == "right" & freq == de_max]
head(cFreq4)
predict4 <- function(word) {
        if (is.null(ncol(maxfreq(cFreq4, word))))
                return (NULL)
        return (maxfreq(cFreq4, word)$cur[1])
}


predict <- function(input){
        if (input == "" || input == " ")
                return("Warning, no input")
        pred <- NULL
        input <- tolower(input)
        input <- removeNumbers(input)
        input <- removePunctuation(input)
        input <- stripWhitespace(input)
        input <- rev(unlist(strsplit(input," ")))
        #if (sapply(gregexpr("\\W+", input), function(x) sum(x>0)) +1 > 2){
        if (length(input) > 2) {
                input4 <- paste(input[3], input[2], input[1], sep = ' ')
                input3 <- paste(input[2], input[1], sep = ' ')
                input2 <- input[1]
                if (is.null(predict4(input4)) && is.null(predict3(input3))) {
                        pred <- predict2(input2)
                }
                else if (!(is.null(predict4(input4)))) {
                        pred <- predict4(input4)
                }
                else {
                        pred <- predict3(input3)
                        
                }
        }
        
        if (length(input) == 2) {
                input3 <- paste(input[2], input[1], sep = ' ')
                input2 <- input[1]
                if (is.null(predict3(input3)) && is.null(predict2(input2))) {
                        pred <- predict2(input2)
                }
                else {
                        pred <- predict3(input3)
                }
        }
        
        if (length(input) == 1) {
                input2 <- input[1]
                pred<-predict2(input2)
        }
        if (is.null(pred))
                return("unable to predict")
        else 
                return (pred)
}
