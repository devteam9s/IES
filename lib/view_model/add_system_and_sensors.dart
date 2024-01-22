

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

import '../utils/constant.dart';

class AddSensorsAndSystems extends ChangeNotifier{

  Future<dynamic> addSystems(context,String id,String operatorID,String isActive,String name)async{

    var data = {
      "p_customer_id":id,
      "p_is_active":isActive,
      "p_system_tag":name,
      "p_operator_id":operatorID,
    };

    var jdata = jsonEncode(data);

    try{

      http.Response response = await http.post(
          Uri.parse(ApiEndPoints.addSystem),
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

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('System added'),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);

      }else{

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please try again later")));
      }
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> addSensors(context,String systemId,String sensorTag,String isActive,String customerId,String operatorID)async{

    // var data = {
    //   "p_system_id":systemId,
    //   "p_sensor_id":sensorId,
    //   "p_is_active":isActive,
    //   "p_customer_id":customerId
    // };

    var data = {
      "p_system_id":systemId,
      "p_is_active":isActive,
      "p_customer_id":customerId,
      "p_operator_id":operatorID,
      "p_sensor_tag":sensorTag
    };


    var jdata = jsonEncode(data);

    try{

      http.Response response = await http.post(
          Uri.parse(ApiEndPoints.addSensors),
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

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Sensor Successfully added")));
        Navigator.pop(context);

      }else{

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please try again later")));
      }
    }catch(e){
      rethrow;
    }
  }


}