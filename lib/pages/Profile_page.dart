import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/components/custom_container_widget.dart';
import 'package:furnitureapp/components/divider.dart';
import 'package:furnitureapp/pages/Contact_page.dart';
import 'package:furnitureapp/pages/Order_history.dart';
import 'package:furnitureapp/pages/Wishlist_page.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title:
      Text("Profile", style:
      TextStyle(color: Colors.pinkAccent,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoSerif'),
      ),
          centerTitle: true),

      backgroundColor: Colors.white,
      body: Column(
          children: [
            ExpandDivider(),

            // container to greet the user and view image
            Container(
              margin: EdgeInsets.only(left: 10, right: 5, top: 5),
              height: size.height/8,
              width: size.width/1.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white70)
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/Female_Profile.png'),
                  SizedBox(width: 20,),
                  Text('Hello \nReena Gurung',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pinkAccent),),
                  SizedBox(width: 60,),
                  Icon(Icons.edit),
                ],
              ),
            ),

            ExpandDivider(),  // creates a kind of line named divider

            const SizedBox(height: 10,),

            // Container for the user order
            CustomContainerWidget(
              onTap: () {
                // Navigate to another page when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistory()),
                );
              },
              rowcontent: Row(
                children: [
                  SizedBox(width: 10,),
                  Image.asset('assets/images/icon_order.png', height: 40,),
                  SizedBox(width: 15,),
                  Text('My Orders',style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'RobotoSerif',),),
                  SizedBox(width: 160,),
                  Icon(Icons.keyboard_arrow_right, size: 30),
                ],
              ),
            ),

            // container for wishlist
            CustomContainerWidget(
              onTap: () {
                // Navigate to another page when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WishlistPage()),
                );
              },
              rowcontent:  Row(
                children: [
                  SizedBox(width: 10,),
                  Image.asset('assets/images/wishlist.png', height: 100,),
                  SizedBox(width: 15,),
                  Text('Wishlist',style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'RobotoSerif',),),
                  SizedBox(width: 180,),
                  Icon(Icons.keyboard_arrow_right, size: 30),
                ],
              ),
            ),

            // container for about app
            CustomContainerWidget(
              onTap: () {},
              rowcontent: Row(
                children: [
                  SizedBox(width: 10,),
                  Image.asset('assets/images/about_us.png', height: 32,),
                  SizedBox(width: 15,),
                  Text('About Us',style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'RobotoSerif',),),
                  SizedBox(width: 170,),
                  Icon(Icons.keyboard_arrow_right, size: 30),
                ],
              ),
            ),

            // container for contact us
            CustomContainerWidget(
              onTap:  () {
                // Navigate to another page when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              },
              rowcontent:  Row(
                children: [
                  SizedBox(width: 10,),
                  Image.asset('assets/images/Phone_Message.png', height: 60,),
                  SizedBox(width: 15,),
                  Text('Contact Us',style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'RobotoSerif',),),
                  SizedBox(width: 150,),
                  Icon(Icons.keyboard_arrow_right, size: 30),
                ],
              ),
            ),

            // container for logout the application
            CustomContainerWidget(
              onTap: () {},
              rowcontent: Row(
                children: [
                  SizedBox(width: 10,),
                  Image.asset('assets/images/log_out.png', height: 26,),
                  SizedBox(width: 15,),
                  Text('Log Out',style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'RobotoSerif',),),


                ],
              ),
            ),
          ]
      ),
    );
  }
}
