
import 'package:flutter/widgets.dart';

import '../models/user_dashboard_model.dart';
import '../webservice/rest_api.dart';

class UserDashBoardProvider extends ChangeNotifier{

  UserDashBoardModel? data;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  getUserDashBoardData(var id){
    RestApi().getUserDashBoardData(id).then((value) {
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