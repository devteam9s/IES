

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:ies_flutter_application/utils/constant.dart';
import 'package:ies_flutter_application/view/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/login.dart';

class LoginLogoutState extends ChangeNotifier{

  Future<dynamic> loginUser(context,email,password)async{

    var data = {
      "p_email": email,
      "p_password": password,
    };

    var jdata = jsonEncode(data);

    try{

      var sp = await SharedPreferences.getInstance();

      http.Response response = await http.post(
        Uri.parse(ApiEndPoints.login),
          headers:{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'apikey': Constants.apiKey,
            'Authorization': 'Bearer ${Constants.bearerToken}',
          },
          body:jdata
      );

      if(response.statusCode==200){

        debugPrint("body : "+response.body.toString());
        if(response.body.contains("customer_id")){
          sp.setString("CustomerId", jsonDecode(response.body)["customer_id"]);
        }
        if(response.body.contains("operator_id")){
          sp.setString("OperatorID", jsonDecode(response.body)["operator_id"]);
        }
        debugPrint("contact name${jsonDecode(response.body)["contact_name"]}");
        sp.setString("name", jsonDecode(response.body)["contact_name"]);
        debugPrint("name set successfully");
        sp.setString("Role", jsonDecode(response.body)["role"]);


        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const Home(),));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please try again later")));
      }
    }catch(e){
      rethrow;
    }
  }

  Future<bool> onBackPressed(context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          'Do you  want to Logout the App ?',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'No',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => getlogout(context),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    )) ??
        false;
  }

  getlogout(context) async {
    var sp = await SharedPreferences.getInstance();

    sp.clear();
    sp.remove("CustomerId");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) =>
          //LoadingScreen(),
          Login()),
          (route) => false,
    );
  }

  Future<void>sendDeviceId(String deviceId,String email)async{

    var data={
      "p_email":email,
      "p_device_id": deviceId
    };

    var jdata = jsonEncode(data);


    try{
      http.Response response = await http.post(
          Uri.parse(ApiEndPoints.sendDeviceID),
          headers:{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'apikey': Constants.apiKey,
            'Authorization': 'Bearer ${Constants.bearerToken}',
          },
          body:jdata
      );
      if(response.statusCode==200){
        debugPrint(response.body);
        debugPrint("Device Id sent successfully");
      }else{
        debugPrint("Device Id not sent ");
      }
    }catch(e){
      rethrow;
    }
  }

}