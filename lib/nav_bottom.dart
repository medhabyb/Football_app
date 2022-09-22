import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fmp/profile.dart';

import 'package:fmp/screens/soccer_two_thousand_twenty_one.dart';
import 'package:fmp/signin.dart';
import 'package:fmp/vid.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'homee.dart';
import 'mailing.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int _currentIndex = 0;
  final List<Widget> _interfaces = [ homee(),const SoccerTwoThousandTwentyOne(),  home() ];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.grey,
              bottomOpacity: 0,
              elevation: 0,
            ),
            SizedBox(height: 20),


            ListTile(
              hoverColor: Colors.blue,
              dense: true,
              visualDensity: VisualDensity(vertical: -4),
              leading: Icon(
                Icons.personal_video,
                color: Colors.black,
              ),
              title: Text('Play of the week'),
              onTap: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => vid()));},
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              hoverColor: Colors.blue,
              dense: true,
              visualDensity: VisualDensity(vertical: -4),
              leading: Icon(
                Icons.mail,
                color: Colors.black,
              ),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => habeb()));
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  hoverColor: Colors.blue,
                  dense: true,
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: Text('Logout'),
                    onTap: () async {
                      final provider = Provider.of<AuthService>(context, listen: false);
                      final isON = await provider.signOutFromGoogle();
                      Navigator.of(context).
                      pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Signin()), (route) => false);
                    } ,

                ),


              ),
            ),
            SizedBox(height: 10),


          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Gamix Prono", style: TextStyle(color:Colors.black),)

        ,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _interfaces[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              label: "Match",
              icon: Icon(Icons.article)
          ),
          BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.account_circle)
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
