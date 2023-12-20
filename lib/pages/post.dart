import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerTimeUsed = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
  FirebaseFirestore.instance.collection('shopping_list');

  String imgURL = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Center(
            child: Text('Post', style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        children: [
          // TextFormField(
          //   controller: _controllerName,
          //   decoration:
          //   InputDecoration(hintText: 'Enter the name of the product'),
          //   validator: (String? value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter the product name';
          //     }
          //
          //     return null;
          //   },
          // ),
          // TextFormField(
          //   controller: _controllerTimeUsed,
          //   decoration:
          //   InputDecoration(hintText: 'Enter the time used of the product'),
          //   validator: (String? value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter the product used time';
          //     }
          //
          //     return null;
          //   },
          // ),
          IconButton(onPressed: () async {
            //pick a image
            ImagePicker imagepicker = ImagePicker();
            XFile? file = await imagepicker.pickImage(source: ImageSource.camera);
            print('${file?.path}');

            if (file == null) return;
            String uniqueFilename = DateTime.now().microsecondsSinceEpoch.toString();
            //upload to firebase storage
            //get a reference to storage root
            Reference referenceRoot = FirebaseStorage.instance.ref();
            Reference referenceDirImages = referenceRoot.child('images');

            //create a reference for the image to be stored
            Reference referenceimgtoUpload = referenceDirImages.child(uniqueFilename);

            //handle error/success
            try{
              //store the file
              await referenceimgtoUpload.putFile(File(file!.path));

              //success:get the download URL
              imgURL = await referenceimgtoUpload.getDownloadURL();
            }
            catch(error){

            }



          },
          icon: Icon(Icons.camera_alt)),
          ElevatedButton(
              onPressed: () async {
                if (imgURL.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Please upload an image')));

                  return;
                }

                if (key.currentState!.validate()) {
                  String productName = _controllerName.text;
                  String productTimeused = _controllerTimeUsed.text;

                  //Create a Map of data
                  Map<String, String> dataToSend = {
                    'name': productName,
                    'timeused': productTimeused,
                    'image': imgURL,
                  };

                  //Add a new item
                  _reference.add(dataToSend);
                }
              },
              child: Text('Submit'))
        ],
      ),
    );
  }
}
