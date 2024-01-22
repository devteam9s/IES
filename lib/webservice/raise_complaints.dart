
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../utils/constant.dart';

class RaiseComplaints{

  Future<void> raiseComplaints(BuildContext context,site,pit,issue,desc,email,date,oId)async{

    var data = {
      "p_system_tag":site,
      "p_sensor_tag":pit,
      "p_issue":issue,
      "p_description":desc,
      "p_email_id":email,
      "p_date":date,
      "p_operator_id":oId
    };

    var jData = jsonEncode(data);

    debugPrint(data.toString());

    try{
      http.Response response = await http.post(
          Uri.parse(ApiEndPoints.raiseComplaint),
          headers:{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'apikey': Constants.apiKey,
            'Authorization': 'Bearer ${Constants.bearerToken}',
          },
          body:jData
      );
      if(response.statusCode==200){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Complaint Raised successfully"),
        ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong try again later"),
        ));
      }
    }catch(e){
      rethrow;
    }
  }
}