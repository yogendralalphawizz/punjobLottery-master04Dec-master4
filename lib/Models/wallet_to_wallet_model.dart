class WalletToWalletTransferModel {
  String? msg;
  bool? status;
  List<Data>? data;

  WalletToWalletTransferModel({this.msg, this.status, this.data});

  WalletToWalletTransferModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userName;
  String? email;
  String? referredBy;
  String? referralCode;

  Data(
      {this.userId,
        this.userName,
        this.email,
        this.referredBy,
        this.referralCode});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    email = json['email'];
    referredBy = json['referred_by'];
    referralCode = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['referred_by'] = this.referredBy;
    data['referral_code'] = this.referralCode;
    return data;
  }
}
