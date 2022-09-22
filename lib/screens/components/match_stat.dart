import 'package:flutter/material.dart';
import 'package:fmp/data/repository/api_manager.dart';
import 'package:fmp/screens/components/goalstat.dart';
import 'package:fmp/screens/components/match_lineup_body.dart';
import 'package:fmp/screens/components/match_stat_body.dart';
import 'package:fmp/screens/components/matchtile.dart';
import 'package:fmp/screens/components/matchstat.dart';
import 'package:fmp/models/soccermodel.dart';

class MatchStat extends StatelessWidget {
  final SoccerMatch match;

  const MatchStat({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "Statistics",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [
              const Tab(
                text: "Match",
              ),
              const Tab(
                text: "LineUp",
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: SoccerApi().getMatcheStatus(
              match.fixture.id.toString(),
              match.home.id.toString(),
              match.away.id
                  .toString()), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData) {
              print("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
              Map<String, dynamic> stat = snapshot.data as Map<String, dynamic>;
              print(stat["home"][0]["statistics"]);
              print("--------------------------------------------");
              print(stat["away"][0]["statistics"]);
              return TabBarView(
                children: [
                  MatchStatBody(match, context, stat),
                  MatchLineUpBody(match, context, stat),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }, // here we will buil the app layout
        ),
      ),
    );
  }
}
