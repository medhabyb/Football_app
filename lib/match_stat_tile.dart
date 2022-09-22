import 'package:flutter/material.dart';
import 'match_stat.dart';
import 'soccermodel.dart';

Widget matchStatTile(Map<String, dynamic> home, Map<String, dynamic> away) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          home["value"] != null ? home["value"].toString() : "0",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Text(
          home["type"],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
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
  );
}
