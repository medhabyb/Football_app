import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class fmdp extends StatefulWidget {
  const fmdp({Key? key}) : super(key: key);

  @override
  _upemState createState() => _upemState();
}
class _upemState extends State<fmdp> {

  late String? _password;
  late String? _email;
  late String? _nom;
  late User us;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        onPanUpdate: (dis) {
          if (dis.delta.dx > 0) {
            //User swiped from left to right
            print('dragged from left');
            Navigator.pushReplacementNamed(context, "/signin");
          }
        },

        child: Form(
          key: _keyForm,
          child: Container(
            height: height,
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
                  alignment: Alignment.center,
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
                                    controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Your Email',
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xff14279B),
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
                                          return "Email cant be empty";
                                        } else if (value.isValidEmail() ==
                                            false) {
                                          return "wrong email";
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
                                  color: Color(0xff14279B),
                                  offset: Offset(2, 4),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                         color: Colors.white
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
                                  : const Text("Send email",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                try {
                                  if (_keyForm.currentState!.validate()) {

                                    setState(() {
                                      isLoading = true;
                                    });
                                    await Future.delayed(const Duration(seconds: 2));
                                    setState(() {
                                      isLoading = false;
                                    });
                                    _auth.sendPasswordResetEmail(email: _email);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Check your email!'),
                                          backgroundColor: Colors.green)
                                    );
                                    emailController.clear();
                                    await Future.delayed(const Duration(seconds: 1));
                                    Navigator.of(context).pop();




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

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
