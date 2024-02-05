class ReferalsDetailsModel {
  String? msg;
  bool? status;
  Data? data;

  ReferalsDetailsModel({this.msg, this.status, this.data});

  ReferalsDetailsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic? depositAmount;
  dynamic? withdrawalAmount;
  dynamic? refferalAmount;
  dynamic? refferalCount;
  List<RefferalData>? refferalData;

  Data(
      {this.depositAmount,
        this.withdrawalAmount,
        this.refferalAmount,
        this.refferalCount,
        this.refferalData});

  Data.fromJson(Map<String, dynamic> json) {
    depositAmount = json['deposit_amount'];
    withdrawalAmount = json['withdrawal_amount'];
    refferalAmount = json['refferal_amount'];
    refferalCount = json['refferal_count'];
    if (json['refferal_data'] != null) {
      refferalData = <RefferalData>[];
      json['refferal_data'].forEach((v) {
        refferalData!.add(new RefferalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deposit_amount'] = this.depositAmount;
    data['withdrawal_amount'] = this.withdrawalAmount;
    data['refferal_amount'] = this.refferalAmount;
    data['refferal_count'] = this.refferalCount;
    if (this.refferalData != null) {
      data['refferal_data'] =
          this.refferalData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefferalData {
  String? userName;
  String? email;
  String? mobile;
  dynamic? image;
  String? joiningData;

  RefferalData(
      {this.userName, this.email, this.mobile, this.image, this.joiningData});

  RefferalData.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
    mobile = json['mobile'];
    image = json['image'];
    joiningData = json['joining_Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['joining_Data'] = this.joiningData;
    return data;
  }
}
