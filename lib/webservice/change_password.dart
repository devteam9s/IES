
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';
import '../view/login.dart';

class ChangePassword {


  Future<dynamic> changePassword(context,String email,String pass,String confPass)async{

    var data = {
      "p_email": email,
      "p_confirm_password": confPass,
      "p_new_password":pass
    };

    var jdata = jsonEncode(data);

    try{
      http.Response response = await http.post(
          Uri.parse(ApiEndPoints.changeOtp),
          headers:{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'apikey': Constants.apiKey,
            'Authorization': 'Bearer ${Constants.bearerToken}',
          },
          body:jdata
      );
      if(response.statusCode==200){

        debugPrint(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Password reset successfull")));

        Navigator.push(context, MaterialPageRoute(builder:(context) => const Login(),));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please try again later")));
      }
    }catch(e){
      rethrow;
    }
  }

}