import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class habeb extends StatefulWidget {
  const habeb({Key? key}) : super(key: key);

  @override
  State<habeb> createState() => _habebState();
}

Future sendEmail(String name, String email, String message) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_z26lh64';
  const templateId = 'template_bb47sr3';
  const userId = '-bJ9oEmuit4A_SvwY';
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},//This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'from_name': name,
          'from_email': email,
          'message': message
        }
      }));
  return response.statusCode;
}
class _habebState extends State<habeb> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  late User us ;
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
  }
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          height: 450,
          width: 400,
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),
              ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Report',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),


                TextFormField(
                  controller: messageController,
                  decoration: const InputDecoration(hintText: 'Message'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
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


                          child: const Text("Send",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await sendEmail(
                              us.displayName,
                              us.email,
                              messageController.value.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            response == 200
                                ? const SnackBar(
                                content: Text('Thanks for your feedback!'),
                                backgroundColor: Colors.green)
                                :  SnackBar(
                                content: Text('$response') ,
                                backgroundColor: Colors.red),
                          );
                          nameController.clear();
                          emailController.clear();
                          messageController.clear();
                        }
                      },

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