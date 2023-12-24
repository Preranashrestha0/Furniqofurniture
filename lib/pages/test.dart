import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  CollectionReference _ref = FirebaseFirestore.instance.collection("furniture_list");
  late Stream <QuerySnapshot> _streamItems ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamItems = _ref.snapshots();
  }
  Future<List<Map<String, dynamic>>> getDataFromFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('furniture_list').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
  Future<String> downloadImage(String images) async {
    Reference ref = FirebaseStorage.instance.ref().child(images);
    return await ref.getDownloadURL();
  }


  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.pinkAccent,
    //     title: Text('TestData'),
    //   ),
    //   body: StreamBuilder <QuerySnapshot>(
    //     stream: _streamItems,
    //     //builder function get two arguments
    //     //one is build context
    //     //another is instance of a class called AsyncSnapshot
    //     // snapshot has a property called data which will help us to give data we are looking for
    //     //snapshot.data will give us an instance of Query Snapshot id no error occurs
    //     builder: (BuildContext context, AsyncSnapshot snapshot){
    //       //checking errors
    //       if(snapshot.hasError){
    //         return Center(child: Text(snapshot.error.toString()));
    //       }
    //       //checking connection State
    //       if(snapshot.connectionState==ConnectionState.active){
    //         QuerySnapshot querySnapshot = snapshot.data;
    //       }
    //       return Center(child: CircularProgressIndicator());
    //     },
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Data from Firestore'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getDataFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> data = snapshot.data ?? [];
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                // Assuming your data contains a field 'imagePath' for image paths
                String image = data[index]['image'];
                return Column(
                  children: [
                    // Display other data fields as needed
                    Text(data[index]['description']),
                    // Display the image
                    FutureBuilder<String>(
                      future: downloadImage(image),
                      builder: (context, imageSnapshot) {
                        if (imageSnapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (imageSnapshot.hasError) {
                          return Text('Error: ${imageSnapshot.error}');
                        } else {
                          String imageUrl = imageSnapshot.data ?? '';
                          return Image.network(imageUrl);
                        }
                      },
                    ),
                    Divider(), // Add a divider between items
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
