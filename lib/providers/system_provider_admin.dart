import 'package:flutter/material.dart';
import 'package:ies_flutter_application/models/customer_systems.dart';
import 'package:ies_flutter_application/webservice/rest_api.dart';

import '../models/admin_systems.dart';

class AdminSystemsProvider extends ChangeNotifier{
  AdminSystemsModel? systems;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  getSystemsBasedOnCustomerId(var body){
    RestApi().getSystemsBasedOnCustomerId(body).then((value) {
      isLoading=false;
      if(value!=null){
        if(value.data==null){
          isNoData=true;
          isLoading=false;
        }else{
          systems=value;
          isLoading=false;
          isNoData=false;
          isError=false;
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