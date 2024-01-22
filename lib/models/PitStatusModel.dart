class PitStatusModel {
  String? message;
  List<PitStatus>? pitStatus;

  PitStatusModel({this.message, this.pitStatus});

  PitStatusModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Pit Status'] != null) {
      pitStatus = <PitStatus>[];
      json['Pit Status'].forEach((v) {
        pitStatus!.add(new PitStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.pitStatus != null) {
      data['Pit Status'] = this.pitStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PitStatus {
  dynamic payloadC;
  dynamic payloadG;
  dynamic payloadR;
  dynamic payloadV;
  String? pitStatus;
  String? sensorTag;
  String? customerSensorsId;

  PitStatus(
      {this.payloadC,
        this.payloadG,
        this.payloadR,
        this.payloadV,
        this.pitStatus,
        this.sensorTag,
        this.customerSensorsId});

  PitStatus.fromJson(Map<String, dynamic> json) {
    payloadC = json['payload_C'];
    payloadG = json['payload_G'];
    payloadR = json['payload_R'];
    payloadV = json['payload_V'];
    pitStatus = json['pit_status'];
    sensorTag = json['sensor_tag'];
    customerSensorsId = json['customer_sensors_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payload_C'] = this.payloadC;
    data['payload_G'] = this.payloadG;
    data['payload_R'] = this.payloadR;
    data['payload_V'] = this.payloadV;
    data['pit_status'] = this.pitStatus;
    data['sensor_tag'] = this.sensorTag;
    data['customer_sensors_id'] = this.customerSensorsId;
    return data;
  }

}
