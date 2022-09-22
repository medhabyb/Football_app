import 'dart:convert';

import 'package:http/http.dart';
import 'soccermodel.dart';

class SoccerApi {
  //now let's set our variables
  //first : let's add the endpoint URL
  // we will get all the data from api-sport.io
  // we will just change our endpoint
  //the null means that the match didn't started yet
  //let's fix that
  final String apiUrl = "https://v3.football.api-sports.io/fixtures";
  //In our tutorial we will only see how to get the live matches
  //make sure to read the api documentation to be ables too understand it

  // you will find your api key in your dashboard
  //so create your account it's free
  //Now let's add the headers
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    //Always make sure to check the api key and the limit of a request in a free api
    'x-rapidapi-key': "0d9311fa7403d16f3fd59f6d6e3eb61c"
  };

  //Now we will create our method
  //but before this we need to create our model

  //Now we finished with our Model
  Future<List<SoccerMatch>> getAllMatches() async {
    Response res =
        await get(apiUrl + "?season=2021&league=39", headers: headers);
    var body;

    if (res.statusCode == 200) {
      // this mean that we are connected to the data base
      body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      print("Api service: ${body}"); // to debug
      List<SoccerMatch> matches = matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();

      return matches;
    } else {
      throw ("some error");
    }
  }

  Future<Map<String, dynamic>> getMatcheStatus(
      String fixture, String idhome, String idaway) async {
    Response reshome = await get(
        apiUrl + "/statistics?fixture=$fixture&team=$idhome",
        headers: headers);
    var homebody;
    Response resaway = await get(
        apiUrl + "/statistics?fixture=$fixture&team=$idaway",
        headers: headers);
    var awaybody;

    if (reshome.statusCode == 200) {
      // this mean that we are connected to the data base
      homebody = jsonDecode(reshome.body);
      awaybody = jsonDecode(resaway.body);
      Map<String, dynamic> statsList = {
        "home": homebody['response'],
        "away": awaybody['response']
      };
      return statsList;
    } else {
      throw ("some error");
    }
  }
}
