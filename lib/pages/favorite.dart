import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class favourite extends StatefulWidget {
  const favourite({super.key});

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Favpage', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
