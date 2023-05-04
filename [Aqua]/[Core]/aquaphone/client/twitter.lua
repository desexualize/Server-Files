--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================

RegisterNetEvent("AQUA:twitter_getTweets")
AddEventHandler("AQUA:twitter_getTweets", function(tweets)
  SendNUIMessage({event = 'twitter_tweets', tweets = tweets})
end)

RegisterNetEvent("AQUA:twitter_getFavoriteTweets")
AddEventHandler("AQUA:twitter_getFavoriteTweets", function(tweets)
  SendNUIMessage({event = 'twitter_favoritetweets', tweets = tweets})
end)

RegisterNetEvent("AQUA:twitter_newTweets")
AddEventHandler("AQUA:twitter_newTweets", function(tweet)
  SendNUIMessage({event = 'twitter_newTweet', tweet = tweet})
end)

RegisterNetEvent("AQUA:twitter_updateTweetLikes")
AddEventHandler("AQUA:twitter_updateTweetLikes", function(tweetId, likes)
  SendNUIMessage({event = 'twitter_updateTweetLikes', tweetId = tweetId, likes = likes})
end)

RegisterNetEvent("AQUA:twitter_setAccount")
AddEventHandler("AQUA:twitter_setAccount", function(username, password, avatarUrl)
  SendNUIMessage({event = 'twitter_setAccount', username = username, password = password, avatarUrl = avatarUrl})
end)

RegisterNetEvent("AQUA:twitter_createAccount")
AddEventHandler("AQUA:twitter_createAccount", function(account)
  SendNUIMessage({event = 'twitter_createAccount', account = account})
end)

RegisterNetEvent("AQUA:twitter_showError")
AddEventHandler("AQUA:twitter_showError", function(title, message)
  SendNUIMessage({event = 'twitter_showError', message = message, title = title})
end)

RegisterNetEvent("AQUA:twitter_showSuccess")
AddEventHandler("AQUA:twitter_showSuccess", function(title, message)
  SendNUIMessage({event = 'twitter_showSuccess', message = message, title = title})
end)

RegisterNetEvent("AQUA:twitter_setTweetLikes")
AddEventHandler("AQUA:twitter_setTweetLikes", function(tweetId, isLikes)
  SendNUIMessage({event = 'twitter_setTweetLikes', tweetId = tweetId, isLikes = isLikes})
end)



RegisterNUICallback('twitter_login', function(data, cb)
  TriggerServerEvent('AQUA:twitter_login', data.username, data.password)
end)

RegisterNUICallback('twitter_getTweets', function(data, cb)
  TriggerServerEvent('AQUA:twitter_getTweets')
end)

RegisterNUICallback('twitter_getFavoriteTweets', function(data, cb)
  TriggerServerEvent('AQUA:twitter_getFavoriteTweets')
end)

RegisterNUICallback('twitter_postTweet', function(data, cb)
  TriggerServerEvent('AQUA:twitter_postTweets', data.message)
end)

RegisterNUICallback('twitter_postTweetImg', function(data, cb)
  TriggerServerEvent('AQUA:twitter_postTweets', data.username or '', data.password or '', data.message)
end)

RegisterNUICallback('twitter_toggleLikeTweet', function(data, cb)
  TriggerServerEvent('AQUA:likeTweet',data.tweetId)
end)

RegisterNUICallback('twitter_setAvatarUrl', function(data, cb)
    TriggerServerEvent("AQUA:setTwitterAvatar", data.avatarUrl)
end)
