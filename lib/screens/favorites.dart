import 'package:flutter/material.dart';
import 'package:fmp/screens/soccer_two_thousand_eighteen.dart';
import 'package:fmp/screens/soccer_two_thousand_nineteen.dart';
import 'package:fmp/screens/soccer_two_thousand_seventeen.dart';
import 'package:fmp/screens/soccer_two_thousand_twenty.dart';
import 'package:fmp/screens/soccer_two_thousand_twenty_one.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key, required this.prefs}) : super(key: key);
  final SharedPreferences prefs;
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    var list = widget.prefs.getString('fav').toString().split(":");
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF4373D9),
              ),
              child: Text(
                'Favorites',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'Year 2021',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const SoccerTwoThousandTwentyOne(),
                  ),
                );
              },
            ),
            const Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: const Text(
                'Year 2020',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const SoccerTwoThousandTwenty(),
                  ),
                );
              },
            ),
            const Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: const Text(
                'Year 2019',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const SoccerTwoThousandNineteen(),
                  ),
                );
              },
            ),
            const Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: const Text(
                'Year 2018',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const SoccerTwoThousandEighteen(),
                  ),
                );
              },
            ),
            const Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: const Text(
                'Year 2017',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const SoccerTwoThousandSeventeen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Favorite"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i in list)
              if (i != "" && i != " ")
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/" + i.replaceAll(" ", "") + ".png",
                            width: 80.0,
                            height: 80.0,
                          ),
                          const SizedBox(
                            width: 24.0,
                          ),
                          Text(
                            i,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 28.0,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }
}
