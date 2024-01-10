import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/%20controllers/Post_Controller.dart';


class PostHistory extends StatefulWidget {
  const PostHistory({super.key});

  @override
  State<PostHistory> createState() => _PostHistoryState();
}

class _PostHistoryState extends State<PostHistory> {
  TextEditingController? _nameController;
  TextEditingController? _priceController;
  TextEditingController? _descriptionController;

  final CollectionReference _products =
  FirebaseFirestore.instance.collection('furniture_list');

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController?.text = documentSnapshot['name'];
      _priceController?.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Update', style: TextStyle(color: Color(0xffffffff), fontFamily: 'RobotoSerif', fontSize: 16),),
                onPressed: () async {
                  final String name = _nameController!.text;
                  final double? price =
                  double.tryParse(_priceController!.text);
                  if (price != null) {
                    await _products
                        .doc(documentSnapshot!.id)
                        .update({"name": name, "price": price});
                    _nameController!.text = '';
                    _priceController!.text = '';
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(primary: Color(0xff864942)),
              )
            ],
          ),
        );
      },
    );
  }

  fetchDataPostHistory() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users_post_history')
          .where("createdBy",
          isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something is wrong"),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
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
                      leading: GestureDetector(
                        onTap: () {
                          // Call the _update method when the Edit button is tapped
                          _update(_documentSnapshot);
                        },
                        child: Icon(Icons.edit),
                      ),
                      title: Text(
                        " ${_documentSnapshot['name']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(
                        "\$ ${_documentSnapshot['price']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Color(0xff864942)),
                      ),
                      trailing: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(Icons.delete, color: Color(0xff864942),),
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
          },
        );
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
          'My Posts',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoSerif',
              color: Colors.brown),
        ),
      ),
      body: fetchDataPostHistory(),
    );
  }
}