import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ies_flutter_application/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/Home.dart';

class SplashServices{

  var sp = SharedPreferences.getInstance();

    redirectAfter(context) async {
      var sp = await SharedPreferences.getInstance();
      Future.delayed(Duration(seconds: 4), () async {
        if (sp.containsKey("CustomerId")) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                //LoadingScreen(),
                const Home()),
                (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                //LoadingScreen(),
                const Login()),
                (route) => false,
          );
        }
      });
    }
  }
