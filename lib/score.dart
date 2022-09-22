import 'package:flutter/material.dart';
import 'package:fmp/auth.dart';
import 'api_manager.dart';
import 'pagebody.dart';
import 'soccermodel.dart';



class SoccerApp extends StatefulWidget {
  @override
  _SoccerAppState createState() => _SoccerAppState();
}

class _SoccerAppState extends State<SoccerApp> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4373D9),
      appBar: AppBar(
        backgroundColor: Color(0xFF4373D9),
        elevation: 0.0,
        title: const Text(
          "SOCCERBOARD",
          style: TextStyle(color: Colors.white),
        ),
          actions:<Widget> [
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),

                onPressed: () async
                {
                  await _auth.signOut().then((value) => Navigator.popAndPushNamed(context, '/signin'));

                })
          ]




      ),
      //now we have finished the api service let's call it
      //Now befo re we create Our layout let's create our API service
      body: FutureBuilder(
        future: SoccerApi()
            .getAllMatches(), //Here we will call our getData() method,
        builder: (context, snapshot) {
          //the future builder is very intersting to use when you work with api
          if (snapshot.hasData) {
            List<SoccerMatch> allmatches = snapshot.data as List<SoccerMatch>;
            print(allmatches);
            return PageBody(allmatches, context);
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
