import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmp/signup.dart';
import 'package:fmp/su.dart';
import 'package:provider/provider.dart';
import 'LocalAuthApi.dart';
import 'auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'fmdp.dart';
import 'nav_bottom.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class _SigninState extends State<Signin> {
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
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                            margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
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
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(30, 50, 40, 0),
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
                                await Future.delayed(const Duration(seconds: 5));
                                setState(() {
                                  isLoading = false;
                                });
                                try {
                                  UserCredential result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email, password: _password);
                                  User user = result.user;

                                  final isAuthenticated = await LocalAuthApi.authenticate();
                                  if (isAuthenticated){
                                  Navigator.of(context)
                                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavigationBottom()), (route) => false);
                                }}
                                on FirebaseAuthException catch  (e) {
                                  print('Failed with error code: ${e.code}');
                                  print(e.message);

                                        if (e.code == "wrong-password")
{                                                                   showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20.0)), //this right here
        child: Container(

          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(

                      border: InputBorder.none,
                      hintText: 'The password doesnt match'),

                ),
              ],
            ),
          ),
        ),
      );
    });
                                }
                                 else if (e.code == "user-not-found")
                                  {                                 showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20.0)), //this right here
                                          child: Container(

                                            height: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                   TextField(
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(

                                                        border: InputBorder.none,
                                                        hintText: 'This user doesnt exist'),

                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                  }

                                }
                              }}
  ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                          ),


                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => fmdp()));

                          },
                        ),



                      ),
                  InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                      child: Container(
                        width:300,
                        height:30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              // decoration: BoxDecoration(color: Colors.blue),
                                child:
                                Image.network(
                                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                                    fit:BoxFit.cover
                                )

                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Sign-in with Google',
                                style: TextStyle(

                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ],

                        ),

                      ),
                  ),
                    onTap: () async {
                      final provider = Provider.of<AuthService>(context, listen: false);
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated){
                      final isON = await provider.signInwithGoogle();
                      if (isON){
                        Navigator.of(context)
                            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NavigationBottom()), (route) => false);
                      }}
                    },
                  ),


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
                        child: Container(
                          width:300,
                          height:30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                // decoration: BoxDecoration(color: Colors.blue),
                                  child:
                                  Image.network(
                                      'https://pngimg.com/uploads/facebook_logos/facebook_logos_PNG19753.png',
                                      fit:BoxFit.cover
                                  )
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Sign-in with Facebook',
                                  style: TextStyle(

                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: TextButton(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Color(0xff14279B),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Su()));
                                  },
                                ),
                              ),
                            ]),
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
