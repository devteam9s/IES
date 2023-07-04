import 'package:flutter/material.dart';
import 'package:ies_flutter_application/view/Home.dart';
import 'package:ies_flutter_application/view/splash_screen.dart';

void main(){
  runApp(IesApp());
}

class IesApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IES",
      home:
      Home()
      // SplashScreen(),
    );
  }
}