
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fmp/info.dart';
import 'package:fmp/userr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'BrewTile.dart';
import 'feddback.dart';
import 'mailing.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();

}
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }}

class _homeState extends State<home> {
   late User us;
   String? imageLink = null ;

   File? _image;
  Future geti()async{
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }


  Future <void> getUserData() async
  {
    User usd = FirebaseAuth.instance.currentUser;
    setState(() {
      us = usd;
    });
  }

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();


  String title = "hello";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   if(us.photoURL == null)
     {
       imageLink = null;
     }
   else
     {
       imageLink = us.photoURL ;

     }
    return SingleChildScrollView(

      child: Container(

        alignment: Alignment.center,
        child: Column(

            children: <Widget>[
              SizedBox(height: 100),
        GestureDetector(
            onTap: () {
              geti;
            },
              child:  imageLink != null ?
              CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage:  NetworkImage(
                      imageLink.toString())) :
              const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage:  AssetImage(
                      'assets/user.png'))
          ,
        ),


              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Username: ${us.displayName }",
                  style: TextStyle(fontSize: 20),),

              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Email: ${us.email ?? 'Anonymous'}",
                  style: TextStyle(fontSize: 20),),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("You joined: ${DateFormat('MM/dd/yyyy').format(
                    us.metadata.creationTime)}",
                  style: TextStyle(fontSize: 20),),
              ),
              SizedBox(height: 100),


              showSignOut(context, us.isAnonymous),
            ]),
      ),
    );
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Logout and create an account"),
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushNamed(context, "/signin");
        },
      );
    } else {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      return RaisedButton(
        child: Text("Update"),
        onPressed: () {
          Navigator.of(context).pushNamed('/modf');
        },
      );
    }
  }


  /*Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() async {

      final xx =  _imageFile!.readAsBytes();
      String img = base64Encode(List.from(await xx));
      us.updateProfile(displayName : us.displayName, photoURL: img );
    });
  }*/


}