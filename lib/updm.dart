import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fmp/signin.dart';
import 'package:provider/provider.dart';

import 'auth.dart';



class updm extends StatefulWidget {
  const updm({Key? key}) : super(key: key);

  @override
  _upemState createState() => _upemState();
}
class _upemState extends State<updm> {

  late String? _password;
  late String? _email;
  late String? _nom;
  late User us;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _passs = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool isLoading = false;
  bool checkCurrentPasswordValid = true;
  Future <void> getUserData () async
  {
    User usd =  FirebaseAuth.instance.currentUser;
    setState(() {
      us = usd;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    print(us.email);
  }

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

                                      controller: _passs,
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        errorText: checkCurrentPasswordValid ? null :
                                        "Double check the password",
                                        labelText: 'Current Password',
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
                                          return "Password cant be empty";
                                        } else if (value.length < 8
                                            ) {
                                          return "Weak password";
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
                                      controller: _pass,
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: 'New password',
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
                                          return "Password cant be empty";
                                        } else if (value.length < 8
                                        ) {
                                          return "Weak password";
                                        }
                                        else if (value!= _pass.text
                                        ) {
                                          return "Password not matching !";
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
                                    controller: _confirmPass,
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm password',
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
                                          return "Password cant be empty";
                                        } else if (value.length < 8
                                        ) {
                                          return "Weak password";
                                        }
                                        else if (value!= _pass.text
                                        ) {
                                          return "Password not matching !";
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
                                  : const Text("Update",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await Future.delayed(const Duration(seconds: 2));
                                  setState(() {
                                    isLoading = false;
                                  });
                                  final provider = Provider.of<AuthService>(context, listen: false);
                                  checkCurrentPasswordValid  = await provider.validateCurrentPassword(_passs.text);
                                  if (checkCurrentPasswordValid == true)
                                    {
                                  if (_keyForm.currentState!.validate()) {


                                    us.updatePassword(_pass.text);
                                    print(us.email);



                                    final provider = Provider.of<AuthService>(context, listen: false);
                                    final isON = await provider.signOutFromGoogle();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Login with your new Password!'),
                                            backgroundColor: Colors.green)
                                    );
                                    await _auth.signOut();
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Signin()), (route) => false);;
                                  }}
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
