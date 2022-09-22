import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmp/signup.dart';
import 'auth.dart';
import 'package:firebase_core/firebase_core.dart';

class modf extends StatefulWidget {
  const modf({Key? key}) : super(key: key);

  @override
  State<modf> createState() => _SigninState();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class _SigninState extends State<modf> {
  late String? _email;
  late String? _password;

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
          child: Form(
              key: _keyForm,
              child: Stack(children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .20,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: Container(
                      child: Transform.rotate(
                        angle: -pi / 3.5,
                        child: ClipRect(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .6,
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
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .3),
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
                      const SizedBox(height: 100),
                      Column(
                        children: <Widget>[

                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(50, 20, 50, 0),
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
                                child: Text("Update email",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {

                                  Navigator.pushNamed(context, "/upe");
                                }),
                          ),
                          SizedBox(height: 50,),



                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(50, 20, 50, 0),
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
                              child: Text("Update PDW",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                Navigator.pushNamed(context, "/upm");
                              })),

                          SizedBox(height: 50,),


                    ],
                  ),
                ]),
  )]),
        ),
      ),
    ),
    );
  }
}
