class AdminSystemsModel {
  Data? data;

  AdminSystemsModel({this.data});

  AdminSystemsModel.fromJson(Map<String, dynamic> json) {
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
  List<System>? system;

  Data({this.system});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['system'] != null) {
      system = <System>[];
      json['system'].forEach((v) {
        system!.add(new System.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.system != null) {
      data['system'] = this.system!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class System {
  String? id;
  String? systemTag;
  String? operatorId;

  System({this.id, this.systemTag, this.operatorId});

  System.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemTag = json['system_tag'];
    operatorId = json['operator_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['system_tag'] = this.systemTag;
    data['operator_id'] = this.operatorId;
    return data;
  }
}
