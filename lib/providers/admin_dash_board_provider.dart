
import 'package:flutter/cupertino.dart';

import '../models/admin_dash_board_model.dart';
import '../webservice/rest_api.dart';

class AdminDashBoardProvider extends ChangeNotifier{

  AdminDashBoardModel? data;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  getAdminDashBoardData(){
    RestApi().getAdminDashBoardData().then((value) {
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