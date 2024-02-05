import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/%20controllers/Cart_Controller.dart';
import 'package:furnitureapp/pages/Checkout.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  User? user = FirebaseAuth.instance.currentUser;

  // Reference for notifications
  final CollectionReference _postsCollection =
  FirebaseFirestore.instance.collection('users_post_history');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe3d8d0),
      appBar: AppBar(
        backgroundColor: Color(0xffe3d8d0),
        title: Center(child: Text("Notifications", style: TextStyle(fontSize: 22, fontFamily: 'RobotoSerif', color: Colors.brown),)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _postsCollection
            .where("createdBy", isEqualTo: user!.email)
            .where('status', whereIn: ['Cancelled', 'Order Confirmed'])
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Process the snapshot and update UI accordingly
          final posts = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              final post = posts[index].data() as Map<String, dynamic>;

              // Extract relevant information
              final String productName = post['name'];
              final String price = post['price'];
              final String status = post['status'];
              final String deliveryAddress = post['deliveryAddress'];
              final String customerPhoneNo = post['customerPhoneNo'];



              return Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white12,border: Border.all(color: Colors.black12)),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Products'),
                      Text(productName),
                      Text('\$ $price'),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer Details'),
                      Text('Delivery Address: $deliveryAddress'),
                      Text('Phone No: $customerPhoneNo'),
                      Text('Status: $status'),
                    ],
                  ),
                  // Add more UI components as needed
                ),
              );
            },
          );
        },
      ),
    );
  }
}
