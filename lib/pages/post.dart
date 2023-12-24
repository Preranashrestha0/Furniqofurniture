import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();

}
class _postState extends State<post> {
  TextEditingController _descriptionController = TextEditingController();
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    try {
      if (_photo == null) {
        print('No image selected.');
        return;
      }

     try{
       var imageName = DateTime.now().millisecondsSinceEpoch.toString();
       var storageRef =
       firebase_storage.FirebaseStorage.instance.ref().child('images/$imageName.jpg');
       var uploadTask = storageRef.putFile(_photo!);
       var downloadUrl = await (await uploadTask).ref.getDownloadURL();

       FirebaseFirestore.instance.collection("furniture_list").add({
         'description': _descriptionController.text,
         'image': downloadUrl.toString(),
       });

       print('File uploaded successfully!');
     }
      catch(e){
        print('Error occurred: $e');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          "Post a Furniture",
          style: TextStyle(
            fontFamily: 'RobotoSerif',
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: size.height / 5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white10),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white10),
                ),
                hintText: 'Enter the description of the product',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product description';
                }
                return null;
              },
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Container(
                child: _photo != null
                    ? ClipRRect(
                  child: Image.file(
                    _photo!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: size.height / 10,
            width: size.width / 2,
            child: ElevatedButton(
              onPressed: () async {
                if (_descriptionController.text.isNotEmpty && _photo != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text("Are you sure you want to submit these details?"),
                        actions: [
                          TextButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.amber),
                            ),
                            onPressed: () {
                              _descriptionController.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              // Upload image file to Firebase Storage
                              uploadFile();
                              Navigator.of(context).pop();
                              _descriptionController.clear();
                            },
                            child: Text("Submit", style: TextStyle(color: Colors.amber)),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Submit Details'),
            ),
          )
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: [
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Gallery'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}