import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/pages/Registration.dart';
import 'package:furnitureapp/pages/loginpage.dart';
import 'package:furnitureapp/pages/mainpage.dart';

class RouteGen{
  static Route<dynamic> generateRoute(RouteSettings settings){
    //final object arg = settings.arguments;
    switch (settings.name){
      case '/': //map sample
        return MaterialPageRoute(builder: (_) => loginpage());
      case '/mainpage':
        return MaterialPageRoute(builder: (_) => mainpage());
      case '/registration':
        return MaterialPageRoute(builder: (_) => registration());
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(child: Text('ERROR'),),
      );
    }
    );
  }
}