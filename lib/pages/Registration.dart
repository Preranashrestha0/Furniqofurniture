import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/Validation/Validator.dart';
import 'package:furnitureapp/components/TextFormField.dart';
import 'package:furnitureapp/pages/loginpage.dart';

import 'UserForm.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  signUp()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>UserForm()));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Registration Successful'),
            )
        );
      }
      else{
        print( "Something is wrong");
      }

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Please enter required fields'),
          )
      );
      if (e.code == 'weak-password') {
        print("The password provided is too weak.");

      } else if (e.code == 'email-already-in-use') {
        print( "The account already exists for that email.");

      }
    } catch (e) {
      print(e);
    }
  }

  //for validation
  void validate (){
    if(formkey.currentState!.validate()){
      print("Validated");
      signUp();
    }
    else{
      print("Not Validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffe3d8d0),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              //width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.light,
                        color: Colors.transparent,
                      ),
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22, color: Color(0xff864942)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                //width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Welcome!",
                            style: TextStyle(
                                fontSize: 22, color: Color(0xff864942)),
                          ),
                          Text(
                            "Glad to see you back.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFBBBBBB),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MyTextFormField(
                              controller: _emailController,
                              hintText: 'Email',
                            validator: Validator.validateEmail,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              validator: Validator.validatePassword,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown),
                                ),
                                fillColor: Color(0xfff2eded),
                                filled: true,
                                hintText: "  Password",
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                suffixIcon: _obscureText
                                    ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                  ),
                                )
                                    : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 50,
                          ),
                          // elevated button
                          Center(
                            child: SizedBox(
                              width: size.width/2,
                              height: 56,
                              child: ElevatedButton(
                                onPressed:validate,
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff864942),
                                  elevation: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Wrap(
                            children: [
                              Text(
                                "Have an account?",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFBBBBBB),
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  " Sign In",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff864942),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => loginpage()));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

