import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ies_flutter_application/view_model/splash_services.dart';

import '../res/colors.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<double> animation;
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration:const Duration(seconds:2));
    animation=CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationController.forward();

    splashServices.redirectAfter(context);

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appThemeColor,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularRevealAnimation(
            animation: animation,
            child: Center(
              child:Container(
                height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(200))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset("assets/Soukhya_logo.png"),
                  )),
            ),
          ),
        ],
      )
      );
  }
}