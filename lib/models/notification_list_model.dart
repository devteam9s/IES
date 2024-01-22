class NotificationListModel {
  List<Notifications>? notifications;

  NotificationListModel({this.notifications});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? topic;
  String? payload;
  String? dateTime;
  String? sensorId;
  String? systemId;
  String? operatorId;
  String? operatorEmail;
  String? notificationId;

  Notifications(
      {this.topic,
        this.payload,
        this.dateTime,
        this.sensorId,
        this.systemId,
        this.operatorId,
        this.operatorEmail,
        this.notificationId});

  Notifications.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    payload = json['payload'];
    dateTime = json['date_time'];
    sensorId = json['sensor_id'];
    systemId = json['system_id'];
    operatorId = json['operator_id'];
    operatorEmail = json['operator_email'];
    notificationId = json['notification_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic'] = this.topic;
    data['payload'] = this.payload;
    data['date_time'] = this.dateTime;
    data['sensor_id'] = this.sensorId;
    data['system_id'] = this.systemId;
    data['operator_id'] = this.operatorId;
    data['operator_email'] = this.operatorEmail;
    data['notification_id'] = this.notificationId;
    return data;
  }
}
