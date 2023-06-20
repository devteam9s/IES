import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ies_flutter_application/view/login.dart';

class SplashServices{

  isLogin(BuildContext context){
    Timer(Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => Login()),(route)=>false);
    });
  }

}