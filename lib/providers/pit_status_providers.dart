import 'package:flutter/cupertino.dart';

import '../models/PitStatusModel.dart';
import '../webservice/rest_api.dart';

class PitStatusProvider extends ChangeNotifier {
  PitStatusModel? allPitModel;
  bool isLoading = true;
  bool isNoData = false;
  bool isError = false;

  PitStatusModel? activePitModel;
  PitStatusModel? criticalPitModel;
  PitStatusModel? inactivePitModel;

  String? customerId;

  getPitStatus(data) {
    RestApi().getPitStatus(data).then((value) {
      isLoading = false;
      debugPrint("status provider is : " + value.toString());
      if (value != null) {
        if (value.pitStatus == null) {
          isNoData = true;
        } else {
          debugPrint(
              "Value from api for ${data["status_filter"]} : ${value.pitStatus!.length.toString()}");
          if (data["status_filter"] == "Active") {
            activePitModel = value;
          } else if (data["status_filter"] == "Inactive") {
            inactivePitModel = value;
          } else if (data["status_filter"] == "Critical") {
            criticalPitModel = value;
          } else {
            allPitModel = value;
          }
        }
        notifyListeners();
      } else {
        isNoData = true;
        notifyListeners();
      }
    }).catchError((onError) {
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }
}
