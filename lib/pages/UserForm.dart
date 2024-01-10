import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/components/TextFormField.dart';
import 'package:furnitureapp/pages/onBoardingpage.dart';

import '../Validation/Validator.dart';
import '../components/CustomButton.dart';
import '../components/TextField.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  sendUserDataToDB()async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users_test");
    return _collectionRef.doc(currentUser!.email).set({
      "name":_nameController.text,
      "phone":_phoneController.text,
      "address":_addressController.text,
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>mainpage()))).catchError((error)=>print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe3d8d0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Submit the form to continue.",
                  style:
                  TextStyle(fontSize: 22, color: Colors.brown),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MyTextFormField(controller: _nameController, hintText: 'Enter your name'),
                SizedBox(height: 10,),
                MyTextFormField(controller: _phoneController, hintText: 'Enter your name',),
                SizedBox(height: 10,),
                MyTextFormField(controller: _addressController, hintText: 'Enter your name',),
                SizedBox(
                  height: 50,
                ),

                // elevated button
                Center(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.brown, borderRadius: BorderRadius.circular(10)),
                      child: TextButton(onPressed: ()=>sendUserDataToDB(), child: Text('Continue', style: TextStyle(fontFamily: 'Inika', fontSize: 18, fontWeight: FontWeight.bold , color: Color(0xffffffff)),),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}