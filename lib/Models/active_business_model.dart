class ActiveBusinessModel1 {
  bool? status;
  String? message;
  Data? data;

  ActiveBusinessModel1({this.status, this.message, this.data});

  ActiveBusinessModel1.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic? withdrawal;
  dynamic? withdrawalCount;
  dynamic? deposit;
  dynamic? depositCount;

  Data(
      {this.withdrawal, this.withdrawalCount, this.deposit, this.depositCount});

  Data.fromJson(Map<String, dynamic> json) {
    withdrawal = json['withdrawal'];
    withdrawalCount = json['withdrawal_count'];
    deposit = json['deposit'];
    depositCount = json['deposit_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['withdrawal'] = this.withdrawal;
    data['withdrawal_count'] = this.withdrawalCount;
    data['deposit'] = this.deposit;
    data['deposit_count'] = this.depositCount;
    return data;
  }
}
