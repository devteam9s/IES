

import 'package:flutter/material.dart';
import 'package:ies_flutter_application/models/customer_systems.dart';
import 'package:ies_flutter_application/webservice/rest_api.dart';

class SystemsProvider extends ChangeNotifier{
  CustomerSystems? systems;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;


  getSystemsBasedOnId(var body){
    RestApi.getSystemsBasedOnUserId(body).then((value) {
      isLoading=false;
      if(value!=null){
        if(value.data!.system!.isEmpty){
          isNoData=true;
        }else{
          systems=value;
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