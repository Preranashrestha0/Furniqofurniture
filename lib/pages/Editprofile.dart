import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/TextFormField.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_addressController;


  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users_test");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":_nameController!.text,
          "phone":_phoneController!.text,
          "age":_addressController!.text,
        }
    ).then((value) => print("Updated Successfully"));
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffe3d8d0),
      appBar: AppBar(
        backgroundColor: Color(0xffe3d8d0),
        title: Center(child: Text('Update Profile', style: TextStyle(color: Color(0xff864942), fontFamily: 'RobotoSerif'),)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Column(
          children: [
            Image.asset('assets/images/Female_Profile.png'),
            Container(
              margin: EdgeInsets.all(10),
              height: size.height/2.1,
              decoration: BoxDecoration(color: Color(0xffffffff), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users_test").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    var data = snapshot.data;
                    if(data==null){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name', style: TextStyle(fontFamily: 'RobotoSerif', fontSize: 18)),
                        MyTextFormField(controller:  _nameController = TextEditingController(text: data['name']), hintText: '',

                        ),
                        Text('Phone', style: TextStyle(fontFamily: 'RobotoSerif', fontSize: 18)),
                        MyTextFormField(controller:  _phoneController = TextEditingController(text: data['phone']), hintText: '',

                        ),
                        Text('Address', style: TextStyle(fontFamily: 'RobotoSerif', fontSize: 18)),
                        MyTextFormField(controller:  _addressController = TextEditingController(text: data['address']), hintText: '',

                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: ElevatedButton(
                              onPressed: ()=>updateData(),
                              child: Text("Update", style: TextStyle(color: Color(0xffffffff),fontSize: 20, fontFamily: 'RobotoSerif'),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff864942),
                            padding: EdgeInsets.symmetric(horizontal: 20)
                          ),),
                        )
                      ],
                    );;
                  },

                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
