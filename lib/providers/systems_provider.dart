

import 'package:flutter/material.dart';
import 'package:ies_flutter_application/models/customer_systems.dart';
import 'package:ies_flutter_application/webservice/rest_api.dart';

class SystemsProvider extends ChangeNotifier{
  CustomerSystems? systems;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  getSystemsBasedOnId(var body){
    RestApi().getSystemsBasedOnUserId(body).then((value) {
      isLoading=false;
      if(value!=null){
        if(value.data!.system==null){
          isNoData=true;
          isLoading=false;
        }else{
          systems=value;
          isLoading = false;
          isNoData = false;
          isError = false;
        }
        notifyListeners();
      }else{
        isNoData=true;
        isLoading=false;
        notifyListeners();
      }
    }).catchError((onError){
      isLoading=false;
      isError=true;
      notifyListeners();
    });
  }

}