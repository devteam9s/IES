import 'package:flutter/cupertino.dart';

import '../models/mqtt_rest_api_data.dart';
import '../webservice/rest_api.dart';

class MqttDataRestProvider extends ChangeNotifier{

  MqttRestApiData? pData;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  getMqttData(data){
    RestApi().getMqttDataFromRestApi(data).then((value) {
      isLoading=false;
      debugPrint(value.toString());
      if(value!=null){
        if(value.latestValues==null){
          isNoData=true;
        }else{
          pData=value;
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