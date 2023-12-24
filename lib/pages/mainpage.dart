import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/pages/Profile_page.dart';
import 'package:furnitureapp/pages/Wishlist_page.dart';
import 'package:furnitureapp/pages/Home_Page.dart';
import 'package:furnitureapp/pages/post.dart';
import 'package:furnitureapp/pages/search.dart';
import 'package:google_sign_in/google_sign_in.dart';

class mainpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return mainpagestate();
  }
}

class mainpagestate extends State<mainpage>{
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    homepage(),
    searchpage(),
    post(),
    WishlistPage(),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: () async{
      //       await GoogleSignIn().signOut();
      //       FirebaseAuth.instance.signOut();
      //     }, icon: Icon(Icons.power_settings_new))
      //   ],
      // ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages, //New
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12)
        ),
        child: BottomNavigationBar(
          // selectedFontSize: 20,
          selectedIconTheme: IconThemeData(color: Colors.pinkAccent, size: 30),
          selectedItemColor: Colors.pinkAccent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          unselectedIconTheme: IconThemeData(
            color: Colors.black,
          ),
          unselectedItemColor: Colors.black,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
      ),

    );

  }
}