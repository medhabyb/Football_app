import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'profile.dart';

class feedback extends StatefulWidget {
  const feedback({Key? key}) : super(key: key);

  @override
  State<feedback> createState() => _feedbackState();
}
Future sendEmail(String name, String email, String message) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_rh527wq';
  const templateId = 'template_99pg62j';
  const userId = 'bJ9oEmuit4A_SvwY';

  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},//This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'from_name': name,
          'reply_to': email,
          'message': message
        }
      }));
  return response.statusCode;
}

class _feedbackState extends State<feedback> {
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  bool isLoading = false;
  late User us ;
  Future <void> getUserData () async
  {
    User usd =  FirebaseAuth.instance.currentUser;
    setState(() {
      us = usd;

    });
  }
  TextEditingController messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
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
          key: _formKey,
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
                                    controller: messageController,
                                      keyboardType: TextInputType.multiline,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Message',
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
                                    validator: ((value) {
                                      if (value!.isEmpty) {
                                        setState(() {
                                          _enableBtn = true;
                                        });
                                        return 'Message is required';
                                      }
                                      return null;
                                    }),
                                      )
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
                                  : const Text("Send Email",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed:   (() async {
    if (_formKey.currentState!.validate()) {
    final response = await sendEmail(
                          us.displayName,
                          us.email,
                          messageController.value.text);
    ScaffoldMessenger.of(context).showSnackBar(
    response == 200
    ? const SnackBar(
    content: Text('Message Sent!'),
    backgroundColor: Colors.green)
        : const SnackBar(
    content: Text('Failed to send message!'),
    backgroundColor: Colors.red),
    );

    messageController.clear();
                              }})),
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
