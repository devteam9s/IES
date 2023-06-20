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

    splashServices.isLogin(context);

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
            child: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/temp_splash_logo.jpg"),
                radius: 125,
              ),
            ),
          ),
          const SizedBox(height: 15),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 1,end: 25),
              duration: Duration(seconds: 2),
              builder:(context,double value, child) {
                return Text("IES ",style: GoogleFonts.roboto(fontSize: 20, color: Colors.white,fontWeight:FontWeight.w400),);
              },
          )
        ],
      )
      );
  }
}