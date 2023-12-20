import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/pages/Registration.dart';
import 'package:furnitureapp/pages/demopage.dart';
import 'package:furnitureapp/pages/mainpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  bool isloading = false;

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
      //loginsuccess
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => mainpage()),
      //   );
    }
    // Navigator.of(context).pushNamed('/newsui', arguments: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readfromstorage();
  }
    void SignInUser() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text);

        print("Login Successfully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  mainpage()),
        );

      } on FirebaseAuthException catch (e) {
        print("Error");
      }
    }

    void checkAuthState() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          // User is signed out
          // TODO: Update UI accordingly (e.g., stay on the login screen)
        } else {
          // User is signed in
          // TODO: Update UI accordingly (e.g., navigate to the home screen)
        }
      });
    }
    void handleLogout() async {
      await FirebaseAuth.instance.signOut();
      // TODO: Update UI accordingly (e.g., navigate back to the login screen)
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

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
    Widget build(BuildContext context) {
      var size = MediaQuery
          .of(context)
          .size;
      // TODO: implement build
      //throw UnimplementedError();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Center(child: Text("LOGIN", textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white),)),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 50),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         'assets/images/logo.png',
                //         height: 60,
                //       ),
                //     ],
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: "RobotoSerif"),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: size.height / 10,
                  width: size.width,
                  margin: EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email *',
                    ),
                    controller: emailcontroller,
                  ),
                ),
                Container(
                  height: 70,
                  width: size.width,
                  margin: EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password *',
                    ),
                    controller: passwordcontroller,
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (emailcontroller.text.isNotEmpty &&
                            passwordcontroller.text.isNotEmpty) {
                          if (emailcontroller.text.contains('@')) {
                            print('Validated');
                            SignInUser();
                          } else {
                            print('Invalid email address.');
                          }
                        } else {
                          print("Please fillup all the required fields!!");
                        }
                        //}
                      },
                      child: Container(
                        height: size.height / 12,
                        width: size.width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xfff3a65e),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
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
                Container(
                  height: size.height / 15,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfff2eded),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google_icon.png',
                        height: 20,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Center(
                          child: ElevatedButton(
                            onPressed: () {
                              signInWithGoogle();
                            },
                            child: Text(
                              "Sign in with Google",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: "Inika"),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   height: size.height / 15,
                //   width: size.width / 1.2,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Color(0xff4267b2),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         'assets/images/facebook_icon.png',
                //         height: 40,
                //       ),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       Center(
                //           child: Text(
                //             "Sign in with Facebook",
                //             style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.normal,
                //                 color: Colors.white,
                //                 fontFamily: "Inika"),
                //           )),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 50,
                // ),
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
                    Container(
                      height: 20,
                      width: 60,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registration()),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'Inika',
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Color(0xffFAA04E)),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
