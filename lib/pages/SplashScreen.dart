import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/pages/loginpage.dart';

class furnihomepage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return furnihomepagestate();
  }

}

class furnihomepagestate extends State<furnihomepage>{

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      backgroundColor: Color(0xffe3d8d0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            height: size.height/1.9,
            width: size.width/0.9,
            decoration: const BoxDecoration(
              image:  DecorationImage(
                image:  ExactAssetImage('assets/images/homepagepic.png'),
                fit: BoxFit.fitHeight,
              ),            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,top: 20),
            child: Text("RESELL & REDISCOVER",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: "RobotoSerif"),textAlign: TextAlign.center),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text("Buy and Sell with ease on\nour second-hand furniture app", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),textAlign: TextAlign.center,),
          ),
          Container(
            width: size.width/1,
            height: size.height/7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height/15,
                  width: size.width/2,
                  decoration: BoxDecoration(color: Color(0xff864942), borderRadius: BorderRadius.circular(20)),
                  child:  Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  loginpage()),
                        ); },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0),
                        child: Text('Get Started!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }}