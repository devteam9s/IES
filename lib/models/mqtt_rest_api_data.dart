class MqttRestApiData {
  String? sensorId;
  String? customerId;
  LatestValues? latestValues;

  MqttRestApiData({this.sensorId, this.customerId, this.latestValues});

  MqttRestApiData.fromJson(Map<String, dynamic> json) {
    sensorId = json['sensor_id'];
    customerId = json['customer_id'];
    latestValues = json['latest_values'] != null
        ? new LatestValues.fromJson(json['latest_values'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sensor_id'] = this.sensorId;
    data['customer_id'] = this.customerId;
    if (this.latestValues != null) {
      data['latest_values'] = this.latestValues!.toJson();
    }
    return data;
  }
}

class LatestValues {
  dynamic c;
  dynamic g;
  dynamic r;
  dynamic v;

  LatestValues({this.c, this.g, this.r, this.v});

  LatestValues.fromJson(Map<String, dynamic> json) {
    c = json['C'];
    g = json['G'];
    r = json['R'];
    v = json['V'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C'] = this.c;
    data['G'] = this.g;
    data['R'] = this.r;
    data['V'] = this.v;
    return data;
  }
}
