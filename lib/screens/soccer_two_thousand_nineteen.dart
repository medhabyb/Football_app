import 'package:flutter/material.dart';
import 'package:fmp/data/repository/api_manager.dart';
import 'package:fmp/screens/components/pagebody.dart';
import 'package:fmp/screens/favorites.dart';
import 'package:fmp/screens/soccer_two_thousand_eighteen.dart';
import 'package:fmp/screens/soccer_two_thousand_seventeen.dart';
import 'package:fmp/screens/soccer_two_thousand_twenty.dart';
import 'package:fmp/screens/soccer_two_thousand_twenty_one.dart';
import 'package:fmp/models/soccermodel.dart';
import 'package:fmp/screens/standings2019.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../nav_bottom.dart';

class SoccerTwoThousandNineteen extends StatefulWidget {
  const SoccerTwoThousandNineteen({Key? key}) : super(key: key);

  @override
  _SoccerTwoThousandNineteenState createState() =>
      _SoccerTwoThousandNineteenState();
}

class _SoccerTwoThousandNineteenState extends State<SoccerTwoThousandNineteen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Year 2019 SOCCERBOARD',
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
            const Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: const Text(
                'Favorites',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Favorite(prefs: prefs),
                  ),
                );
              },
            ),
            const Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: const Text(
                'HOME',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                    const NavigationBottom(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF4373D9),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Standings2019(),
                ),
              );
            },
            icon: Icon(Icons.list),
          ),
        ],
        backgroundColor: Color(0xFF4373D9),
        elevation: 0.0,
        title: const Text(
          "SOCCERBOARD",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      //now we have finished the api service let's call it
      //Now befo re we create Our layout let's create our API service
      body: FutureBuilder(
        future: SoccerApi()
            .getAllMatches2019(), //Here we will call our getData() method,
        builder: (context, snapshot) {
          //the future builder is very intersting to use when you work with api
          if (snapshot.hasData) {
            List<SoccerMatch> allmatches = snapshot.data as List<SoccerMatch>;
            print(allmatches);
            return PageBody(allmatches: allmatches, year: "2019");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }, // here we will buil the app layout
      ),
    );
  }
}
