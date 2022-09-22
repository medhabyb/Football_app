
import 'package:flutter/material.dart';
import 'package:fmp/info.dart';

class BrewTile extends StatelessWidget {
  final info brew;

  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Name: ${brew.name }", style: TextStyle(fontSize: 20),),

    );
  }
}
