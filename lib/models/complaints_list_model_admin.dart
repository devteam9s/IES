class AdminComplaintListModel {
  List<Data>? data;

  AdminComplaintListModel({this.data});

  AdminComplaintListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? systemTag;
  String? sensorTag;
  String? issue;
  String? description;
  String? emailId;
  String? date;
  String? operatorId;
  String? status;
  String? remarks;

  Data(
      {this.id,
        this.systemTag,
        this.sensorTag,
        this.issue,
        this.description,
        this.emailId,
        this.date,
        this.operatorId,
        this.status,
        this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemTag = json['system_tag'];
    sensorTag = json['sensor_tag'];
    issue = json['issue'];
    description = json['description'];
    emailId = json['email_id'];
    date = json['date'];
    operatorId = json['operator_id'];
    status = json['status'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['system_tag'] = this.systemTag;
    data['sensor_tag'] = this.sensorTag;
    data['issue'] = this.issue;
    data['description'] = this.description;
    data['email_id'] = this.emailId;
    data['date'] = this.date;
    data['operator_id'] = this.operatorId;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    return data;
  }
}
