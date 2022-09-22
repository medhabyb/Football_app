import 'package:flutter/material.dart';
import 'package:fmp/screens/components/goalstat.dart';
import 'package:fmp/screens/components/match_lineup.dart';
import 'package:fmp/screens/components/match_stat.dart';
import 'package:fmp/screens/components/matchtile.dart';
import 'package:fmp/screens/components/matchstat.dart';
import 'package:fmp/screens/components/search_widget.dart';
import 'package:fmp/screens/team_profile.dart';
import '../../models/soccermodel.dart';

class PageBody extends StatefulWidget {
  const PageBody({Key? key, required this.allmatches, required this.year})
      : super(key: key);
  final List<SoccerMatch> allmatches;
  final String year;

  @override
  _PageBodyState createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  late SoccerMatch clickedMatch;
  late List<SoccerMatch> matches;

  @override
  void initState() {
    clickedMatch = widget.allmatches[0];
    matches = widget.allmatches;
    super.initState();
  }

  String query = '';
  Widget star = Icon(
    Icons.star_border,
  );
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    teamStat("Local Team", clickedMatch.home.logoUrl,
                        clickedMatch.home.name, Colors.white),
                    goalStat(
                        clickedMatch.fixture.status.elapsedTime,
                        clickedMatch.goal.home,
                        clickedMatch.goal.away,
                        Colors.white),
                    teamStat("Visitor Team", clickedMatch.away.logoUrl,
                        clickedMatch.away.name, Colors.white),
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
                color: Color(0xFFf5f5f5),
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
                    const Text(
                      "Premier League",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    buildSearch(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: matches.length,
                        itemBuilder: (context, index) {
                          var homeGoal = matches[index].goal.home;
                          var awayGoal = matches[index].goal.away;
                          if (homeGoal == null) homeGoal = 0;
                          if (awayGoal == null) awayGoal = 0;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                clickedMatch = matches[index];
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MatchStat(
                                          match: matches[index],
                                        )),
                              );
                            },
                            child: buildMatch(matches[index]),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search Team Matches',
        onChanged: searchMatch,
      );

  Widget buildMatch(SoccerMatch match) {
    var homeGoal = match.goal.home;
    var awayGoal = match.goal.away;
    if (homeGoal == null) homeGoal = 0;
    if (awayGoal == null) awayGoal = 0;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TeamProfile(team: match.home)),
                        );
                      },
                      child: Image.network(
                        match.home.logoUrl,
                        width: 48.0,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      match.home.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "$homeGoal - $awayGoal",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TeamProfile(team: match.away)),
                        );
                      },
                      child: Image.network(
                        match.away.logoUrl,
                        width: 48.0,
                      ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchMatch(String query) {
    final ListMatches = widget.allmatches.where((match) {
      final homeName = match.home.name.toLowerCase();
      final awayName = match.away.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return homeName.startsWith(searchLower) ||
          awayName.startsWith(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.matches = ListMatches;
    });
  }
}
