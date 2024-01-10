import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailcontroller = TextEditingController();

  @override
  void dispose(){
    emailcontroller.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text('Password reset link sent! check your email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Enter your email and we will send you a password reset link.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          SizedBox(height: 20),
          // username textfield
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
          controller: emailcontroller, // to access what user typed into the text field
          obscureText: false, // this is applied to hide the character when typing the password
          decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder( // will be displayed when clicked on the text field
          borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Email", // hint to the user what should they type in this text
          hintStyle: TextStyle(color: Colors.grey[500]),
    ),
    ),
    ),
          SizedBox(height: 10),
          MaterialButton(onPressed: passwordReset,
            child: Text('Reset Password'),
            color: Colors.pinkAccent,)
        ],
      ),
    );
  }
}