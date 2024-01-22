
import 'package:flutter/material.dart';

import '../models/sensor_model.dart';
import '../webservice/rest_api.dart';

class SensorProvider extends ChangeNotifier{

  SensorModel? sensor;
  bool isLoading=true;
  bool isNoData=false;
  bool isError=false;

  // Mqtt connect here..


  getSensorsBasedOnSystem(var body){
    RestApi().getSensorsBasedOnSystemId(body).then((value) {
      isLoading=false;
      debugPrint(value.toString());
      if(value!=null){
        if(value.data!.sensor!.isEmpty){
          isNoData=true;
        }else{
          sensor=value;
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

