import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmp/signin.dart';
import 'package:fmp/signup.dart';
import 'package:fmp/veru.dart';
import 'auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'fmdp.dart';

class Su extends StatefulWidget {
  const Su({Key? key}) : super(key: key);

  @override
  State<Su> createState() => _SuState();
}



class _SuState extends State<Su> {
  late String? _email;
  late String? _password;
  late String? _nom;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();


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
                      const SizedBox(height: 70),
                      Column(
                        children: <Widget>[
                          Container(
                            //margin: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    onChanged: (String? value) {
                                      _email = value;
                                    },
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please type your email";
                                      } else if (value.isValidEmail() ==
                                          false) {
                                        return "wrong email";
                                      }
                                    })
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _pass,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    _password = value;
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please type your password";
                                    } else if (value.length < 5) {
                                      return "password mus have +5 char";
                                    } else {
                                      return null;
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _confirmPass,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Confirm Password",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    _password = value;
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please confirm your password";
                                    } else if (value.length < 5) {
                                      return "password mus have +5 char";
                                    }
                                    else if (value!= _pass.text) {
                                      return "Password not matching!! ";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(

                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  onChanged: (String? value) {
                                    _nom = value;
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please type your name";
                                    }  else {
                                      return null;
                                    }
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(50, 40, 50, 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(0xff14279B),
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          color: Colors.white
                        ),
                        child: TextButton(
                            child: Text("Create account",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {

                              try {
                                if (_keyForm.currentState!.validate()) {
                                  UserCredential result = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);

                                  User user = result.user;
                                  user.updateProfile(displayName : _nom );

                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VerifyScreen()));







                                }
                              } on FirebaseAuthException catch  (e) {
                                print('Failed with error code: ${e.code}');
                                print(e.message);


                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text("Information"),
                                          content: Text(e.message.toString()));
                                    });
                              }
                            }),
                      ),



                    ],
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
