import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/pages/Profile_page.dart';
import 'package:furnitureapp/pages/Registration.dart';
import 'package:furnitureapp/pages/onBoardingpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Validation/Validator.dart';
import '../components/TextFormField.dart';
import 'ForgotPassword.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]
);

class loginpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginpagestate();
  }
}

class loginpagestate extends State<loginpage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  bool isloading = false;
  bool loggedIn = false;
  bool _obscureText = true;
  readfromstorage() async {
    //get
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.get('email');
    var password = prefs.get('password');
    if (email == null) {
      //stay idle
    } else {
      emailcontroller.text = email.toString();
      passwordcontroller.text = password.toString();
      //loading
      setState(() {
        isloading = true;
      });
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    readfromstorage();
    _checkAuthenticated();
  }
  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(context, CupertinoPageRoute(builder: (_) => OnBoardingPage()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successful'),
            backgroundColor: Colors.brown,
          ),
        );
      } else {
        print("Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print("Invalid Email or Password");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid Email or Password'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  _checkAuthenticated() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          loggedIn = false;
        });
      } else {
        setState(() {
          loggedIn = true;
        });
      }
    });
  }
  void handleLogout() async {
    await FirebaseAuth.instance.signOut();
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBoardingPage()));
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential) ;
  }

  //for validation
void validate (){
  formkey.currentState!.save();
  if(formkey.currentState!.validate()){
      print("Validated");
      signIn();
    }
    else{
      print("Not Validated");
    }
}


  @override
    Widget build(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      // TODO: implement build
      //throw UnimplementedError();
      return Scaffold(
        backgroundColor: Color(0xffe3d8d0),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/app_logo.png', height: size.height/4,),
                    Center(
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: "RobotoSerif"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width/1.1,
                      child: MyTextFormField(
                        controller: emailcontroller,
                        hintText: 'Email',
                        validator: Validator.validateEmail,

                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: passwordcontroller,
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
                      height: 10,
                    ),
                    // forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgetPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text('FORGET PASSWORD?',
                              style: TextStyle(fontFamily: 'Inika',color: Colors.grey[500]), ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: validate,
                          child: Container(
                            height: size.height / 15,
                            width: size.width / 2,
                            decoration: BoxDecoration(
                                color: Color(0xff864942),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inika',
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        )),
                        Text(
                          'OR',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: "Inika"),
                        ),
                        Expanded(child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        )),
                      ],
                    ),
                    SizedBox(height: 40,),
                    Container(
                      height: size.height / 15,
                      width: size.width / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffffffff),
                      ),
                      child: Center(
                          child: GestureDetector(
                            onTap: () {
                              signInWithGoogle();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google_icon.png',
                                  height: 30,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontFamily: "Inika"),
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Dont have an account?',
                              style: TextStyle(
                                  fontFamily: 'Inika',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        SizedBox(width: 5,),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationScreen()),
                              );
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontFamily: 'Inika',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff864942)),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
