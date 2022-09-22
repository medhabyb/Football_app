import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fmp/verify.dart';
import 'auth.dart';
import 'database.dart';
import 'signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUp> {

  late String? _password;
  late String? _email;
  late String? _nom;
  late String? _error;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: _keyForm,
          child: Stack(
              children: <Widget>[
                Positioned(
                    top: -MediaQuery.of(context).size.height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: Container(
                      child: Transform.rotate(
                        angle: -pi / 3.5,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
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
                Stack(
                  children: <Widget>[

                    Positioned(
                      top:100,

                      child: IconButton(

                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: "Email",
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
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
                                          return "Email can't be empty";
                                        } else if (value.isValidEmail() ==
                                            false) {
                                          return "wrong email";
                                        }
                                      })
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
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
                                        _password = value;
                                      },
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password can't be empty";
                                        } else if (value.length < 5) {
                                          return "Password must have +5 char";
                                        } else {
                                          return null;
                                        }
                                      })
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
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
                                        _password = value;
                                      },
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password can't be empty";
                                        } else if (value.length < 5) {
                                          return "Password must have +5 char";
                                        } else {
                                          return null;
                                        }
                                      })
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Name",
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
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
                                        _nom = value;
                                      },
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please type your name";
                                        } else {
                                          return null;
                                        }
                                      })
                                ],
                              ),
                            ),


                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: Offset(2, 4),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff14279B),
                                Color(0xff14279B),
                              ],
                            ),
                          ),
                          child: TextButton(
                              child: Text("Create Account",
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
                        SizedBox(height: height * .14),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signin()));
                          },

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

        ),
      ),
    );
  }
}
