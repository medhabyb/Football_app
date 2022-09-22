import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'nav_bottom.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(

            children: <Widget>[
              SizedBox(height: 270),
        Container(
          alignment: Alignment.center,
        child: SpinKitCircle(
          size: 100,
            color:Color(0xff14279B) ,
        ),
      ),
              SizedBox(height: 50),
        Container(
          alignment: Alignment.center,
        child: Text(
            'An email has been sent to ${user.email} please verify'),
      ),
      ],
    ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavigationBottom()), (route) => false);
    }

  }
}