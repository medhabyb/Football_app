import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmp/signup.dart';
import 'package:fmp/su.dart';
import 'LocalAuthApi.dart';
import 'auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'fmdp.dart';
import 'nav_bottom.dart';

class mus extends StatefulWidget {
  const mus({Key? key}) : super(key: key);

  @override
  State<mus> createState() => _musState();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class _musState extends State<mus> {
  late String? _email;
  late String? _password;
  bool isLoading = false;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService auth = new AuthService();


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),

              child: Stack(children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: Container(
                      child: Transform.rotate(
                        angle: -pi / 3.5,
                        child: ClipRect(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .5,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xffE6E6E6),
                                  Color(0xff14279B),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: 'Gamix',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff14279B),
                            ),
                            children: [
                              TextSpan(
                                text: 'Prono',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30),
                              ),
                            ]),
                      ),

                      Container(

                        padding: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(50, 120, 50, 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(0xff14279B),
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white,

                        ),
                        child: TextButton(
                            child: (isLoading)
                                ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Color(0xff14279B),
                                  strokeWidth: 1.5,
                                ))
                                : const Text("Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),

                            onPressed: () async {
                              // final isAuthenticated = await LocalAuthApi.authenticate();


                              if (_keyForm.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  UserCredential result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email, password: _password);
                                  User user = result.user;
                                  await Future.delayed(const Duration(seconds: 5));
                                  final isAuthenticated = await LocalAuthApi.authenticate();
                                  if (isAuthenticated){
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavigationBottom()), (route) => false);
                                  }}
                                on FirebaseAuthException catch  (e) {
                                  print('Failed with error code: ${e.code}');
                                  print(e.message);

                                  if (e.code == "wrong-password")
                                  {                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("Information"),
                                            content: Text("Wrong password, try again"));
                                      });
                                  }
                                  else if (e.code == "user-not-found")
                                  {                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("Information"),
                                            content: Text("This Email doesn't exist , try again"));
                                      });
                                  }

                                }
                              }}
                        ),
                      ),
                      Container(

                        padding: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(50, 40, 50, 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(0xff14279B),
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white,

                        ),
                        child: TextButton(
                            child: (isLoading)
                                ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Color(0xff14279B),
                                  strokeWidth: 1.5,
                                ))
                                : const Text("Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),

                            onPressed: () async {
                              // final isAuthenticated = await LocalAuthApi.authenticate();


                              if (_keyForm.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  UserCredential result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email, password: _password);
                                  User user = result.user;
                                  await Future.delayed(const Duration(seconds: 5));
                                  final isAuthenticated = await LocalAuthApi.authenticate();
                                  if (isAuthenticated){
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavigationBottom()), (route) => false);
                                  }}
                                on FirebaseAuthException catch  (e) {
                                  print('Failed with error code: ${e.code}');
                                  print(e.message);

                                  if (e.code == "wrong-password")
                                  {                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("Information"),
                                            content: Text("Wrong password, try again"));
                                      });
                                  }
                                  else if (e.code == "user-not-found")
                                  {                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("Information"),
                                            content: Text("This Email doesn't exist , try again"));
                                      });
                                  }

                                }
                              }}
                        ),
                      ),
                      Container(

                        padding: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(50, 40, 50, 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(0xff14279B),
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white,

                        ),
                        child: TextButton(
                            child: (isLoading)
                                ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Color(0xff14279B),
                                  strokeWidth: 1.5,
                                ))
                                : const Text("Login",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),

                            onPressed: () async {
                              // final isAuthenticated = await LocalAuthApi.authenticate();


                              if (_keyForm.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  UserCredential result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email, password: _password);
                                  User user = result.user;
                                  await Future.delayed(const Duration(seconds: 5));
                                  final isAuthenticated = await LocalAuthApi.authenticate();
                                  if (isAuthenticated){
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavigationBottom()), (route) => false);
                                  }}
                                on FirebaseAuthException catch  (e) {
                                  print('Failed with error code: ${e.code}');
                                  print(e.message);

                                  if (e.code == "wrong-password")
                                  {                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("Information"),
                                            content: Text("Wrong password, try again"));
                                      });
                                  }
                                  else if (e.code == "user-not-found")
                                  {                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text("Information"),
                                            content: Text("This Email doesn't exist , try again"));
                                      });
                                  }

                                }
                              }}
                        ),
                      ),


                    ],
                  ),
                ),
              ]),
        ),
      ));

  }
}
