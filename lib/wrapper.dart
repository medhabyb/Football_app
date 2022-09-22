
import 'package:fmp/screens/soccer_two_thousand_twenty_one.dart';
import 'package:fmp/signin.dart';
import 'package:fmp/signup.dart';
import 'package:fmp/splash.dart';
import 'package:fmp/splashs.dart';
import 'package:fmp/userr.dart';
import 'package:provider/provider.dart';


import 'mus.dart';
import 'profile.dart';
import 'package:flutter/material.dart';

import 'nav_bottom.dart';

class Wrapper extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
  final user = Provider.of<Userr?>(context);

  print(user);
    // return either the Home or Authenticate widget

       if (user == null) {
         return  AssetLottie();
       }
       else
         {
         return AssetLotties();
       }




  }
}
    
