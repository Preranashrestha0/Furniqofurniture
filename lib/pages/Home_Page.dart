import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:Text('Furniqo', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'RobotoSerif', color: Colors.pinkAccent),),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.shopping_cart, size: 35,),
              SizedBox(width: 10,),
              Icon(Icons.notifications, size:35,)
            ],
          ),

        ],
      ),
      body: Column(

        children: [
          Container(
              height: size.height/10,
              width: size.width/1.1,
              child: Text('Discover the best \n Furniture', textAlign: TextAlign.start, style: TextStyle(fontSize: 20,fontFamily: 'RobotoSerif'),)),
          Container(
            margin: EdgeInsets.only(left: 30, right: 5, top:10),
            height: size.height/15,
            width: size.width/1.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26)
            ),
            child: TextField(decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white10),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white10),
              ),
              icon: Icon(Icons.search),
              hintText: 'Search for furniture',

            ),),
          ),
          SizedBox(height: 10,),
          Container(
            width: size.width/1.2,
            child: Row(
              children: [
                Text('Hot Sales', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'RobotoSerif'),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                      child: Row(
                        children: [
                          Text('View All', style: TextStyle(fontSize: 15, ),),
                          Icon(Icons.arrow_forward_ios, size: 15,)
                        ],
                      ),),
                  ],
                )
              ],
            ),
          )



        ],
      ),
    );
  }
}
