import 'package:flutter/material.dart';
import 'package:fmp/models/soccermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamProfile extends StatefulWidget {
  const TeamProfile({Key? key, required this.team}) : super(key: key);
  final Team team;

  @override
  _TeamProfileState createState() => _TeamProfileState();
}

class _TeamProfileState extends State<TeamProfile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(
            widget.team.logoUrl,
            width: 250.0,
          ),
          Text(
            widget.team.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 32.0,
                fontWeight: FontWeight.bold),
          ),
          FlatButton(
            color: Colors.red,
            splashColor: Colors.black12,
            onPressed: () async {
              print("aaaaaaaaaaaaaaaaaaa");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (prefs.containsKey('fav')) {
                if (prefs.getString('fav')!.contains(widget.team.name)) {
                  print("--------------------------------------");
                  String favo = prefs
                      .getString('fav')
                      .toString()
                      .replaceAll(widget.team.name + ":", "");

                  await prefs.setString('fav', favo);
                } else {
                  print("--------------------------------------");
                  await prefs.setString(
                      'fav', prefs.getString('fav')! + widget.team.name + ":");
                }
              } else {
                await prefs.setString('fav', " ");
              }
              print(prefs.getString('fav'));
              print("--------------------------------------");
              print(prefs.getString('fav').toString().split(":"));
            },
            child: const Text(
              "Add to favorites",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
