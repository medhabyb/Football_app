import 'package:flutter/material.dart';
import 'package:fmp/screens/components/goalstat.dart';
import 'package:fmp/screens/components/match_stat_tile.dart';
import 'package:fmp/screens/components/matchtile.dart';
import 'package:fmp/screens/components/matchstat.dart';
import '../../models/soccermodel.dart';

Widget MatchLineUpBody(
    SoccerMatch match, BuildContext context, Map<String, dynamic> lineUp) {
  return Column(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
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
                        "Starting Lineups",
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
                    child: ListView.builder(
                      itemCount: lineUp["homeLineup"].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        child: Text(
                                          lineUp["homeLineup"][index]["player"]
                                                  ["number"]
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        lineUp["homeLineup"][index]["player"]
                                            ["name"],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        lineUp["awayLineup"][index]["player"]
                                            ["name"],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        lineUp["awayLineup"][index]["player"]
                                                ["number"]
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
