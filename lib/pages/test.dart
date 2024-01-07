import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/pages/Wishlist_page.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<List<Map<String, dynamic>>> getDataFromFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('furniture_list').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
  Future<String> downloadImage(String images) async {
    Reference ref = FirebaseStorage.instance.ref().child(images);
    return await ref.getDownloadURL();
  }
  var imageURL = 'https://firebasestorage.googleapis.com/v0/b/furniqo.appspot.com/o/images%2F1703559803796.jpg?alt=media&token=3582b168-e9e5-46ea-919b-17a78248d37d';

  final Stream<QuerySnapshot> _data = FirebaseFirestore.instance.collection('furniture_list').snapshots();



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
      body: StreamBuilder<QuerySnapshot>(
        stream: _data,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String,
                  dynamic>;
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                height: 200,
                child: ListTile(
                  title: Text(data['name'],style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                      fontFamily: 'RobotoSerif'),
                  ),
                  subtitle: Column(
                    children: [
                      Image(
                        image: NetworkImage(data['image']), // ----------- the line that should change
                        width: 200,
                        height: 100,

                      ),
                      Text(data['description'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'Inika'),),
                      TextButton
                        (
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> WishlistPage()));
                          },
                          child: Text('Add To Cart', style: TextStyle(color: Colors.pinkAccent, fontFamily: 'Inika', fontWeight: FontWeight.bold, fontSize: 20),))
                    ],
                  ),
                ),
              );
            }).toList(),
          );

        },
      ),
    );
  }
}
