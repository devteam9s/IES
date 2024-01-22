
import 'package:flutter/material.dart';
import 'package:ies_flutter_application/webservice/rest_api.dart';

import '../models/customer_list_model.dart';

class CustomerListProvider with ChangeNotifier{

  CustomerListModel? data;
  bool isLoading=true;
  bool isNodata=false;
  bool isError=false;

  getCustomerList(body){
    RestApi().getCustomersList(body).then((value) {
      isLoading=false;
      if(value!=null){
        if(value.data==null){
          isNodata=true;
        }else{
          data=value;
        }
        notifyListeners();
      }else{
        isNodata=true;
        notifyListeners();
      }
    }).catchError((onError){
      isLoading=false;
      isError=true;
      notifyListeners();
    });

  }

}