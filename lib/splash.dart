import 'package:flutter/material.dart';
import 'package:fmp/signin.dart';
import 'package:lottie/lottie.dart';

import 'nav_bottom.dart';

class AssetLottie extends StatefulWidget {
  const AssetLottie({Key? key}) : super(key: key);

  @override
  _AssetLottieState createState() => _AssetLottieState();
}

class _AssetLottieState extends State<AssetLottie>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _isLoaded = false;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(()  {
          _isLoaded = true;

          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Signin()), (route) => false);

        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoaded
            ? null
            : Lottie.network(
          'https://assets5.lottiefiles.com/packages/lf20_s2hgc4i9.json',
          controller: _controller,
          onLoaded: (comp) {
            _controller.duration = comp.duration;
            _controller.forward();
          },
        ),
      ),
    );
  }
}
