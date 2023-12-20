import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//authentication instance
final FirebaseAuth _auth = FirebaseAuth.instance;

class registration extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return registrationstate();
  }
}
class registrationstate extends State<registration>{
  //variables declared
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late bool _success;
  late String _userEmail;

  //method
  void _register() async{
    final User? user = (
    await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
    ).user;

    if (user != null){
      setState(() {
        _success = true;
        _userEmail = user.email!;
      });
    }else{
      setState(() {
        _success = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height:70 ,),
              SizedBox(height: 0,),
              Text('Let’s get started', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.black, fontFamily: 'Inika'),),
              Text('Enter your credentials to continue', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, fontFamily: 'Inika'),),
              SizedBox(height: 15,),
              Column(
                children: [
                  Container(
                    height: 50,
                    width: size.width/1.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.person),
                        labelText: 'Your Name *',
                      ),
                    ),
                  ),
                  // SizedBox(height: 10,),
                  // Container(
                  //   height: 50,
                  //   width: size.width/1.1,
                  //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                  //   child: TextField(
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       icon: Icon(Icons.place),
                  //       labelText: 'Address *',
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 10,),
                  Container(
                    height: 50,
                    width: size.width/1.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.email),
                        labelText: 'Email *',
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  // Container(
                  //   height: 50,
                  //   width: size.width/1.1,
                  //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                  //   child: TextField(
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       icon: Icon(Icons.call),
                  //       labelText: 'Phone*',
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10,),
                  Container(
                    height: 50,
                    width: size.width/1.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.lock),
                        labelText: 'Password*',
                      ),
                      
                    ),
                  ),
                  SizedBox(height: 25,),
                  GestureDetector(
                    onTap: () async{
                      _register();
                    },
                    child: Container(
                      height: size.height/15,
                      width: size.width/1.5,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xfffaa04e)),
                      child:
                      Center(child: Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),

    );
  }

}