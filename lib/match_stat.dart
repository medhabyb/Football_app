import 'package:flutter/material.dart';
import 'api_manager.dart';
import 'goalstat.dart';
import 'match_stat_body.dart';
import 'matchtile.dart';
import 'matchstat.dart';
import 'soccermodel.dart';

class MatchStat extends StatelessWidget {
  final SoccerMatch match;

  const MatchStat({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: const Text(
          "Statistics",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SoccerApi().getMatcheStatus(
            match.fixture.id.toString(),
            match.home.id.toString(),
            match.away.id.toString()), //Here we will call our getData() method,
        builder: (context, snapshot) {
          //the future builder is very intersting to use when you work with api
          if (snapshot.hasData) {
            print("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
            Map<String, dynamic> stat = snapshot.data as Map<String, dynamic>;
            print(stat["home"][0]["statistics"]);
            print("--------------------------------------------");
            print(stat["away"][0]["statistics"]);
            return MatchStatBody(match, context, stat);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }, // here we will buil the app layout
      ),
    );
  }
}
