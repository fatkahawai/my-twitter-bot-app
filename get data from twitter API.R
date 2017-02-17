# -----------------------------------------------------------------------------
# get data from Twitter
#
# new - using Rtweet library
# https://github.com/mkearney/rtweet
#
# Rtweet API
# ----------
# create_token() - OAuth
# clean_tweets
# create_token
# get_favorites
# get_followers 
# get_friends 
# get_timeline
# get_tokens
# get_trends
# lookup_statuses
# lookup_users 
# meta_data
# ext_cursor 
# parse_stream 
# post_tweet
# rate_limit 
# rtweet 
# save_as_csv
# search_tweets
# search_users
# stream_tweets
# trends_available
# ts_plot
# tweets_data 
# users_data
# utf8_tweets
# -----------------------------------------------------------------------------
#
# First, you'll need to create a Twitter app at http://apps.twitter.com/app. 
# save the keys, and For the 'callback URL' field, make sure to enter: http://127.0.0.1:1410
#
# Keys from my "bob-bot" Twitter application - here https://apps.twitter.com/app/13073870
# get these from the App Keys tab of your App homepage on twitter 
#
appName <- "bob-bot" # whatever you named your app on twitter
consumerKey <-  "xxx" 
consumerSecret <- "xxx"
# accessToken <- "xxx"
# accessTokenSecret <- "xxx"
# -----------------------------------------------------------------------------

# install.packages("rtweet")
library(rtweet)

myTwitterAccount <- "bobvondrummond"

# FIRST Authenticate with Twitter and get a token to use in subsequent API calls
#
twitter_token <- create_token(app = appName, 
  consumer_key = consumerKey,
  consumer_secret = consumerSecret)


# ..............................
# print a list of my 10 most recent tweets

tw <- search_tweets(myTwitterAccount, n = 1000, token = twitter_token) # , lang = "en")


# lets slice the data frame returned 
# e.g. get the list of tweets that were retweeted, first as a dataframe
#
mytweets <- tw$text[!tw$is_retweet]      	# filter out retweets
mytweets <- mytweets[!is.na(mytweets)]	 	# filter out where tweet text is NA
mytweets <- mytweets[length(mytweets) >0]	# filter out empty tweets

# now convert the dataframe/list into a vector
as.character(mytweets)

length(mytweets) <- min(length(mytweets),10)  # truncate to max 10 tweets

message("my 10 most recent tweets that were not retweets: ")
print(mytweets)

# ..............................
# print a list of the followers names

followers <- get_followers(myTwitterAccount, n="all", token= twitter_token)
#           ids
# 1 7.552642e+17
# 2 2.992678e+09

# class(followers)
# [1] "data.frame"

# slice / filter the returned dataset to get a vector with non-NA ids only.
# there are multiple ways to slice a dataset:
#
# f <- followers[!is.na(followers$ids),1]
f <- followers$ids[!is.na(followers$ids)]

# now look up those users' full profile details
#
followerDetails <- lookup_users(f, token= twitter_token)

followerNames <- followerdetails$screen_name
# [1] "KamiSchools"    "wearableLED"    "PlayTheMove"    "transformNZ"    "CJthunderthumb"
# [6] "earlie_dariano"

message("my followers: ")
print(followerNames)

