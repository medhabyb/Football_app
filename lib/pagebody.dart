import 'package:flutter/material.dart';
import 'goalstat.dart';
import 'matchtile.dart';
import 'matchstat.dart';
import 'soccermodel.dart';

Widget PageBody(List<SoccerMatch> allmatches, BuildContext context) {
  return Column(
    children: [
      Expanded(
        flex: 2,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                teamStat("Local Team", allmatches[0].home.logoUrl,
                    allmatches[0].home.name,Colors.white),
                goalStat(allmatches[0].fixture.status.elapsedTime,
                    allmatches[0].goal.home, allmatches[0].goal.away,Colors.white),
                teamStat("Visitor Team", allmatches[0].away.logoUrl,
                    allmatches[0].away.name,Colors.white),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFf5f5f5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Premier League",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: allmatches.length,
                    itemBuilder: (context, index) {
                      return matchTile(allmatches[index], context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}
