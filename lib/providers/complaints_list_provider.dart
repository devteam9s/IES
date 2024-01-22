import 'package:flutter/material.dart';

import '../models/complaints_list_model.dart';
import '../webservice/rest_api.dart';

class ComplaintList extends ChangeNotifier{

  ComplaintListModel? data;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  getComplaintList(body){
    RestApi().getComplaints(body).then((value) {
      isLoading=false;
      debugPrint(value.toString());
      if(value!=null){
        if(value.data==null){
          isNoData=true;
        }else{
          data=value;
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