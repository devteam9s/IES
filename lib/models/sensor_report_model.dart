class SensorReportModel {
  List<Records>? records;

  SensorReportModel({this.records});

  SensorReportModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String? id;
  String? topic;
  double? payload;
  String? dateTime;
  String? time;
  String? sensorId;

  Records(
      {this.id,
        this.topic,
        this.payload,
        this.dateTime,
        this.time,
        this.sensorId});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    payload = json['payload'];
    dateTime = json['date_time'];
    time = json['time'];
    sensorId = json['sensor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['payload'] = this.payload;
    data['date_time'] = this.dateTime;
    data['time'] = this.time;
    data['sensor_id'] = this.sensorId;
    return data;
  }
}
