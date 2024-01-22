import 'package:ies_flutter_application/models/mqtt_data.dart';

class SensorModel {
  Data? data;

  SensorModel({this.data});

  SensorModel.fromJson(Map<String, dynamic> json) {
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
  List<Sensor>? sensor;

  Data({this.sensor});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sensor'] != null) {
      sensor = <Sensor>[];
      json['sensor'].forEach((v) {
        sensor!.add(new Sensor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sensor != null) {
      data['sensor'] = this.sensor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sensor {
  String? id;
  String? topic;

  MQTTData? mqttData = MQTTData();

  Sensor({this.id, this.topic});

  Sensor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    return data;
  }
}
