import 'package:flutter/material.dart';
import 'goalstat.dart';
import 'match_stat_tile.dart';
import 'matchtile.dart';
import 'matchstat.dart';
import 'soccermodel.dart';

Widget MatchStatBody(
    SoccerMatch match, BuildContext context, Map<String, dynamic> stat) {
  return Column(
    children: [
      Expanded(
        flex: 2,
        child: Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                teamStat("Local Team", match.home.logoUrl, match.home.name,
                    Colors.black),
                goalStat(match.fixture.status.elapsedTime, match.goal.home,
                    match.goal.away, Colors.black),
                teamStat("Visitor Team", match.away.logoUrl, match.away.name,
                    Colors.black),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF4373D9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      match.home.logoUrl,
                      width: 40.0,
                      height: 40.0,
                    ),
                    const Text(
                      "TEAM STATS",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.network(
                      match.away.logoUrl,
                      width: 40.0,
                      height: 40.0,
                    ),
                  ],
                ),
                Expanded(
                    child: Expanded(
                  child: ListView.builder(
                    itemCount: stat["home"][0]["statistics"].length,
                    itemBuilder: (context, index) {
                      return matchStatTile(stat["home"][0]["statistics"][index],
                          stat["away"][0]["statistics"][index]);
                    },
                  ),
                )),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
