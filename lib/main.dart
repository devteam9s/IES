import 'package:flutter/material.dart';
import 'package:ies_flutter_application/providers/systems_provider.dart';
import 'package:ies_flutter_application/view/Home.dart';
import 'package:ies_flutter_application/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(IesApp());
}

class IesApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [  ChangeNotifierProvider<SystemsProvider>( create: (context) => SystemsProvider()),],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "IES",
        home:
        Home()
        // SplashScreen(),
      ),
    );
  }
}