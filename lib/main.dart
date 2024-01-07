import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:furnitureapp/pages/Contact_page.dart';
import 'package:furnitureapp/pages/Profile_page.dart';
import 'package:furnitureapp/pages/Registration.dart';
import 'package:furnitureapp/pages/furnihomepage.dart';
import 'package:furnitureapp/pages/mainpage.dart';
import 'package:furnitureapp/pages/post.dart';
import 'package:furnitureapp/pages/test.dart';

import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: mainpage(),
    );
  }
}
