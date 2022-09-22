import 'package:flutter/material.dart';
import 'package:fmp/screens/components/match_stat.dart';
import '../../models/soccermodel.dart';

Widget matchStatTile(Map<String, dynamic> home, Map<String, dynamic> away) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
    child: Column(
      children: [
        Text(
          home["type"],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  home["value"] != null ? home["value"].toString() : "0",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: 100.0,
                    child: LinearProgressIndicator(
                      value: (() {
                        if (home["value"] != null) {
                          if (home["value"] is String) {
                            String num = home["value"]
                                .substring(0, home["value"].length - 1);
                            return double.parse(num) * .10;
                          } else {
                            if (home["value"] < 10) {
                              return home["value"] * .10;
                            } else if (home["value"] < 50) {
                              return home["value"] * .01;
                            } else {
                              return home["value"] * .001;
                            }
                          }
                        } else {
                          return 0 * .10;
                        }
                      }()),
                      color: Colors.black,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 100.0,
                  child: LinearProgressIndicator(
                    value: (() {
                      if (away["value"] != null) {
                        if (away["value"] is String) {
                          String num = away["value"]
                              .substring(0, away["value"].length - 1);
                          return double.parse(num) * .10;
                        } else {
                          if (home["value"] < 10) {
                            return home["value"] * .10;
                          } else if (home["value"] < 50) {
                            return home["value"] * .01;
                          } else {
                            return home["value"] * .001;
                          }
                        }
                      } else {
                        return 0 * .10;
                      }
                    }()),
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  away["value"] != null ? away["value"].toString() : "0",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
