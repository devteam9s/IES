import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ies_flutter_application/models/customer_systems.dart';
import 'package:ies_flutter_application/utils/constant.dart';


class RestApi{
 static Future<CustomerSystems>  getSystemsBasedOnUserId(var body)async{
    final response = await http
        .post(Uri.parse(ApiEndPoints.customerSystems),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'apikey':'${Constants.apiKey}',
      'Authorization': 'Bearer ${Constants.bearerToken}',
    },body: json.encode(body)).catchError((onError){
      debugPrint("Error is "+onError.toString());
    });

    if (response.statusCode == 200) {
      return CustomerSystems.fromJson(jsonDecode(response.body)) ;
    } else {

      throw Exception('Failed to load data');
    }

  }

  Future getSensorsBasedOnSystemId(var systemId)async{
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer token here',
    });

    if (response.statusCode == 200) {

      //Album.fromJson(jsonDecode(response.body))
      return ;
    } else {

      throw Exception('Failed to load album');
    }

  }
}