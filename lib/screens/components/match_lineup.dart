import 'package:flutter/material.dart';
import 'package:fmp/data/repository/api_manager.dart';
import 'package:fmp/screens/components/goalstat.dart';
import 'package:fmp/screens/components/match_lineup_body.dart';
import 'package:fmp/screens/components/match_stat_body.dart';
import 'package:fmp/screens/components/matchtile.dart';
import 'package:fmp/screens/components/matchstat.dart';
import 'package:fmp/models/soccermodel.dart';

class MatchLineUp extends StatelessWidget {
  final SoccerMatch match;

  const MatchLineUp({Key? key, required this.match}) : super(key: key);

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
        ),
        body: FutureBuilder(
          future: SoccerApi().getMatchLineUps(match.fixture.id
              .toString()), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData) {
              Map<String, dynamic> stat = snapshot.data as Map<String, dynamic>;
              return TabBarView(
                children: [
                  MatchLineUpBody(match, context, stat),
                  Container(),
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
