import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/pages/productDetail.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {

  Widget fetchData (){
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user_favorite_items')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("Items")
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something is wrong"),
          );
        }

        return ListView.builder(
            itemCount:
            snapshot.data == null ? 0 : snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              DocumentSnapshot _documentSnapshot =
              snapshot.data!.docs[index];

              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(_documentSnapshot)));
                },
                child: Card(
                  elevation: 5,
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Image(image: NetworkImage(_documentSnapshot['image']),),
                          title: Text(
                            " ${_documentSnapshot['name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          subtitle: Text(
                            "\$ ${_documentSnapshot['price']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.brown),
                          ),
                          trailing: GestureDetector(
                            child: CircleAvatar(
                              child: Icon(Icons.delete, color: Colors.brown,),
                            ),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('user_favorite_items')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("Items")
                                  .doc(_documentSnapshot.id)
                                  .delete();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );


            });

      },

    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe3d8d0),
      appBar: AppBar(
        backgroundColor: Color(0xffe3d8d0),
        title: Text(
            'Wishlist',style: TextStyle(fontSize: 20, fontFamily: 'RobotoSerif', color: Colors.brown),
        ),
      ),
      body: SafeArea(
        child: fetchData(),
      ),
    );
  }
}
