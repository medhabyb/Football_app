import 'package:flutter/material.dart';
import 'package:fmp/screens/components/match_stat.dart';
import '../../models/soccermodel.dart';

Widget matchTile(SoccerMatch match, BuildContext context) {
  var homeGoal = match.goal.home;
  var awayGoal = match.goal.away;
  if (homeGoal == null) homeGoal = 0;
  if (awayGoal == null) awayGoal = 0;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MatchStat(
                  match: match,
                )),
      );
    },
    child: Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.network(
                  match.home.logoUrl,
                  width: 48.0,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  match.home.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Expanded(
              child: Text(
                "${homeGoal} - ${awayGoal}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Column(
              children: [
                Image.network(
                  match.away.logoUrl,
                  width: 48.0,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  match.away.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
