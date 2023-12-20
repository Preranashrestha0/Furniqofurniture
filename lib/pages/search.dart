import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 5),
            height: size.height/15,
            width: size.width/1.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black26)
            ),
            child: TextField(decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white10),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white10),
              ),
              icon: Icon(Icons.search, color: Colors.pinkAccent,),
              hintText: 'Search for furniture',
            ),),
          )
        ],
      ),
    );
  }
}
