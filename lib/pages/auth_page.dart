import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/pages/loginpage.dart';
import 'package:furnitureapp/pages/onBoardingpage.dart';

class authpage extends StatelessWidget {
  const authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return OnBoardingPage();
          }
          else{
            return loginpage();
          }
      }

      ),
    );
  }
}
