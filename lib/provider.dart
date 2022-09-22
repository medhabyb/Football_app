import 'package:flutter/cupertino.dart';

import 'auth.dart';

class Providerr extends InheritedWidget {
  final AuthService auth;

  Providerr({required Key key, required Widget child, required this.auth}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Providerr of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Providerr>() as Providerr);
}