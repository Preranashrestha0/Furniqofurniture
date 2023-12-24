import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class postt extends StatefulWidget {
  const postt({super.key});

  @override
  State<postt> createState() => _posttState();
}

class _posttState extends State<postt> {
  TextEditingController _controllerDescription = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
//get the collection ref, an instance of Collection Reference
  //collectionref belongs to the package cloud firestore
  CollectionReference _reference =
  FirebaseFirestore.instance.collection('furniture_list');


  String imgURL = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Center(
            child: Text('Post', style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: size.height/5,
            decoration: BoxDecoration(border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              controller: _controllerDescription,
              decoration:
              InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white10),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white10),
                  ),
                  hintText: 'Enter the description of the product'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product description';
                }

                return null;
              },
            ),
          ),
          IconButton(
              onPressed: () async {
                /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */

                /*Step 1:Pick image*/
                //Install image_picker
                //Import the corresponding library

                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                await imagePicker.pickImage(source: ImageSource.camera);
                print('${file?.path}');

                if (file == null) return;
                //Import dart:core
                String uniqueFileName =
                DateTime.now().millisecondsSinceEpoch.toString();

                /*Step 2: Upload to Firebase storage*/
                //Install firebase_storage
                //Import the library

                //Get a reference to storage root
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages =
                referenceRoot.child('images');

                //Create a reference for the image to be stored
                Reference referenceImageToUpload =
                referenceDirImages.child(uniqueFileName+'.jpeg');


                //Handle errors/success
                try {
                  //Store the file
                  await referenceImageToUpload.putFile(File(file!.path));
                  //Success: get the download URL
                  imgURL = await referenceImageToUpload.getDownloadURL();
                } catch (error) {
                  //Some error occurred
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
                  String productDescription = _controllerDescription.text;

                  //Create a Map of data
                  Map<String, String> dataToSend = {
                    'description': productDescription,
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
