import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/models/api/user.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:twitter_api/twitter_api.dart';
import 'dart:convert';

// Used for the decode
import 'dart:convert';
var tweets;
var res;

// ignore: non_constant_identifier_names
class Twitter {
  static Future LoadTweets() async {
    // Setting placeholder api keys
    String consumerApiKey = "cmoztpo7eFsVZt7M2QQLdRo57";
    String consumerApiSecret = "pqDVprbXokCLU5DPNOGCj8Cv756u1nWNG5MrVjho4751WE5rlj";
    String accessToken = "1170326033205100545-cajORkQW2lKIu9frEyYl8jWDsx3or6";
    String accessTokenSecret = "vtRO2ZHrY2UVw9z7mifSeiD8vEbPIRq7gd0gu0pIIp0mL";

    // Creating the twitterApi Object with the secret and public keys
    // These keys are generated from the twitter developer page
    // Dont share the keys with anyone
    final _twitterOauth = new twitterApi(
        consumerKey: consumerApiKey,
        consumerSecret: consumerApiSecret,
        token: accessToken,
        tokenSecret: accessTokenSecret
    );
    Future searchTweets(String query) async {
      Future twitterRequest = _twitterOauth.getTwitterRequest(
        // Http Method
        "GET", //GET request
        // Endpoint you are trying to reach
        "search/tweets.json",
        // The options for the request
        options: {
          "q": query,
          "lang": "en", //english
          "count": "100", //100 tweet Max amount for free
          "tweet_mode": "extended", // Used to prevent truncating tweets
        },
      );

      // Make the request to twitter

      // Wait for the future to finish
      res = await twitterRequest;

      // Print off the response
      tweets = jsonDecode(res.body);

      print(tweets[0]['full_text']);

      // Convert the string response into something more useable
    }
    searchTweets("Jaipur");
  }
}


