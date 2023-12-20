import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class demopage extends StatefulWidget {
   demopage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out


  @override
  State<demopage> createState() => _demopageState();
}

class _demopageState extends State<demopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
        ],
      ),
      body: Text("Logged in as"),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();

  }
}
