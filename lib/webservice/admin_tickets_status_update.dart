
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';
import '../view/login.dart';

class UpdateTicketStatus {


  Future<dynamic> updateTicketStatus(context,String customerID,String id,String remarks)async{

    var data = {
      "p_customer_id": customerID,
      "p_ticket_id": id,
      "p_new_status":"solved",
      "p_new_remarks":remarks
    };

    var jdata = jsonEncode(data);

    try{
      http.Response response = await http.post(
          Uri.parse(ApiEndPoints.updateStatusOfTicket),
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Ticket Updated successfully")));

      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Please try again later")));
      }
    }catch(e){
      rethrow;
    }
  }

}