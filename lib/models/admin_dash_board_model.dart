
class AdminDashBoardModel {
  Data? data;

  AdminDashBoardModel({this.data});

  AdminDashBoardModel.fromJson(Map<String, dynamic> json) {
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
  int? totalCustomers;
  int? activeCustomers;
  int? inactiveCustomers;

  Data({this.totalCustomers, this.activeCustomers, this.inactiveCustomers});

  Data.fromJson(Map<String, dynamic> json) {
    totalCustomers = json['total_customers'];
    activeCustomers = json['active_customers'];
    inactiveCustomers = json['inactive_customers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_customers'] = this.totalCustomers;
    data['active_customers'] = this.activeCustomers;
    data['inactive_customers'] = this.inactiveCustomers;
    return data;
  }
}
