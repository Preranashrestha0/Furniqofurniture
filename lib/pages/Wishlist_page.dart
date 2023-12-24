import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, size: 40, color: Colors.pinkAccent,),
            onPressed: () {
              Navigator.pop(context); // shows current page when the icon is pressed
            },
          ),
          title: Text("Wishlist", style:
          TextStyle(color: Colors.pinkAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoSerif'),
          ),
          centerTitle: true),
    );
  }
}
