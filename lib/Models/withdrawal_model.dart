class WithdrawalModel {
  bool? status;
  String? message;
  Data? data;

  WithdrawalModel({this.status, this.message, this.data});

  WithdrawalModel.fromJson(Map<String, dynamic> json) {
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
  String? withdrawalAmount;

  Data({this.withdrawalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    withdrawalAmount = json['withdrawal_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['withdrawal_amount'] = this.withdrawalAmount;
    return data;
  }
}
