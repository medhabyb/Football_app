import 'package:flutter/material.dart';



class homee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


      return Scaffold(
        resizeToAvoidBottomInset: false,

        body: Center(
          child: Text(
            'Welcome to Gamix Prono',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),

    );
  }
}