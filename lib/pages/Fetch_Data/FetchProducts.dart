import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget fetchDataPostHistory (){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users_post_history')
        .where("createdBy", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots(),
    builder:
        (BuildContext context, AsyncSnapshot snapshot) {
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

            return Card(
              elevation: 5,
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text(
                        " ${_documentSnapshot['name']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(
                        "\$ ${_documentSnapshot['price']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      trailing: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(Icons.delete),
                        ),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('furniture_list')
                              .doc(_documentSnapshot.id)
                              .delete();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );


          });

    },

  );


}