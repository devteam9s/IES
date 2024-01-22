import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ies_flutter_application/webservice/rest_api.dart';
import 'package:http/http.dart'as http;

import '../models/notification_list_model.dart';
import '../utils/constant.dart';

class NotificationListProvider with ChangeNotifier{

  NotificationListModel? data;
  bool isLoading = true;
  bool isNoData = false;
  bool isError = false;

  bool isFlagLoading = true;
  bool isFlagHasNoData = false;
  bool isFlagError = false;
  String flag = "";

  getNotificationList(body){
    RestApi().getNotificationList(body).then((value) {
      isLoading=false;
      if(value!=null){
        if(value.notifications==null){
          isNoData=true;
        }else{
          data=value;
        }
        notifyListeners();
      }else{
        isNoData=true;
        notifyListeners();
      }
    }).catchError((onError,stackTrace){
      debugPrint(stackTrace.toString());
      isLoading=false;
      isError=true;
      notifyListeners();
    });
  }


  Future<void> getNotificationFlag(String operatorID)async{

    try{
      http.Response response = await http.get(
        Uri.parse("${ApiEndPoints.getNotificationFlag}?operator_id_param=$operatorID"),
        headers:{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'apikey': Constants.apiKey,
          'Authorization': 'Bearer ${Constants.bearerToken}',
        },
      );
      if(response.statusCode==200){
        isFlagLoading = false;
        var res = jsonDecode(response.body);
        flag = res["flag_status"].toString();
        notifyListeners();
      }else{
        isFlagLoading = false;
        isFlagHasNoData = true;
        debugPrint("No response");
      }
    }catch(e,stacktrace){
      isFlagLoading = false;
      isFlagError = true;
      debugPrint(stacktrace.toString());
      rethrow;
    }
  }

}