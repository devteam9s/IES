import 'package:flutter/material.dart';

import '../models/complaints_list_model_admin.dart';
import '../webservice/rest_api.dart';

class ComplaintListAdmin extends ChangeNotifier{

  AdminComplaintListModel? data;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  getAdminComplaintList(body){
    RestApi().getAdminComplaints(body).then((value) {
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