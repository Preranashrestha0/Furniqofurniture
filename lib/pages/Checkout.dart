// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unused_local_variable, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/%20controllers/Cart_Controller.dart';
import 'package:furnitureapp/components/TextFormField.dart';
import 'package:furnitureapp/pages/onBoardingpage.dart';

import '../components/TextField.dart';
import 'Cart.dart';

class CheckOutScreen extends StatefulWidget {
  //To pass the totalPriceFinal value from the Cart_ControllerPage to the CheckOutScreen,
  final num totalPriceFinal ;
  const CheckOutScreen({Key? key, required this.totalPriceFinal}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}
// await sourceCollection.doc(doc.id).delete();
class _CheckOutScreenState extends State<CheckOutScreen> {

  final _deliveryaddress = TextEditingController();
  final _phoneNumber = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> addtoOrderHistory() async {
    try {
      CollectionReference sourceCollection =
      FirebaseFirestore.instance.collection('users_cart_items').doc(user!.email).collection('Items');
      CollectionReference destinationCollection =
      FirebaseFirestore.instance.collection('users_order_history');

      // Combine data from controllers and source collection
      Map<String, dynamic> orderData = {
        "orderId": DateTime.now().millisecondsSinceEpoch.toString(),
        "deliveryAddress": _deliveryaddress.text,
        "phoneNumber": _phoneNumber.text,
        "customerEmail": user!.email.toString(),
        "Total Price":widget.totalPriceFinal + 100,
        "Status" : "Pending",
        "Payment Method": "Cash on Delivery",
        "Products": []
      };

      // Fetch data from the source collection
      QuerySnapshot sourceData = await sourceCollection.get();
      // Check if there is no data in sourceData
      if (sourceData.docs.isEmpty) {
        // Display an error message and return from the function
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: No items in the cart.'),
            backgroundColor: Colors.brown,
          ),
        );
        return;
      }
      // Iterate through the documents and add them to the combined orderData
      List<Map<String, dynamic>> orderItems = [];

      // Iterate through the documents and add them to the combined orderData
      for (QueryDocumentSnapshot doc in sourceData.docs) {
        orderItems.add(doc.data() as Map<String, dynamic>);
        //to delete cart items
        await deleteCartItems();
        // Identify the seller and update their post status
        String productId = doc['productId']; // Replace with the actual field name
        await updatePostStatus(productId);
      }
      orderData["Products"] = orderItems;

      // Set the combined data to the destination collection
      await destinationCollection.doc(user!.email).collection('Items').add(orderData);
      print("Data added successfully");

    } catch (e) {
      print('Error occurred: $e');

    }
  }


  Future deleteCartItems()async{
    var collection = FirebaseFirestore.instance.collection('users_cart_items').doc(user!.email).collection('Items');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> updatePostStatus(String productId) async {
    try {
      CollectionReference postCollection = FirebaseFirestore.instance.collection('users_post_history');

      // Fetch data from the furniture_list collection
      QuerySnapshot postData = await postCollection.where('productId', isEqualTo: productId).get();

      // Update the status of the post to "Order Confirmed"
      for (QueryDocumentSnapshot doc in postData.docs) {
        await postCollection.doc(doc.id).update({
          "status": "Order Confirmed",
          "Orderedby": user!.email.toString(),
          "deliveryAddress": _deliveryaddress.text.toString(),
          "customerPhoneNo": _phoneNumber.text.toString(),
        });
      }

      print("Post status updated to Order Confirmed successfully.");
    } catch (e) {
      print('Error updating post status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      backgroundColor: Color(0xffe3d8d0),
      appBar: AppBar(
        backgroundColor: Color(0xffe3d8d0),
        title: Center(child: Text('Check Out', style: TextStyle(fontFamily: 'RobotoSerif', color: Colors.brown, fontSize: 20),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Delivery Address', style: TextStyle(color: Colors.brown ,fontSize: 20, fontFamily: 'RobotoSerif'),),
           MyTextFormField(controller: _deliveryaddress, hintText: 'Enter your delivery address'),
            SizedBox(height: 10,),
            MyTextFormField(controller: _phoneNumber, hintText: 'Enter your phone Number'),
            SizedBox(
              height: 10,
            ),
            Text('Product Information', style: TextStyle(color: Colors.brown ,fontSize: 20, fontFamily: 'RobotoSerif'),),
            Container(
              height: size.height/2,
                child: Cart_ControllerPage()),
            Text('Delivery Charge: \$ 100', style: TextStyle(fontFamily: 'RobotoSerif', color: Colors.brown, fontSize: 16),),
            Text('Total Amount :\$ ${totalPriceFinal + 100}', style: TextStyle(fontFamily: 'RobotoSerif', color: Colors.brown, fontSize: 16),),
            Container(
                height: size.height/15,
                width: size.width/3,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.brown,),
                child: GestureDetector(
                    onTap: (){
                      if(_deliveryaddress.text.isNotEmpty &&
                      _phoneNumber.text.isNotEmpty ){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: Text("Are you sure you want to confirm your Order?"),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Upload image file to Firebase Storage
                                    addtoOrderHistory();
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Order Confirmed'),
                                        backgroundColor: Colors.brown,
                                      ),
                                    );
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OnBoardingPage()));
                                     },
                                  child: Text("Sure", style: TextStyle(color: Colors.amber)),

                                ),
                              ],
                            );
                          },
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please fill up all the fields.'),
                              backgroundColor: Colors.brown,
                            )
                        );
                      }
                    },
                    child: Center(child: Text('Confirm Order', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,fontFamily: 'RobotoSerif', color: Colors.white),))))
          ],
        ),
      ),
    );
  }
}