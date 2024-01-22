
class UserDashBoardModel {
  Data? data;

  UserDashBoardModel({this.data});

  UserDashBoardModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalSensors;
  int? activeSensors;
  int? inactiveSensors;

  Data({this.totalSensors, this.activeSensors, this.inactiveSensors});

  Data.fromJson(Map<String, dynamic> json) {
    totalSensors = json['total_sensors'];
    activeSensors = json['active_sensors'];
    inactiveSensors = json['inactive_sensors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_sensors'] = this.totalSensors;
    data['active_sensors'] = this.activeSensors;
    data['inactive_sensors'] = this.inactiveSensors;
    return data;
  }
}
