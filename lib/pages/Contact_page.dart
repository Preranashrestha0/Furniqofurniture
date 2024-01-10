import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/components/square_tile.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _messagecontroller = TextEditingController();
  List<String> listItem = ['Bug' , 'Feedback'];
  String? valueChoose;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, size: 40, color: Colors.pinkAccent,),
            onPressed: () {
              Navigator.pop(context); // shows current page when the icon is pressed
            },
          ),
          title: Text("Contact Us", style:
          TextStyle(color: Colors.pinkAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoSerif'),
          ),
          centerTitle: true),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(left: 15, right: 5, top: 20),
              height: size.height/2,
              width: size.width/1.09,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // message type
                  Text('Message Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),

                  const SizedBox(height: 10,),

                  // select your message type
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      hint: Text('Select your message type'),
                      dropdownColor: Colors.pinkAccent,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      isExpanded: true,
                      underline: SizedBox(),
                      value: valueChoose,
                      onChanged: (newValue){
                        setState(() {
                          valueChoose = newValue!;
                        });
                      },
                      items: listItem.map((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),);
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  // Message
                  Text('Message', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),

                  const SizedBox(height: 10),

                  // type your message here.....
                  TextField(
                    controller: _messagecontroller,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder( // will be displayed when clicked on the text field
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Type your message here...', // hint to the user what should they type in this text
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      //contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    minLines: 3, // Adjust these values to increase/decrease the height
                    maxLines: 4,
                  ),

                  const SizedBox(height: 20,),

                  // Send your queries button
                  Center(
                    child: MaterialButton(onPressed: () async{
                      if(_messagecontroller.text.isNotEmpty ){
                        FirebaseFirestore.instance.collection('queries').add(
                            {
                              'messageType':valueChoose,
                              'message': _messagecontroller.text,
                            });
                      }
                    },
                      color: Colors.pinkAccent,
                      height: 50.0,
                      minWidth: 600.0,
                      child: Text(
                        'Send Your Queries',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),

            // another container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              margin: EdgeInsets.only(left: 15, right: 5, top: 20),
              height: size.height/5,
              width: size.width/1.09,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Text('For instant query reach us through',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      SquareTile(imagepath: 'assets/images/google_icon.png', onTap: () {},),
                      const SizedBox(width: 10,),
                      SquareTile(imagepath: 'assets/images/google_icon.png', onTap: () {},),
                      const SizedBox(width: 10,),
                      SquareTile(imagepath: 'assets/images/google_icon.png', onTap: () {},),


                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
