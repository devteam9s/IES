class CustomerListModel {
  List<Data>? data;

  CustomerListModel({this.data});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
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
  String? operatorId;
  String? mobileNo;
  String? contactName;
  String? email;
  String? role;

  Data(
      {this.operatorId,
        this.mobileNo,
        this.contactName,
        this.email,
        this.role});

  Data.fromJson(Map<String, dynamic> json) {
    operatorId = json['operator_id'];
    mobileNo = json['mobile_no'];
    contactName = json['contact_name'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operator_id'] = this.operatorId;
    data['mobile_no'] = this.mobileNo;
    data['contact_name'] = this.contactName;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
