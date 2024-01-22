
import 'package:flutter/material.dart';
import 'package:ies_flutter_application/webservice/rest_api.dart';

import '../models/sensor_report_model.dart';

class ReportsProvider extends ChangeNotifier{

  SensorReportModel? data;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  getListOfSenesorData(Map body){
    debugPrint("Body  :$body");
    RestApi().getListOfGeneratedReports(body).then((value){
      isLoading=false;
      debugPrint(value.toString());
      if(value!=null){
        if(value.records==null){
          isNoData=true;
        }else{
          data=value;
          isLoading= false;
          isError = false;
          isNoData = false;
        }
        notifyListeners();
      }else{
        isNoData=true;
        notifyListeners();
      }
    }).catchError((onError){
      isLoading=false;
      isError=true;
      notifyListeners();
    });
  }
}