class ActiveBusinessModel {
  String? msg;
  bool? status;
  Data? data;

  ActiveBusinessModel({this.msg, this.status, this.data});

  ActiveBusinessModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? depositAmount;
  String? withdrawalAmount;

  Data({this.depositAmount, this.withdrawalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    depositAmount = json['deposit_amount'];
    withdrawalAmount = json['withdrawal_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deposit_amount'] = this.depositAmount;
    data['withdrawal_amount'] = this.withdrawalAmount;
    return data;
  }
}
