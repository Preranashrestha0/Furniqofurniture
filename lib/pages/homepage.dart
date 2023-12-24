import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/models/newsapi.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Furniqo',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoSerif',
                color: Colors.pinkAccent),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.notifications,
                  size: 35,
                )
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: size.height / 10,
                width: size.width / 1.1,
                child: Text(
                  'Discover the best \n Furniture',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontFamily: 'RobotoSerif'),
                )),
            Container(
              margin: EdgeInsets.only(left: 30, right: 5, top: 10),
              height: size.height / 15,
              width: size.width / 1.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26)),
              child: TextField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white10),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white10),
                  ),
                  icon: Icon(Icons.search),
                  hintText: 'Search for furniture',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  width: size.width / 1.2,
                  child: Row(
                    children: [
                      Text(
                        'Hot Sales',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoSerif'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 200,
                  width: 200,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('furniture_list')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs.map((document) {
                          return Column(
                            children: [
                              Container(
                                child: Center(child: Text(document['description'])),
                              ),
                              Image.network('https://firebasestorage.googleapis.com/v0/b/furniqo.appspot.com/o/images%2F1703400537976.jpg?alt=media&token=ab5d71bb-0300-4a25-9858-b26b5563f123')
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                )
              ],
            ),
          ]),
        ));
  }
}
