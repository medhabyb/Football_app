// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmp/profile.dart';
import 'package:fmp/screens/soccer_two_thousand_twenty_one.dart';
import 'package:fmp/updateemail.dart';
import 'package:fmp/updm.dart';
import 'package:fmp/userr.dart';
import 'package:fmp/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'Modif.dart';
import 'auth.dart';
import 'fmdp.dart';
import 'nav_bottom.dart';
import 'signin.dart';
import 'signup.dart';
import 'profile.dart';
import 'models/soccermodel.dart';
import 'splash.dart';
import 'package:path_provider/path_provider.dart';
import 'themep.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) =>  AuthService(),


      child: MaterialApp(
          themeMode: ThemeMode.system,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          routes: {
        "/": (BuildContext context) {
          return const AssetLottie();
        },
        "/signin": (BuildContext context) {
          return const Signin();
        },
        "/upm": (BuildContext context) {
          return const updm();
        },
        "/upe": (BuildContext context) {
          return const upem();
        },
        "/signup": (BuildContext context) {
          return const SignUp();
        },
        "/score": (BuildContext context) {
          return SoccerTwoThousandTwentyOne();
        },
        "/modf": (BuildContext context) {
          return modf();
        },
        "/fmdp": (BuildContext context) {
          return fmdp();
        },
        "/NavigationBottom": (BuildContext context) {
          return NavigationBottom();
        },
      }),
    );

  }

