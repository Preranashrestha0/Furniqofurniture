import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:furnitureapp/models/newsapi.dart';
import 'package:furnitureapp/pages/Wishlist_page.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //for android mobile
    //   const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    //
    //   const InitializationSettings initializationSettings = InitializationSettings(
    //     android: androidInitializationSettings
    //   );
    //
    //   flutterLocalNotificationsPlugin.initialize(
    //       initializationSettings,
    //       onDidReceiveBackgroundNotificationResponse: (dataYouNeedToUseWhenNotificationsIsClicked){});
    //   Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
    //   FirebaseFirestore.instance.collection('furniture_list').snapshots();
    //   notificationStream.listen((event){
    //     if(event.docs.isEmpty){
    //       return;
    //     }
    //     else{
    //
    //     }
    //   });
    // }
    // void showNotifications(){
    //
    // }
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WishlistPage())
                    );
                  }, icon: Icon(
                    Icons.shopping_cart,
                    size: 35,
                ),
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
        body: Column(children: [
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
                ),
              ],
            ),
          ),

          StreamBuilder<QuerySnapshot>(
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
                    height: 150,
                    width: 500,
                    child: ListTile(
                      title: Text(data['description'],style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      subtitle: Image(
                        image: NetworkImage(data['image']), // ----------- the line that should change
                        width: 200,
                        height: 100,

                      ),
                    ),
                  );
                }).toList(),
              );

            },
          ),
        ]));
  }
}
